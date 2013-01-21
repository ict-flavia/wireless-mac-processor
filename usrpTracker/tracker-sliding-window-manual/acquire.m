function [] = acquire(ch)
    
    % ./do_capture dentro lo script funziona solo sotto linux - in mac non va
    cmd=sprintf('sudo ./do_capture %s', ch);
    system(cmd);
    
    [r2, r2_filt,theory_to_usrp,N,Ts] = getr2(str2double(ch));
    t = (0:N-1)*Ts;


    s_to_ms = 1e3;
    s_to_us = 1e6;
    dB_to_dBm = 30;

    WIN_SIZE=1e6;

    START=1;
    STEP=0.1e6;
    STOP=WIN_SIZE;

    while 1

        %fprintf('START=%d \t STOP=%d \tSTEP=%d\n',START,STOP,STEP);

        t_step=t(START:STOP);
        
        r2_filt_step=r2_filt(START:STOP);
        %hold off
        
        %r2_step=r2(START:STOP);
        %plot(t_step*s_to_ms,10*log10(r2_step)...
        %    -theory_to_usrp+dB_to_dBm,':');
        %hold on
        
        plot(t_step*s_to_ms,10*log10(r2_filt_step)...
            -theory_to_usrp+dB_to_dBm,'-');

        ylabel('RSSI  [dBm]')
        xlabel('Time [ms]')
        %set(gca,'XLim',[200,600],'YLim',[-94,-40])
        %set(gca,'YLim',[-94,-50])
        set(gca,'XLim',[t(START)*s_to_ms,t(STOP)*s_to_ms],'YLim',[-94,-30])
        %set(gca,'YLim',[-94,-45]);


        grid on
        drawnow

        pause

        %{
        if 1 
            if STOP >= length(t);
                continue;
            else
                fprintf('any\n');
                START=STOP+1;
                STOP=STOP+STEP;
            end
        end
      %}


        keyIn = get(gcf,'CurrentCharacter');
        tasto=sprintf('%d',keyIn);

        if strcmp(tasto,'29') % FRECCIA A DESTRA
            if STOP >= length(t);
                continue;
            else
                %fprintf('->\n');
                START=START+STEP;
                STOP=STOP+STEP;
                if STOP >= length(t)
                    STOP=length(t)-1;
                    START=STOP-WIN_SIZE;
                end

            end
        end
        if strcmp(tasto,'28') % FRECCIA A SINISTRA
            if START <= 1
                continue
            else
                %fprintf('<-\n');
                STOP=STOP-STEP;
                START=START-STEP;
                if START <= 1
                    STOP=WIN_SIZE;
                    START=1;
                end

            end
        end
        if strcmp(tasto,'27') % TASTO ESC
            close all;
            break
        end




    end
end

