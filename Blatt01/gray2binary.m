function binaryCode = gray2binary(grayCode)
%GRAY2BINARY
% wandelt einen Gray-Code in eine Binaerzahl
% Inputargument und Outputargument sind die jeweilige Zahl als String

binaryCode(1) = grayCode(1);
for i = 2 : length(grayCode);
    x = xor(str2num(binaryCode(i-1)), str2num(grayCode(i)));
    binaryCode(i) = num2str(x);
end

end

