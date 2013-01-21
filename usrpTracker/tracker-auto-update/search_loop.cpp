#include "mex.h"
#include "matrix.h"
#include <math.h>

void mexFunction(int nlhs,       mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
	// controlla il numero di parametri e di valori da ritornare
	if(nrhs<16 || nlhs>9)
		mexErrMsgTxt("syntax:\n[n_pkt_new,ifs_log_new,pkt_log_new, ...\n"
				"\tsearch_state, pkt_t_ini, pkt_t_fin, pkt_t_fin_prev, pkt_energy, pkt_energy_len] = search_loop( ...\n"
				"\tsearch_state, pkt_t_ini, pkt_t_fin, pkt_t_fin_prev, pkt_energy, pkt_energy_len, ...\n"
				"\tt0, r2, r2_filt, logsize, ...\n"
				"\tt, Ts, alpha, r2_pkt_thres, noise_power, pkt_min_duration)\n");
	
	int search_state, logsize;
	double pkt_t_ini, pkt_t_fin, pkt_t_fin_prev, pkt_energy, pkt_energy_len, t0;
	double Ts, alpha, r2_pkt_thres, noise_power, pkt_min_duration;
	double *r2, *r2_filt, *t;
	
	if(mxGetClassID(prhs[0])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[0])>1)
		mexErrMsgTxt("search_state is not a scalar");
	search_state = int(*mxGetPr(prhs[0]));
	if(mxGetClassID(prhs[1])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[1])>1)
		mexErrMsgTxt("pkt_t_ini is not a scalar");
	pkt_t_ini = *mxGetPr(prhs[1]);
	if(mxGetClassID(prhs[2])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[2])>1)
		mexErrMsgTxt("pkt_t_fin is not a scalar");
	pkt_t_fin = *mxGetPr(prhs[2]);
	if(mxGetClassID(prhs[3])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[3])>1)
		mexErrMsgTxt("pkt_t_fin_prev is not a scalar");
	pkt_t_fin_prev = *mxGetPr(prhs[3]);
	if(mxGetClassID(prhs[4])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[4])>1)
		mexErrMsgTxt("pkt_energy is not a scalar");
	pkt_energy = *mxGetPr(prhs[4]);
	if(mxGetClassID(prhs[5])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[5])>1)
		mexErrMsgTxt("pkt_energy_len is not a scalar");
	pkt_energy_len = *mxGetPr(prhs[5]);
	if(mxGetClassID(prhs[6])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[6])>1)
		mexErrMsgTxt("t0 is not a scalar");
	t0 = *mxGetPr(prhs[6]);
	if(mxGetClassID(prhs[7])!=mxDOUBLE_CLASS || (mxGetM(prhs[7])>1 && mxGetN(prhs[7])>1))
		mexErrMsgTxt("r2 is not a vector");
	r2 = mxGetPr(prhs[7]);
	if(mxGetClassID(prhs[8])!=mxDOUBLE_CLASS || (mxGetM(prhs[8])>1 && mxGetN(prhs[8])>1))
		mexErrMsgTxt("r2_filt is not a vector");
	r2_filt = mxGetPr(prhs[8]);
	if(mxGetClassID(prhs[9])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[9])>1)
		mexErrMsgTxt("logsize is not a scalar");
	logsize = int(*mxGetPr(prhs[9]));
	if(mxGetClassID(prhs[10])!=mxDOUBLE_CLASS || (mxGetM(prhs[10])>1 && mxGetN(prhs[10])>1))
		mexErrMsgTxt("t is not a vector");
	t = mxGetPr(prhs[10]);
	if(mxGetClassID(prhs[11])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[11])>1)
		mexErrMsgTxt("Ts is not a scalar");
	Ts = *mxGetPr(prhs[11]);
	if(mxGetClassID(prhs[12])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[12])>1)
		mexErrMsgTxt("alpha is not a scalar");
	alpha = *mxGetPr(prhs[12]);
	if(mxGetClassID(prhs[13])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[13])>1)
		mexErrMsgTxt("r2_pkt_thres is not a scalar");
	r2_pkt_thres = *mxGetPr(prhs[13]);
	if(mxGetClassID(prhs[14])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[14])>1)
		mexErrMsgTxt("noise_power is not a scalar");
	noise_power = *mxGetPr(prhs[14]);
	if(mxGetClassID(prhs[15])!=mxDOUBLE_CLASS || mxGetNumberOfElements(prhs[15])>1)
		mexErrMsgTxt("pkt_min_duration is not a scalar");
	pkt_min_duration = *mxGetPr(prhs[15]);
	
	// alloca i vettori di output
	double *n_pkt_new_ptr, *ifs_log_new_ptr, *pkt_log_new_ptr;
	double *search_state_ptr;
	double *pkt_t_ini_ptr, *pkt_t_fin_ptr, *pkt_t_fin_prev_ptr, *pkt_energy_ptr, *pkt_energy_len_ptr;
	
	plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
	n_pkt_new_ptr = mxGetPr(plhs[0]);
	if(nlhs > 1){
		plhs[1] = mxCreateDoubleMatrix(1, logsize, mxREAL);
		ifs_log_new_ptr = mxGetPr(plhs[1]);
	}
	if(nlhs > 2){
		plhs[2] = mxCreateDoubleMatrix(1, logsize, mxREAL);
		pkt_log_new_ptr = mxGetPr(plhs[2]);
	}
	if(nlhs > 3){
		plhs[3] = mxCreateDoubleMatrix(1, 1, mxREAL);
		search_state_ptr = mxGetPr(plhs[3]);
	}
	if(nlhs > 4){
		plhs[4] = mxCreateDoubleMatrix(1, 1, mxREAL);
		pkt_t_ini_ptr = mxGetPr(plhs[4]);
	}
	if(nlhs > 5){
		plhs[5] = mxCreateDoubleMatrix(1, 1, mxREAL);
		pkt_t_fin_ptr = mxGetPr(plhs[5]);
	}
	if(nlhs > 6){
		plhs[6] = mxCreateDoubleMatrix(1, 1, mxREAL);
		pkt_t_fin_prev_ptr = mxGetPr(plhs[6]);
	}
	if(nlhs > 7){
		plhs[7] = mxCreateDoubleMatrix(1, 1, mxREAL);
		pkt_energy_ptr = mxGetPr(plhs[7]);
	}
	if(nlhs > 8){
		plhs[8] = mxCreateDoubleMatrix(1, 1, mxREAL);
		pkt_energy_len_ptr = mxGetPr(plhs[8]);
	}
	
	int N = mxGetNumberOfElements(prhs[10]);
	int n_pkt_new = 0;
	
	for (int n = 0; n < N; n++){
		switch(search_state){
			case 0:
				if(r2_filt[n] > r2_pkt_thres){
					pkt_t_ini = t0 + t[n];
					search_state = 1;
					pkt_energy = r2[n];
					pkt_energy_len = 1;
				}
				break;
			case 1:
				pkt_energy = pkt_energy + r2[n];
				pkt_energy_len = pkt_energy_len + 1;
				if(r2_filt[n] < r2_pkt_thres/2 && pkt_energy_len * Ts < pkt_min_duration)
					search_state = 0;
				else{
					if(pkt_energy_len * Ts > pkt_min_duration){
						double pkt_power = pkt_energy/pkt_energy_len;
						double r2_pkt_endthres = 0.1 * pkt_power;
						if(r2_filt[n] < r2_pkt_endthres){
							pkt_t_fin = t0 + t[n];
							double rise_bias = log(1-noise_power/r2_pkt_thres)/log(alpha)-1;
							double drop_bias = log(1-(pkt_power-r2_pkt_endthres)/pkt_power)/log(alpha)-1;
							pkt_t_ini = pkt_t_ini - rise_bias*Ts;
							pkt_t_fin = pkt_t_fin - drop_bias*Ts;
							double ifs_len = pkt_t_ini - pkt_t_fin_prev;
							pkt_t_fin_prev = pkt_t_fin;
							double pkt_len = pkt_t_fin - pkt_t_ini;
							pkt_energy = r2[n];
							pkt_energy_len = 1;
							search_state = 2;
							ifs_log_new_ptr[n_pkt_new] = ifs_len;
							pkt_log_new_ptr[n_pkt_new] = pkt_len;
							n_pkt_new = n_pkt_new + 1;
						}
					}
				}
				break;
			case 2:
				pkt_energy = pkt_energy + r2[n];
				pkt_energy_len = pkt_energy_len + 1;
				if(r2_filt[n] < r2_pkt_thres / 2){
					search_state = 0;
					double t_fall = t0 + t[n] - pkt_t_fin;
					if (t_fall > 10e-6){
						double ifs_len = 0;
						ifs_log_new_ptr[n_pkt_new] = ifs_len;
						double pkt_len = t_fall;
						pkt_log_new_ptr[n_pkt_new] = pkt_len;
						pkt_t_fin_prev = t0 + t[n];
						n_pkt_new = n_pkt_new + 1;
					}
				}
				break;
		}
	}

	*n_pkt_new_ptr = n_pkt_new;
	*search_state_ptr = search_state;
	*pkt_t_ini_ptr = pkt_t_ini;
	*pkt_t_fin_ptr = pkt_t_fin;
	*pkt_t_fin_prev_ptr = pkt_t_fin_prev;
	*pkt_energy_ptr = pkt_energy;
	*pkt_energy_len_ptr = pkt_energy_len;
}
