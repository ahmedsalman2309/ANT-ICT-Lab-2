function d_tilde=ofdm_demod(z_tilde,par_N_FFT,par_N_CP,swich_graph)


    z_tilde_trans = reshape(z_tilde, 1, length(z_tilde)); % Taking the transpose
    m = par_N_FFT+par_N_CP; % Total length of an OFDM Symbol (1280)
    
    L = length(z_tilde);
    n = (L-mod(L,m))/m;
    % To make  length of z_tilde dividable by 'par_N_FFT+par_N_CP' (1280)
    
    z_tilde_new = z_tilde_trans(1:m*n);
    
    z_tilde_2D = reshape(z_tilde_new, m, n);  %serial to parallel
    
    z_tilde_no_cp = z_tilde_2D(1+par_N_CP:m,:);    
    % All the cyclc prefixes are removed from each and every OFDM symbol
    % This only put values from 257 to 1280 from each OFDM symbol in the
    % new array z_tilde_no_cp
    
    d_tilde = fft(z_tilde_no_cp)./sqrt(par_N_FFT);

    if swich_graph==1;
        K = reshape(d_tilde,par_N_FFT*n,1);
        scatterplot(K);
        title('Constellation diagram after OFDM demodulation')
    end
end
    
    


