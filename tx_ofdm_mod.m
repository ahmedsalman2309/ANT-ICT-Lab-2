function z=tx_ofdm_mod(D,par_N_FFT,par_N_CP,switch_graph)
    
    
   
    D_ifft = ifft(D).*sqrt(par_N_FFT);
    % This takes the ifft of all the symbols (each of length 1024)
    
    a = par_N_FFT+par_N_CP; % length of one OFDM symbol (1280)
    b = par_N_FFT-par_N_CP; % last value in OFDM symbol before the CP starts (768)
    [m, n] = size(D_ifft); % rows and colums of the D_ifft
    cyclic_prefix = zeros(par_N_CP, n); % CP matrix with 256 rows and cols according to modulation scheme
    
    for i=1:par_N_CP            %%%CP=last 256 bits of 1024 lenth frame.this cp is added infront of the frame.
        cyclic_prefix(i,:) = D_ifft(b+i,:);
    end
    % In the above for loop we add all the last 256 values in an OFDM
    % symbol to each row of the cyclic prefix
    
    z_2D = [cyclic_prefix; D_ifft];
    % Concatenate the cyclic prefix before D_ifft

    [p, q] = size(z_2D); % rows and cols of z_2D
    z = reshape(z_2D, 1, p*q); % This serializes the 2D matrix
    
    OFDM_symbol = z(a+1:2*a);
    [H W] = freqz(OFDM_symbol, 1, 512);
    % We need to show a figure of one OFDM symbol in time and frequency
    % domains and we need to choose the second OFDM symbol because the
    % first one is weirdly all zeros
    
    if switch_graph == 1
        figure;
        plot(real(OFDM_symbol));
        title('OFDM symbol in time domain');
        xlabel('OFDM symbol sequence');
        ylabel('Amplitude');

        figure;
        plot(W/pi,20*log10(abs(H)));
        xlabel('\omega/pi');
        ylabel('Amplitude in DB');
        title('OFDM symbol in normalized frequency domain');

end