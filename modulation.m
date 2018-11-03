function [ d ] = modulation(c, switch_mod, switch_graph)

    if switch_mod == 0 % 4-QAM
        no_of_bits = 2; % no of bits in 4QAM
        power_normalize = 2;
    elseif switch_mod == 1 % 16-QAM
        no_of_bits = 4; % no of bits in 16QAM
        power_normalize = 10;
    elseif switch_mod == 2 % 64-QAM
        no_of_bits = 6; % no of bits in 64QAM
        power_normalize = 42;
    end
    
    rem = mod(length(c), no_of_bits);                                       
    if rem ~= 0                                                           
        c = [c; zeros(no_of_bits-rem,1)]; % zero padding
    end
    % the above checks if the total length of the input bitstream is
    % divisible by 2, 4 or 6 and if not adds zeros at the end until it is
    % divisible
    
    no_of_symbols=2^no_of_bits;
    % This is the total number of symbols in the constellation diagram i.e
    % 4, 16 or 64 
    
    real_part = -sqrt(no_of_symbols) + 1;
    imag_part = real_part;
    % real and imag parts of the constellation symbol point are started
    % from the bottom left corner e.g -1-1i for 4-QAM

    constellation_points=[];

    for i=1:sqrt(no_of_symbols)
        for j=1:sqrt(no_of_symbols)
            constellation_points=[constellation_points; real_part+imag_part*1i];
            real_part=real_part+2;
        end
        real_part=-sqrt(no_of_symbols)+1;
        imag_part=imag_part+2;
    end
    % In the inner for loop the constellation points are added to the array 
    % by increasing the real part by 2 in each iteration
    % In the outer for loop the constellation points are added to the array
    % by increasing the imaginary part by 2 in each iteration
    % Finally we get all the constellation points in an array
    
    constellation_points = constellation_points/sqrt(power_normalize); 
    % Power normalization
    
    d = [];  
    for i = 1:no_of_bits:length(c)
          index = bi2de(c(i:i+no_of_bits-1)', 'left-msb'); 
          d = [d; constellation_points(index+1)]; % symbol value added
    end
    % In the above for loop we take the first 2,4 or 6 bits from c and
    % convert them into a decimal number and then that decimal number +1 is
    % the index of the constellation points array where our modulated
    % symbol is. That modulated symbol is concatenated into the array d
    
    if switch_graph == 1
        scatterplot(d)
        title('Modulated Symbols');
        grid on
        axis([-2 2 -2 2]);
    end

end