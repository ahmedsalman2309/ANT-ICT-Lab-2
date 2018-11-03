function [c] = channel_coding(b, par_G, par_N_zeros, switch_off)


    if switch_off == 1 % No channel coding. Just add zeros and proceed
        c_zeros=zeros(par_N_zeros,1);
        c=cat(1, b, c_zeros);
    
    elseif switch_off == 0 % This means that now we have to perform channel coding
        N=length(b)/4;
        temp = reshape(b,4,N);     
        % Have to reshape b cause we have to multiply it with a 7*4 matrix 
        %so we have to reshape b to 4*N matrix.b_new is a matrix of 7*N
        
        c1 = par_G*temp; 
        % Multiply each 4 bit sequence with the generator matrix
        
        c2 = mod(c1,2);
        %To see if the value we got is even or odd
        
        c_length=7*N;
        %length of sequence after coding
        
        c_temp=reshape(c2, c_length, 1);
        c_zeros = zeros(par_N_zeros,1);
        c=[c_temp; c_zeros];        
    end
end
