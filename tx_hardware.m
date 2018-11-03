function [ x ] = tx_hardware( s, par_txthresh, switch_graph )
%TX_HARDWARE Summary of this function goes here
%   Detailed explanation goes here

    for i = 1:1:length(s)
        if abs(s(i)) <= par_txthresh
            x(i) = s(i);
        elseif abs(s(i)) > par_txthresh
            x(i) = sign(real(s(i)))*0.707 + sign(imag(s(i)))*0.707i;
        end
    end
    x = reshape(x,length(x),1);
    
    if switch_graph == 1
        figure
        title('Output of Tx Hardware')
        subplot(221), plot(abs(s));
        title('Signal before Tx hardware')
        subplot(222), plot(angle(s));
        title('Signal before Tx hardware')
        subplot(223), plot(abs(x));
        title('Signal after Tx hardware')
        subplot(224), plot(angle(x));
        title('Signal after Tx hardware')
    end
end
