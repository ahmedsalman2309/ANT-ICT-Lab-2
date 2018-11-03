function c_hat=demodulation(d_bar,switch_mod,switch_graph)

    if switch_mod == 0 % 4-QAM
        no_of_bits = 2;
        power_normalize = 2;
    elseif  switch_mod == 1 % 16-QAM
        no_of_bits=4;
        power_normalize = 10;
    elseif switch_mod == 2 % 64-QAM
        no_of_bits=6;
        power_normalize = 42;
    end

    no_of_symbols=2^no_of_bits;
    % This is the total number of symbols in the constellation diagram i.e
    % 4, 16 or 64 

    real_part = -sqrt(no_of_symbols)+1;
    imag_part = real_part;
    % real and imag parts of the constellation symbol point are started
    % from the bottom left corner e.g -1-1i for 4-QAM

    constellation_points=[];
    for i1=1:sqrt(no_of_symbols)
        for j1=1:sqrt(no_of_symbols)
            constellation_points = [constellation_points; real_part + imag_part*1i];
            real_part=real_part+2;
        end
        real_part = -sqrt(no_of_symbols)+1;
        imag_part = imag_part+2;
    end
    % In the inner for loop the constellation points are added to the array 
    % by increasing the real part by 2 in each iteration
    % In the outer for loop the constellation points are added to the array
    % by increasing the imaginary part by 2 in each iteration
    % Finally we get all the constellation points in an array

    
    constellation_points=constellation_points/sqrt(power_normalize);
    % Power normalization

    c_hat = [];

    for j = 1:length(d_bar)
        for index = 1:length(constellation_points)
            error(index) = d_bar(j)-constellation_points(index);
        end
        final_decision(j) = find(error==min(error(:)))-1;
        c_hat = [c_hat; de2bi(final_decision(j) ,no_of_bits, 'left-msb')'];
    end
    % In the above inner for loop we calculate the error between the jth
    % received value and each of the constellation points
    % Then in the outer for loop we use the find function to find the index
    % of the error array where the error is minimum. That index - 1 is our 
    % decision in decimal number. Then we convert that decimal decision
    % number into binary bits and concatenate these bits into c_hat
    
    
    if switch_graph == 1                                         
        figure = scatterplot(d_bar,1,0,'b.');                                                          
        hold on
        scatterplot(constellation_points,1,0,'k*',figure)
        title('Demodulation ouput')
        grid
    end
end
