function [ z_tilde ] = rx_filter(s_tilde, par_rx_w, switch_graph, switch_off)

    if switch_off == 1 % Switched off. Do nothing.
        z_tilde = s_tilde;
    elseif switch_off == 0 % Switched on
       filter = rcosine(1, par_rx_w, 'fir/sqrt'); % Defining the filter
       filter_out = conv(filter, s_tilde); % Passing through the filter
       z_tilde = downsample(filter_out, par_rx_w);
       %z_tilde = filter_out(1:par_rx_w:length(filter_out)); % Downsampling
       
       [H W] = freqz(filter_out, 1, 512);

        if switch_graph==1
            figure;
            plot(W/pi,20*log10(abs(H)));
            xlabel('\omega/pi');
            ylabel('H in dB');
            title('Receiever filter output in normalize freq domain');
            hold on

            grid on
            figure
            hold off
            subplot(2,1,1)

            plot(real(filter_out),'g');
            xlabel('Bits sequence');
            ylabel('Amplitude');
            title('receieve filter output in freq domain');
            ylabel('Real part of output of Rx filter')
            grid on
            subplot(2,1,2)
            plot(imag(filter_out),'r');
            grid on
            xlabel('Bits sequence');
            ylabel('Amplitude');
            ylabel('Imaginary part of output of Rx filter')

        end

    end



end