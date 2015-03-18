This folder contains a few samples of 802.11 waveforms suitable for simulation of the Rx PHY model.

These signals were generated using the Tx PHY model (wlan_phy_tx_pmd). To generate additional signals:

 -Customize the Tx PHY model init script (wlan_tx_phy_init.m) with your desired packet contents and Tx rate
 -Run the simulation of the Tx model
 -Save the workspace variable 'wlan_tx_out' to a MAT file (i.e. "save('wlan_tx_sig_custom.mat', 'wlan_tx_out')")
