addpath('./mcode_blocks');

%Maximum interval values in usec
% These determine bit widths of counters
MAX_SIFS = 63;
MAX_SLOT = 63;
MAX_DIFS = 63;
MAX_EIFS = 255;
MAX_ACKTIMEOUT = 255;
MAX_NAV = 4095;
MAX_NUM_SLOTS = 2^16-1;

%Calculate bit widths
% All counters run at 160MHz (1/160 usec)
NB_CNTR_SIFS = ceil(log2(MAX_SIFS * 160));
NB_CNTR_SLOT = ceil(log2(MAX_SLOT * 160));
NB_CNTR_DIFS = max(ceil(log2(MAX_DIFS * 160)), ceil(log2(MAX_EIFS * 160)));
NB_CNTR_ACKTIMEOUT = ceil(log2(MAX_ACKTIMEOUT * 160));
NB_CNTR_NAV = ceil(log2(MAX_NAV * 160));
NB_CNTR_NUM_SLOTS = ceil(log2(MAX_NUM_SLOTS));

%Max hardware latencies, used to calculate various MAC intervals
PHY_RX_START_DLY = 25;

%Actual hardware latencies, used to calibrate MAC intervals

%D1: RxRfDelay + RxPLCPDelay
% After pkt reception, D1 is delay from actual medium IDLE to PHY_RX_END
hw_time_D1 = 1;

%RxTx Turnaround
% Time from PHY_TX_START.IND to PHY_TX_START.CONFIRM
%  (delay from "transmit now" signal to first energy on medium)
hw_time_rxtx_turnaround = 1;


ticks_per_usec = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%
% MAC timing parameters
INTERVAL_SIFS = 10;
INTERVAL_SLOT = 9;
INTERVAL_DIFS = INTERVAL_SIFS + 2*INTERVAL_SLOT;
INTERVAL_EIFS = INTERVAL_SIFS + INTERVAL_DIFS + 100; %guess TACK_slow for now
INTERVAL_ACKTIMEOUT = INTERVAL_SIFS + INTERVAL_SLOT + PHY_RX_START_DLY;

%%%%%%%%%%%%%%%%%%%%%%%%%
% Calibrated MAC times

%TxDIFS: instant to sample medium status after successful Rx
calib_time_TxDIFS = INTERVAL_DIFS - hw_time_D1 - hw_time_rxtx_turnaround;

%Adjustment for NAV times, to compensate dealy from actual idle to RX_END+FCS
calib_time_NAV_adj = 0;

REG_MAC_Intervals_1 = ...
    2^0  * (10*INTERVAL_SLOT) + ... %b[9:0]
    2^20 * (10*INTERVAL_DIFS) + ... %b[29:20]
    0;
    
REG_MAC_Intervals_2 = ...
    2^0  * (10*INTERVAL_EIFS) + ... %b[15:0]
    2^16 * (10*INTERVAL_ACKTIMEOUT) + ... %b[31:16]
    0;

REG_MAC_Calib_Times = ...
    2^0  * (10*calib_time_TxDIFS) + ... %b[9:0]
    2^24 * (10*calib_time_NAV_adj) + ... %b[31:24]
    0;

REG_MAC_MPDU_Tx_Params = ...
    2^0  * (4) + ... %b[3:0] - pkt buf to Tx
    2^8  * (3) + ... %b[23:8] - pre-Tx BO slots
    2^24 * (1) + ... %b[24] - post-Tx timeout
    0;
    
REG_MAC_Auto_Tx_Params = ...
    2^0  * (0) + ... %b[3:0] - pkt buf to Tx
    2^4  * (8.5*10) + ... %b[13:4] - pre-Tx delay (=SIFS-turnaround)
    2^31 * (0) + ... %b[31] - enable post-Rx auto-Tx
    0;
    
REG_MAC_Backoff_Control = ...
    2^0  * (0) + ... %b[15:0] - num BO slots
    2^31 * (0) + ... %b[31] - Start backoff period immediately
    0;

REG_MAC_Control = ...
    2^0  * (0) + ... %b[0] Reset
    2^1  * (1) + ... %b[1] Block Rx pkt det on Rx FCS good
    2^2  * (0) + ... %b[2] Clear Rx pkt det block
    2^3  * (0) + ... %b[3] Disable NAV
    2^4  * (1) + ... %b[4] Block Rx pkt det while Tx active
    2^5  * (0) + ... %b[5] Load new timestamp values
    2^6  * (0) + ... %b[6] Block Rx pkt det on all Rx End (incl. bad FCS)
    2^7  * (0) + ... %b[7] Ignore PHY carrier sensing for CCA
    2^8  * (0) + ... %b[8] Ignore Tx PHY active for CCA
    2^9  * (0) + ... %b[9] Ignore NAV for CCA
    0;
    