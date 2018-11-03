function [D] = pilot_insertion(d, par_N_FFT, par_N_block, switch_graph)
    

    d_temp = reshape(d, par_N_FFT, par_N_block); 
    % This reshapes the modulated values into a 2D array where we can
    % easily insert the pilot at the begining of each row
    
    pilot = 0.5 + 0.5i;
    pilot_array = ones(par_N_FFT,1)*pilot; %pilot data
    % The above generates the pilot array
    
    D = [pilot_array, d_temp];    
    % Pilot array is placed before each row of d_temp
    
    if switch_graph==1
        figure;
        plot(D);
        title('Output after Pilot Insersion')
    end

end