function [ output_args ] = ifs_analysis( ch )
	if nargin < 1
		ch = '1';
	end
	start_time=clock;
	fprintf('CHANNEL = %d\n',ch);
	freq=2412+5*(ch-1);
	fprintf('FREQ=%d\n',freq);
	
	decim = 8;
	gain = 28;
    filename =sprintf('f%d_d8_g28.raw',freq);
	
	T = 10e-3;
	
	% noise calibration
	% 	PHASE = 0;
	% energy-based packet detection
	PHASE = 1;
	
	DEBUG = false;
	%DEBUG = true;
	
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
		pkt_t_fin = nan;
		pkt_t_ini = nan;
		pkt_energy = nan;
		pkt_energy_len = nan;
		
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
		
		while true
% 			fprintf('.');
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
			
			% rivela la presenza dei pacchetti, e determina gli IFS
			[n_pkt_new,ifs_log_new,pkt_log_new,...
				search_state,pkt_t_ini,pkt_t_fin,pkt_t_fin_prev,pkt_energy,pkt_energy_len] = search_loop( ...
				search_state,pkt_t_ini,pkt_t_fin,pkt_t_fin_prev,pkt_energy,pkt_energy_len,...
				t0,r2,r2_filt,ceil(T/30e-6),...
				t,Ts,alpha,r2_pkt_thres,2*sigma_n^2,pkt_min_duration);
			if n_pkt_new
				while n_pkt + n_pkt_new > logsize
					ifs_log = [ifs_log,zeros(1,logsize)];
					pkt_log = [pkt_log,zeros(1,logsize)];
					logsize = logsize * 2;
				end
				ifs_log(n_pkt+(1:n_pkt_new)) = ifs_log_new(1:n_pkt_new);
				pkt_log(n_pkt+(1:n_pkt_new)) = pkt_log_new(1:n_pkt_new);
				n_pkt = n_pkt + n_pkt_new;
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
	load('ifs_log');
	load('pkt_log');
    figure(1)
    clf(1)
	subplot(2,1,1)
    
    %ifs=10e6*ifs_log(2:end);
    %[y x] = hist(ifs,unique(ifs));
    %y=cumsum(y);
    %y=y/max(y);
    %plot(x,y);
    
    
	cdfplot(1e6*ifs_log(2:end));
    grid on
	title('IFS CDF')
	xlabel('t [us]');
	ylabel('F(ifs_{len})');
    subplot(2,1,2);
    
    
    %pkt=10e6*pkt_log(2:end);
    %[y x] = hist(pkt,unique(pkt));
    %y=cumsum(y);
    %y=y/max(y);
    %plot(x,y);
    
   
    cdfplot(1e6*pkt_log(2:end));
    
    grid on
	title('PKTLEN CDF')
	xlabel('t [us]');
    ylabel('F(pkt_{len})');
end

