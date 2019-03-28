function [ GaussianValue ] = CalculateGaussian2D( Sigma,Y,X )
%AUTHOR : Sameeksha Mehrotra
%This function calculates Gaussian at a particular Point to build a kernel
%of specific size.

Y=abs(Y);
X=abs(X);

GaussianValue =0;
for inti= (Y-0.5) : 0.1 : (Y + 0.55),
    for intj=(X-0.5) : 0.1 : (X + 0.55),
        Value=exp(((-1)*(inti^2 + intj^2))/(2*Sigma^2));
        GaussianValue=GaussianValue + Value/(2*3.14 * (Sigma^2));
    end
end
GaussianValue=GaussianValue/121;
end

