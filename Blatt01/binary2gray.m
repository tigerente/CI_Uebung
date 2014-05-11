function grayCode = binary2gray(binaryCode)
%BINARY2GRAY 
% wandelt eine Binaerzahl in einen Gray-Code
% Inputargument und Outputargument sind die jeweilige Zahl als String

grayCode(1) = binaryCode(1);
for i = 2 : length(binaryCode);
    x = xor(str2num(binaryCode(i-1)), str2num(binaryCode(i)));
    grayCode(i) = num2str(x);
end

end

