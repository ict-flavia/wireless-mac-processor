function [fft_load, fft_lts_load, samp_skip_mode] = rx_fft_ctrl_fsm(lts_sync, fft_load_done, pkt_done)

persistent fsm_state, fsm_state=xl_state(0, {xlUnsigned, 3, 0});

%Inputs:
% lts_sync: Successful correlation of second LTS (must be 1 cycle)
% fft_load_done: Last FFT input sample loaded
% pkt_done: Resets state (last FFT is performed, pkt Rx punts, etc.)

%Outputs:
% fft_load: Start FFT load operation
% samp_skip_mode: Selection of number of samples to skip post FFT load
%  0: Skip 0 samples (first LTS)
%  1: Skip CP_LEN samples (second LTS and all DATA symbols)

%States:
% ST_LTS_WAIT: Waiting for LTS sync (this is the idle/reset state)
% ST_LTS_LOAD1: Load first LTS into FFT
% ST_LTS_LOAD2: Load second LTS into FFT
% ST_DATA_LOAD: Load DATA symbols into FFT
% ST_DATA_DONE: Finished loading DATA symbols (returns to LTS_WAIT)

ST_LTS_WAIT = 0;
ST_LTS_LOAD1 = 1;
ST_LTS_LOAD2 = 2;
ST_DATA_LOAD = 3;
ST_DATA_DONE = 4;

switch double(fsm_state)
    
    case ST_LTS_WAIT
        fft_load = 0;
        samp_skip_mode = 0;
        fft_lts_load = 0;
        
        if( (pkt_done==1) )
            fsm_state = ST_LTS_WAIT;
        elseif( (lts_sync==1) )
            fsm_state = ST_LTS_LOAD1;
        else
            fsm_state = ST_LTS_WAIT;
        end

    case ST_LTS_LOAD1
        fft_load = 0;%1;
        fft_lts_load = 1;
        samp_skip_mode = 0;

        if( (pkt_done==1) )
            fsm_state = ST_LTS_WAIT;
        elseif( (fft_load_done==1) )
            fsm_state = ST_LTS_LOAD2;
        else
            fsm_state = ST_LTS_LOAD1;
        end

	case ST_LTS_LOAD2
        fft_load = 0;%1;
        fft_lts_load = 1;
        samp_skip_mode = 1;

        if( (pkt_done==1) )
            fsm_state = ST_LTS_WAIT;
        elseif( (fft_load_done==1) )
            fsm_state = ST_DATA_LOAD;
        else
            fsm_state = ST_LTS_LOAD2;
        end

	case ST_DATA_LOAD
        fft_load = 1;
        fft_lts_load = 0;
        samp_skip_mode = 1;

        if( (pkt_done==1) )
            fsm_state = ST_DATA_DONE;
        else
            fsm_state = ST_DATA_LOAD;
        end

	case ST_DATA_DONE
        fft_load = 0;
        fft_lts_load = 0;
        samp_skip_mode = 0;
        fsm_state = ST_LTS_WAIT;
        
    otherwise
        fft_load = 0;
        fft_lts_load = 0;
        samp_skip_mode = 0;
        fsm_state = ST_LTS_WAIT;

end %end switch
        
end %end function

