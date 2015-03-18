%xlLoadChipScopeData('../wlan_phy_rx/cs_capt/wlan_cs_capt_5.prn'); cs_interp = 1; cs_start = 1;
%payload_vec = [zeros(25,1); complex(ADC_I(cs_start:cs_interp:end), ADC_Q(cs_start:cs_interp:end));];
payload_vec = 0;
raw_rx_I.time = [];
raw_rx_Q.time = [];

DCO_I = 0.05;
DCO_Q = 0;
G_I = 2;
G_Q = 2;

raw_rx_I.signals.values = DCO_I + G_I*real(payload_vec);
raw_rx_Q.signals.values = DCO_Q + G_Q*imag(payload_vec);


PHY_CONFIG_PKT_DET_CORR_THRESH = 90;
PHY_CONFIG_PKT_DET_ENERGY_THRESH = 14;
PHY_CONFIG_PKT_DET_MIN_DURR = 4;

%% Register Init

%Timing registers
AGC_TIMING_CAPT_RSSI_1 = 8;
AGC_TIMING_CAPT_RSSI_2 = 24;
AGC_TIMING_CAPT_V_DB = 48;
AGC_TIMING_START_DCO = 60;

AGC_TIMING_EN_IIR_FILT = 93;
AGC_TIMING_DONE = 95;

AGC_TIMING_RESET_RXHP = 0;
AGC_TIMING_RESET_G_RF = 30;
AGC_TIMING_RESET_G_BB = 25;


%Config register
AGC_G_RF_THRESH_32 = 256-52; %Reinterpret Fix8_0 to UFix8_0
AGC_G_RF_THRESH_21 = 256-40; %Reinterpret Fix8_0 to UFix8_0
AGC_RSSI_AVG_LEN_SEL = 0;
AGC_V_DB_ADJ = 64-13; %Reinterpret Fix6_0 to UFix6_0
AGC_INIT_G_BB = 24;

%Target register
AGC_TARGET_PWR = 64-15; %Reinterpret Fix6_0 to UFix6_0

%IIR filt coefficients
DCO_IIR_Coef_A1 = -0.98751192990731429;
DCO_IIR_Coef_B0 =  0.99375596495365714;

%Rx Power - RSSI calib register (-power values in dBm)
RSSI_MIN_PWR_G_RF_3 = 100;
RSSI_MIN_PWR_G_RF_2 = 85;
RSSI_MIN_PWR_G_RF_1 = 70;


REG_AGC_Timing_AGC = ...
    2^0 * AGC_TIMING_CAPT_RSSI_1 + ... %UFix8_0
    2^8 * AGC_TIMING_CAPT_RSSI_2 + ... %UFix8_0
    2^16 * AGC_TIMING_CAPT_V_DB + ... %UFix8_0
    2^24 * AGC_TIMING_DONE; %UFix8_0

REG_AGC_Timing_DCO = ...
    2^0 * AGC_TIMING_START_DCO + ... %UFix8_0
    2^8 * AGC_TIMING_EN_IIR_FILT + ... %UFix8_0
    0;

REG_AGC_Timing_Reset = ...
    2^0 * AGC_TIMING_RESET_RXHP + ... %UFix8_0
    2^8 * AGC_TIMING_RESET_G_RF + ... %UFix8_0
    2^16 * AGC_TIMING_RESET_G_BB + ... %UFix8_0
    0;

REG_AGC_Config = ...
    2^0 * AGC_G_RF_THRESH_32 + ... %Fix8_0
    2^8 * AGC_G_RF_THRESH_21 + ... %Fix8_0
    2^16 * AGC_RSSI_AVG_LEN_SEL + ... %UFix2_0
    2^18 * AGC_V_DB_ADJ + ... %Fix6_0
    2^24 * AGC_INIT_G_BB + ... %UFix5_0
    0;

REG_AGC_Target = AGC_TARGET_PWR;

REG_AGC_IIR_Coef_A1 = DCO_IIR_Coef_A1;
REG_AGC_IIR_Coef_B0 = DCO_IIR_Coef_B0;

REG_AGC_RSSI_RX_PWR_CALIB = ...
    2^0 * RSSI_MIN_PWR_G_RF_3 + ... %UFix8_0
    2^8 * RSSI_MIN_PWR_G_RF_2 + ... %UFix8_0
    2^16 * RSSI_MIN_PWR_G_RF_1 + ... %UFix8_0
    0;

    