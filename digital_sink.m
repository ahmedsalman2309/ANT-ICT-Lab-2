function BER = digital_sink(b,b_hat)

    error = abs(b-b_hat);
    BER = sum(error)/length(b);

end
