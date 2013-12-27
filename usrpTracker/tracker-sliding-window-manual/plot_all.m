function [] = plot_all()
close all
ch=10;
fprintf('CHANNEL = %d\n',ch);
freq=2412+5*(ch-1);
fprintf('FREQ=%d\n',freq);
decim = 8;
gain = 28;

filename =sprintf('f%d_d8_g28.raw',freq);

% quanti secondi di traccia analizzare
T = 300e-3; 
%system('sudo ./do_capture 1');

PHASE = 1;

% DEBUG = false;

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
close all;
% leggi il file e calcola gli IFS
if PHASE == 1
	NF_dB_typ = 6;
	T_amb = 25;
	noise_var_theory = 1.38e-23*(273+T_amb)*fs*10^(NF_dB_typ/10);
	dB_to_dBm = 30;
    s_to_ms = 1e3;
    s_to_us = 1e6;
    
	fprintf('noise level: %gdBm\n',...
		10*log10(noise_var_theory)+dB_to_dBm);
	
	% la USRP ha un fattore di conversione interi<->livello che
	% determiniamo a partire dalle misure sul rumore
	theory_to_usrp = 10*log10(noise_var_usrp/noise_var_theory);
	
	% parametri 'arbitrari'
	t = (0:N-1)*Ts;
	% la potenza istantanea viene filtrata con un filtro AR del primo
	% ordine con costante di tempo 1us: h_k = (1-alpha)*alpha^k
	% (l'espressione ??? ottenuta col metodo dell'invarianza all'impulso)
	alpha = exp(-Ts/0.5e-6);
	r2_filt_b = 1-alpha;
	r2_filt_a = [1,-alpha];
	r2_filt_z = [];
	
	
	% open the file (and skip the first segment)
	tic
	fclose('all');
	fid = fopen(filename,'r');
	fseek(fid,2* N*2,'bof'); % 2*: I,Q; *2: int16
    
    
    [r_raw,Nr] = fread(fid,2*N,'int16');
		if Nr<2*N
			return
		end
		r = fix_to_float*(r_raw(1:2:end)+1i*r_raw(2:2:end));
		r2 = r.*conj(r);
		
		% la classificazione viene effettuata sulla versione filtrata della
		% potenza istantanea
		[r2_filt,r2_filt_z] = filter(r2_filt_b,r2_filt_a,r2,r2_filt_z);
              
		hold off
			%plot(t*s_to_ms,10*log10(r2)...
			%	-theory_to_usrp+dB_to_dBm,':');
			%hold on
			plot(t*s_to_ms,10*log10(r2_filt)...
				-theory_to_usrp+dB_to_dBm,'-');
			
			ylabel('RSSI  [dBm]')
			xlabel('Time [ms]')
			%set(gca,'XLim',[200,600],'YLim',[-94,-40])
			%set(gca,'YLim',[-94,-50])
			%set(gca,'XLim',[185,210],'YLim',[-94,-40])
            set(gca,'YLim',[-94,-45]);
            

			grid on
			drawnow
        
    return 
    

end