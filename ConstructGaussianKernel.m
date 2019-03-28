function [ Kernel ] = ConstructGaussianKernel( Sigma,Size )
%AUTHOR : Sameeksha Mehrotra
%This functions contructs the gaussian kernel of specified size.

Kernel=zeros(Size,Size);
for inti= 1 : Size,
    for intj=1 : Size,
        Kernel(inti,intj)=CalculateGaussian2D(Sigma,(inti-round(Size/2)),(intj-round(Size/2)));
    end
end
end

