function [s_tilde] =rx_hardware( y, par_rxthresh, switch_graph)

    s_tilde = y;

    if switch_graph==1
        figure
        title('Output of Rx Hardware')
        subplot(221), plot(abs(y));
        title('Signal before Rx hardware')
        subplot(222), plot(angle(y));
        title('Signal before Rx hardware')
        subplot(223), plot(abs(s_tilde));
        title('Signal after Rx hardware')
        subplot(224), plot(angle(s_tilde));
        title('Signal after Rx hardware')
        
        
        %figure
        %eyediagram(s_tilde,2)

    end

end
