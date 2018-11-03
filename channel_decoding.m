function b_hat=channel_decoding(c_hat,par_H,par_N_zeros,switch_off)
    if switch_off == 1 % Do nothing
        b_hat = c_hat;
    elseif switch_off == 0        
%{
The result of the matrix multiplication is the "syndrome". If the syndrome is 0, the least significant 
4 bits of the code word are the encoded data. If the "syndrome" is non-zero, toggle the bit 
in the postition matching the column of the parity check matrix that matches the 
"syndrome". (If the "syndrome" matches the 4th column, toggle the 4th bit.) I use an array with the 
"syndrome" as it's index to provide a mask to use for toggling the errored bit. 
After the error has been corrected, the least significant 4 bits of the code word are the encoded data.
%}
        cols=length(c_hat)/7;
        temp = reshape(c_hat,7,cols);
        syndrome = par_H*temp; % calculate the syndrome
        syndrome_binary = mod(syndrome,2); % values are 0 if even, 1 if odd
        [m,n] = size(syndrome_binary);

        p = 0;
        for i=1:n
            if syndrome_binary(:,i)==par_H(:,1) 
                c_hat(p+1) = ~c_hat(p+1);
            elseif syndrome_binary(:,i)==par_H(:,2) 
                c_hat(p+2) = ~c_hat(p+2);
            elseif syndrome_binary(:,i)==par_H(:,3) 
                c_hat(p+3) = ~c_hat(p+3);
            elseif syndrome_binary(:,i)==par_H(:,4) 
                c_hat(p+4) = ~c_hat(p+4);
            elseif syndrome_binary(:,i)==par_H(:,5) 
                c_hat(p+5) = ~c_hat(p+5);
            elseif syndrome_binary(:,i)==par_H(:,6) 
                c_hat(p+6) = ~c_hat(p+6);
            elseif syndrome_binary(:,i)==par_H(:,7) 
                c_hat(p+7) = ~c_hat(p+7);
            end
            
            p=p+7;
        end
        % The above for loop toggles the proper bit which is in the proper 
        % index for each column of c_hat
        
        decoder=[0 0 1 0 0 0 0;0 0 0 0 1 0 0;0 0 0 0 0 1 0;0 0 0 0 0 0 1];
        % the above is the matrix R in wikipedia
        
        k = 1;
        for j=1:7:length(c_hat)
            b_hat(k:k+3,1) = decoder*c_hat(j:j+6,1);
            k = k+4;
        end
        % The for loop above multiplies all 7 bit long sequences with the
        % decoder to give 4 bit sequences that are the decoded bits
        
        k = k(1:length(k)-par_N_zeros,1); % delete previously added zeros
    end
end
    
    
    


