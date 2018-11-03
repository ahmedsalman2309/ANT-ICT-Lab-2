function [s]=tx_filter(z,par_tx_w,switch_graph,switch_off)

    if switch_off == 1 % Filter has no effect
        s = z;
    elseif switch_off == 0
        
        filter = rcosine(1,par_tx_w,'fir/sqrt'); % defining the filter
        %x1=[];
        %z_oversampled=[];

        %for i=1:length(z)
        %    x1 = [z(i) zeros(1,par_tx_w-1)];
        %    z_oversampled = [z_oversampled x1];
        %end
        
        z_upsampled = upsample(z,par_tx_w); % upsampling z with par_tx_w
        filter_out = conv(filter, z_upsampled); % Passing through the fitler
        [m,n]=size(filter_out);
        s = reshape(filter_out, n, 1); 
        % Here s is transposed
        
        [H W] = freqz(s,1,512);
        
        
        if switch_graph==1
            figure;
            plot(W/pi,20*log10(abs(H)));
            xlabel('\omega/pi');
            ylabel('H in DB');
            title('Transmit filter output in normalized frequency domain');
            figure
            hold off
            subplot(2,1,1)

            %{
            plot(real(s),'g');
            title('output of transmit filter(real)')
            grid on
            subplot(2,1,2)
            plot(imag(s),'r');
            grid on
            title('output of transmit filter(imaginary)')
            %}
       end
    end
end
