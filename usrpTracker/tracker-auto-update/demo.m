
%function demo
function [ output_args ] = demo( ch, auto_scroll,timeout,handles)

    fprintf('CHANNEL = %d\n',ch);
    %freq=2412+5*(str2num(ch)-1);
    freq=2412+5*(ch-1);

    fprintf('FREQ=%d\n',freq);
    decim = 8;
    gain = 28;
    filename =sprintf('f%d_d8_g28.raw',freq);

    % quanti secondi di traccia analizzare (per ogni loop)
    T = 10e-3;

    % noise calibration
    % 	PHASE = 0;
    % energy-based packet detection
    PHASE = 1;

    % DEBUG = false;
    DEBUG = true;

    USRP = 1;
    % 	USRP = 2;

    switch USRP
        case 1
            % la USRP1 aquisisce a 64Ms e 12bit per campione
            fs_raw = 64e6;
            fix_to_float = 1/2^4;
            switch gain
                case 28
                    noise_var_usrp = (32/decim)*0.5636-0.045;
                case 34
                    noise_var_usrp = (32/decim)*0.7879-0.245;
            end
        case 2
            % la USRP2 aquisisce a 100Ms e 14bit per campione
            fs_raw = 100e6;
            fix_to_float = 1/2^6;
            % 			noise_var_est = ???;
    end
    fs = fs_raw/decim;
    Ts = 1/fs;
    fprintf('[-] Ts: %g ns (%g samples/us)\n',Ts*1e9,1e-6/Ts);
    N = round(T*fs);
    fprintf('[-] will read %g samples per loop\n',N);

    % leggi il file e stampa la stima di valore medio, varianza (e
    % deviazione standard) e test di gaussianit�
    if PHASE == 0

        fclose('all');
        fid = fopen(filename,'r');
        fseek(fid,2*N*2,'bof'); % *2: int16, *2: I,Q
        i_pippo=0;
        while true
            i_pippo=i_pippo+1;
            fprintf('%u',i_pippo);
            % acquire a segment
            [r_raw,Nr] = fread(fid,2*N,'int16');
            if Nr<2*N
                break
            end
            r = fix_to_float*(r_raw(1:2:end)+1i*r_raw(2:2:end));

            sample = [real(r);imag(r)];
            ind = find(sample<0);
            sample(ind) = sample(ind) - fix_to_float;
            r_avg = mean(sample);
            r_stddev = std(sample);
            display([r_avg,r_stddev.^2])
            pause
        end
        fclose('all');

    end

    % leggi il file e calcola gli IFS
    if PHASE == 1
        NF_dB_typ = 6;
        T_amb = 25;
        noise_var_theory = 1.38e-23*(273+T_amb)*fs*10^(NF_dB_typ/10);
        dB_to_dBm = 30;
        fprintf('noise level: %gdBm\n',...
            10*log10(noise_var_theory)+dB_to_dBm);

        % la USRP ha un fattore di conversione interi<->livello che
        % determiniamo a partire dalle misure sul rumore
        theory_to_usrp = 10*log10(noise_var_usrp/noise_var_theory);
        sigma_n = sqrt(noise_var_usrp);
        s_to_us = 1e6;
        s_to_ms = 1e3;

        % parametri 'arbitrari'
        t = (0:N-1)*Ts;

        % la potenza istantanea viene filtrata con un filtro AR del primo
        % ordine con costante di tempo 1us: h_k = (1-alpha)*alpha^k
        % (l'espressione � ottenuta col metodo dell'invarianza all'impulso)
        alpha = exp(-Ts/0.5e-6);
        r2_filt_b = 1-alpha;
        r2_filt_a = [1,-alpha];
        r2_filt_z = [];

        % parametri del classificatore:
        % probabilit� di 'falso allarme' nell'energy detection
        p_false_pkt = 1e-6;
        % se n � N(0,sigma)+1i*N(0,sigma), |n|^2 � expon con media 2*sigma^2
        r2_pkt_thres = -2*sigma_n^2*log(p_false_pkt);
        % durata minima di un pacchetto per eliminare i falsi
        pkt_min_duration = 5e-6;

        % stato del classificatore
        search_state = 0;
        % quanti pacchetti visti sinora
        n_pkt = 0;
        % istante finale dell'ultimo pacchetto visto (per calcolare gli IFS)
        pkt_t_fin_prev = T;

        % collezione delle durate dei pacchetti e degli IFS
        logsize = 1024;
        
        ifs_log = zeros(1,logsize);
        pkt_log = zeros(1,logsize);

        % open the file (and skip the first segment)
        tic
        fclose('all');
        fid = fopen(filename,'r');
        fseek(fid,2* N*2,'bof'); % 2*: I,Q; *2: int16
        t0 = T;

        setappdata(handles.tracker, 'run', true);   % here or somewhere else...
        pktlogs=[];
        pktinfoData=[];
        
        while true
            
            % allow infinite loop on the same file
            % fabrizio 21030521-usa 
            if n_pkt == logsize - 1
                fclose('all');
                fid = fopen(filename,'r');
                fseek(fid,2* N*2,'bof'); % 2*: I,Q; *2: int16
                t0 = T;
                n_pkt = 0;
            end
            % end fabrizio 21030521-usa
            
            % acquire a segment
            [r_raw,Nr] = fread(fid,2*N,'int16');
            if Nr<2*N
                break
            end
            r = fix_to_float*(r_raw(1:2:end)+1i*r_raw(2:2:end));
            r2 = r.*conj(r);

            % la classificazione viene effettuata sulla versione filtrata della
            % potenza istantanea
            [r2_filt,r2_filt_z] = filter(r2_filt_b,r2_filt_a,r2,r2_filt_z);

            if DEBUG

                hold off
                plot(handles.tracker,t*s_to_us,10*log10(r2)...
                    -theory_to_usrp+dB_to_dBm,':');

                hold on
                plot(handles.tracker,t*s_to_us,10*log10(r2_filt)...
                    -theory_to_usrp+dB_to_dBm,'-');
                plot(handles.tracker,[t(1),t(end)]*s_to_us,...
                    10*log10(r2_pkt_thres)*[1,1]...
                    -theory_to_usrp+dB_to_dBm,'r--');
                ylabel('RSSI  [dBm]')
                xlabel('Time [us]')
                set(gca,'YLim',[-100,-40])
                grid on
                drawnow
            end

            % rivela la presenza dei pacchetti, e determina gli IFS
            for n = 1:N

                if getappdata(handles.tracker, 'run') == false
                    return
                end
                switch search_state
                    case 0 % rumore
                        % la soglia per decidere che c'� un pacchetto �
                        % stabilita in base alla varianza del rumore
                        % gaussiano (che viene superata ancora pi�
                        % raramente visto il filtro AR; |r|^2 �
                        % esponenziale, r2_filt � un processo esponenziale
                        % iid filtrato, cio�? circa gaussiano intorno al
                        % valore medio, non esponenziale... quindi il
                        % calcolo della r2_pkt_thres � sbagliato)
                        if r2_filt(n) > r2_pkt_thres
                            pkt_t_ini = t0 + t(n);
                            search_state = 1; % pacchetto
                            % accumula energia e durata del pacchetto 
                            pkt_energy = r2(n);
                            pkt_energy_len = 1;
                        end
                    case 1 % pacchetto
                        pkt_energy = pkt_energy + r2(n);
                        pkt_energy_len = pkt_energy_len + 1;
                        if r2_filt(n) < r2_pkt_thres/2 ...
                                && pkt_energy_len * Ts < pkt_min_duration
                            search_state = 0;
                        else
                            if pkt_energy_len * Ts > pkt_min_duration
                                pkt_power = pkt_energy/pkt_energy_len;
                                r2_pkt_endthres = 0.1 * pkt_power;

                                if r2_filt(n) < r2_pkt_endthres

                                    pkt_t_fin = t0 + t(n);
                                    %fprintf('power: %g \n',10*log10(pkt_power));

                                    % correggi gli instanti di inizio e fine pacchetto
                                    % tenendo conto della costante di tempo del filtro
                                    % e del livello raggiunto
                                    %rise_bias = log(1-r2_pkt_thres...
                                    %	/pkt_power)/log(alpha)-1;
                                    rise_bias = log(1-(2*sigma_n^2)...
                                        /pkt_power)/log(alpha)-1;
                                    drop_bias = log(1-(pkt_power-r2_pkt_endthres)...
                                        /pkt_power)/log(alpha)-1;
                                    pkt_t_ini = pkt_t_ini - rise_bias*Ts;
                                    pkt_t_fin = pkt_t_fin - drop_bias*Ts;

                                    % questa � la durata dell'IFS
                                    ifs_len = pkt_t_ini - pkt_t_fin_prev;
                                    % questa serve a calcolare il prossimo IFS
                                    pkt_t_fin_prev = pkt_t_fin;
                                    % questa � la durata del pacchetto trovato
                                    pkt_len = pkt_t_fin - pkt_t_ini;

                                    pkt_energy = r2(n);
                                    pkt_energy_len = 1;
                                    search_state = 2; % wait for the falling edge

                                    if n_pkt == logsize
                                        ifs_log = [ifs_log,zeros(1,logsize)];
                                        pkt_log = [pkt_log,zeros(1,logsize)];
                                        logsize = logsize * 2;
                                    end
                                    n_pkt = n_pkt + 1;
                                    ifs_log(n_pkt) = ifs_len;
                                    pkt_log(n_pkt) = pkt_len;

                                    if DEBUG
                                        if n_pkt <= 1
                                            slot1 = nan;
                                        else
                                            slot1 = ifs_log(n_pkt)+pkt_log(n_pkt-1);
                                        end
                                        if n_pkt <= 2
                                            slot2 = nan;
                                        else
                                            slot2 = slot1+ifs_log(n_pkt-1)+pkt_log(n_pkt-2);
                                        end
                                        if n_pkt <= 3
                                            slot3 = nan;
                                        else
                                            slot3 = slot2+ifs_log(n_pkt-2)+pkt_log(n_pkt-3);
                                        end
                                        if n_pkt <= 4
                                            slot4 = nan;
                                        else
                                            slot4 = slot3+ifs_log(n_pkt-3)+pkt_log(n_pkt-4);
                                        end

                                        %fprintf(['t: %g -- PKT: %g -- IFS: %gus -- LEN: %gus -' ...
                                        %	'- SLOT[ms]: %g %g %g %g\n'],...
                                        %	t0+t(n),n_pkt,ifs_len*s_to_us,pkt_len*s_to_us,...
                                        %	slot1*s_to_ms,slot2*s_to_ms,slot3*s_to_ms,slot4*s_to_ms);

                                        now_pktinfo=[t0+t(n) n_pkt ifs_len*s_to_us pkt_len*s_to_us ...
                                        slot1*s_to_ms slot2*s_to_ms slot3*s_to_ms slot4*s_to_ms];

                                        pktinfoData=[now_pktinfo;pktinfoData];
                                        set(handles.pktinfo,'Data',pktinfoData); 


                                        hold on
                                        plot(handles.tracker,s_to_us*([pkt_t_ini,pkt_t_ini,pkt_t_fin,pkt_t_fin]-t0),...
                                            10*log10([1e-8,pkt_power,pkt_power,1e-8])...
                                            -theory_to_usrp+dB_to_dBm,'r','LineWidth',2);
                                        pause(auto_scroll);







                                    end
                                end
                            end
                        end
                    case 2 % falling edge
                        pkt_energy = pkt_energy + r2(n);
                        pkt_energy_len = pkt_energy_len + 1;
                        pkt_power = pkt_energy/pkt_energy_len;
                        if r2_filt(n) < r2_pkt_thres / 2
                            search_state = 0; % noise
                            t_fall = t0+t(n)-pkt_t_fin;
                            if t_fall > 10e-6

                                % � una collisione?
                                if n_pkt == logsize
                                    ifs_log = [ifs_log,zeros(1,logsize)];
                                    pkt_log = [pkt_log,zeros(1,logsize)];
                                    logsize = logsize * 2;
                                end
                                n_pkt = n_pkt + 1;
                                ifs_len = 0;
                                ifs_log(n_pkt) = ifs_len;
                                pkt_len = t_fall;
                                pkt_log(n_pkt) = pkt_len;
                                pkt_t_fin_prev = t0+t(n);

                                if DEBUG
    % 								hold on
    % 								plot(s_to_us*t(n),...
    % 									10*log10(r2_filt(n))...
    % 									-theory_to_usrp+dB_to_dBm,'or','LineWidth',2);

                                    if n_pkt <= 1
                                        slot1 = nan;
                                    else
                                        slot1 = ifs_log(n_pkt)+pkt_log(n_pkt-1);
                                    end
                                    if n_pkt <= 2
                                        slot2 = nan;
                                    else
                                        slot2 = slot1+ifs_log(n_pkt-1)+pkt_log(n_pkt-2);
                                    end
                                    if n_pkt <= 3
                                        slot3 = nan;
                                    else
                                        slot3 = slot2+ifs_log(n_pkt-2)+pkt_log(n_pkt-3);
                                    end
                                    if n_pkt <= 4
                                        slot4 = nan;
                                    else
                                        slot4 = slot3+ifs_log(n_pkt-3)+pkt_log(n_pkt-4);
                                    end
                                    %fprintf(['t: %g -- PKT: %g -- IFS: %gus -- LEN: %gus -' ...
                                    %	'- SLOT[ms]: %g %g %g %g\n'],...
                                    %	t0+t(n),n_pkt,ifs_len*s_to_us,pkt_len*s_to_us,...
                                    %	slot1*s_to_ms,slot2*s_to_ms,slot3*s_to_ms,slot4*s_to_ms);

                                    now_pktinfo=[t0+t(n) n_pkt ifs_len*s_to_us pkt_len*s_to_us ...
                                        slot1*s_to_ms slot2*s_to_ms slot3*s_to_ms slot4*s_to_ms];

                                        pktinfoData=[now_pktinfo;pktinfoData];
                                        set(handles.pktinfo,'Data',pktinfoData); 



                                    hold on
                                    plot(handles.tracker,s_to_us*([pkt_t_fin,pkt_t_fin,pkt_t_fin+t_fall,pkt_t_fin+t_fall]-t0),...
                                        10*log10([1e-8,pkt_power,pkt_power,1e-8])...
                                        -theory_to_usrp+dB_to_dBm,'--r','LineWidth',2);
                                    %   pause
                                end
                            end
                        end
                end
            end

            % prepara il prossimo loop
            t0=t0+T;
        end
        fclose(fid);
        fprintf('%.1fx slower than real-time\n',toc/t0);

        ifs_log = ifs_log(1:n_pkt);
        pkt_log = pkt_log(1:n_pkt);
        save('ifs_log','ifs_log');
        save('pkt_log','pkt_log');
    end

end
