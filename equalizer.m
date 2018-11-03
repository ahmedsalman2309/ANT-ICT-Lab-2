function d_bar=equalizer(d_tilde, switch_mod, switch_graph)
   
    if switch_mod==1
        pilot_original = (0.5+0.5i)*ones(1024,1);
        % Creates an array of the original pilot placed in the first col
        
        pilot_array = d_tilde(:,1)/pilot_original;
        % A pilot array is created which has all the pilots divided with
        % the original pilot
        
        d_unequalized = d_tilde(:,2:end); % pilot seperate
        % The pilots are seperated to get the unequalized data. This is
        % done by removing the first column from d_tilde
        
        [m,n] = size(d_unequalized);
        d_equalized = zeros(m,n);
        
        for i=1:m
            for j=1:n
                d_equalized(i,j)=(d_unequalized(i,j))/pilot_array(i,1);
            end
        end
        % In the above for loop we divide each value of the equalized
        % d_tilde with the pilot at the corresponding block of 1024 symbols
        
        d_bar = reshape(d_equalized,m*n,1);    
        
        if switch_graph==1
            figure;
            plot(d_bar,'r*');
            title('Constellation diagram after Equalizer');
            xlabel('In-phase Amplitude');
            ylabel('Quadrature Amplitude');
        end
        
    elseif switch_mod == 0
        
        d_equalized = d_tilde(:,2:end);
        % Pilots are removed by ignoring the first column of the 2D array
        
        [m,n] = size(d_equalized);
        d_bar = reshape(d_equalized, m*n, 1);
        % d_bar is serialized
    end
    
end        
        
   
    