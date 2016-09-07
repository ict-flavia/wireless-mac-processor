function [backoff_start, phy_tx_start, timeout_start, tx_done, tx_result_out, fsm_state_out] = ...
    mac_tx_ctrl_fsm(reset, timeout_req, new_tx, idle_for_difs, backoff_done, phy_tx_done, phy_rx_start, timeout_done)

persistent fsm_state, fsm_state=xl_state(0, {xlUnsigned, 3, 0});
persistent tx_result, tx_result=xl_state(0, {xlUnsigned, 2, 0});

fsm_state_out = fsm_state;
tx_result_out = tx_result;

%Inputs:
% new_tx: Software request for new Tx cycle
% idle_for_difs: Indication from MAC hw that medium has been idle > DIFS/EIFS
% timeout_req: Indication from MAC sw that this Tx requires timeout period
% backoff_req: Indicated from MAC sw that this Tx requires a pre-Tx backoff
% backoff_done: Indication from MAC hw that backoff period is done
% phy_tx_done: Indication from PHY that last sample is transmitted
% phy_rx_start: Indication from PHY that new Rx has started
% timeout_done: Indicate from MAC hw that timeout has expired

%Outputs:
% backoff_start: Indication to MAC hw to run idle->backoff process
% phy_tx_start: Indication to PHY to start Tx
% timeout_start: Indication to MAC hw to start timeout timer
% tx_done: Indication to MAC hw that this Tx cycle is complete
% tx_result_out: Status of tx_done (timeout or rx_started)
% fsm_state_out: Value of  internal state register (for debugging)

%States:
% ST_IDLE: Waiting for new Tx from MAC sw
% ST_DO_TX: Started PHY Tx, waiting for completion
% ST_DEFERRING: Deferral required, wait for BO to finish
% ST_POST_TX: Finished Tx, waiting for timeout or Rx


ST_IDLE = 0;
ST_DO_TX = 1;
ST_START_BO = 2;
ST_DEFER = 3;
ST_POST_TX = 4;
ST_POST_TX_WAIT = 5;
ST_DONE = 6;

TX_RESULT_NONE = 0;
TX_RESULT_TIMEOUT_EXPIRED = 1;
TX_RESULT_RX_STARTED = 2;

if(reset)
    backoff_start = 0;
    phy_tx_start = 0;
    timeout_start = 0;
    tx_done = 0;
    fsm_state = ST_IDLE;
    tx_result = TX_RESULT_NONE;

else
    switch double(fsm_state)

        case ST_IDLE
            backoff_start = 0;
            phy_tx_start = 0;
            timeout_start = 0;
            tx_done = 0;

            tx_result = TX_RESULT_NONE;

            if(new_tx)
                if(~backoff_done)
                    %If backoff is already running, use it as our deferral
                    fsm_state = ST_DEFER;
                elseif(idle_for_difs)
                    %If no pre-Tx BO is required, any old backoff has expired and medium has been idle,
                    % transmit immediately
                    fsm_state = ST_DO_TX;
                else
                    %If medium hasn't been idle, backoff
                    fsm_state = ST_START_BO;
                end
            else
                fsm_state = ST_IDLE;
            end

        case ST_START_BO
            backoff_start = 1;
            phy_tx_start = 0;
            timeout_start = 0;
            tx_done = 0;

            tx_result = TX_RESULT_NONE;
            fsm_state = ST_DEFER;

        case ST_DEFER
            backoff_start = 0;
            phy_tx_start = 0;
            timeout_start = 0;
            tx_done = 0;

            tx_result = TX_RESULT_NONE;

            if(backoff_done)
                fsm_state = ST_DO_TX;
            else
                fsm_state = ST_DEFER;
            end

        case ST_DO_TX
            backoff_start = 0;
            phy_tx_start = 1;
            timeout_start = 0;
            tx_done = 0;

            tx_result = TX_RESULT_NONE;

            if(phy_tx_done)
                fsm_state = ST_POST_TX;
            else
                fsm_state = ST_DO_TX;
            end

        case ST_POST_TX
            backoff_start = 0;
            phy_tx_start = 0;
            timeout_start = 0;
            tx_done = 0;

            tx_result = TX_RESULT_NONE;

            if(timeout_req)
                fsm_state = ST_POST_TX_WAIT;
            else
                fsm_state = ST_DONE;
            end

        case ST_POST_TX_WAIT
            backoff_start = 0;
            phy_tx_start = 0;
            timeout_start = 1;
            tx_done = 0;

            if(phy_rx_start)
                fsm_state = ST_DONE;
                tx_result = TX_RESULT_RX_STARTED;
            elseif(timeout_done)
                fsm_state = ST_DONE;
                tx_result = TX_RESULT_TIMEOUT_EXPIRED;
            else
                fsm_state = ST_POST_TX_WAIT;
                tx_result = TX_RESULT_NONE;
            end

        case ST_DONE
            backoff_start = 0;
            phy_tx_start = 0;
            timeout_start = 0;
            tx_done = 1;

            %Previous state set tx_result - leave it alone so downstream
            % logic can latch it when tx_done goes high

            fsm_state = ST_IDLE;

        otherwise
            backoff_start = 0;
            phy_tx_start = 0;
            timeout_start = 0;
            tx_done = 0;
            tx_result = TX_RESULT_NONE;
            fsm_state = ST_IDLE;

    end %end switch
end %end else

end %end function

