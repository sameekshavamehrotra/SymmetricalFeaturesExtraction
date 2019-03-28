function [ LOGValue ] = CalculateLOG2D( Sigma,Y,X )
%%AUTHOR : Sameeksha Mehrotra
%This function calculates Gaussian at a particular Point to build a kernel
%of specific size.

Y=abs(Y);
X=abs(X);

LOGValue =0.0;
for inti= (Y-0.5) : 0.1 : (Y + 0.55),
    for intj=(X-0.5) : 0.1 : (X + 0.55),
        Value1=(-1)*((inti^2 + intj^2)/(2*Sigma^2));
        LOGValue=LOGValue + (1/(3.14*Sigma^4))*(1+Value1)*exp(Value1);
    end
end
LOGValue=-LOGValue/121;
end



