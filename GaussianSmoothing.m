function [SSD_Matrix]=GaussianSmoothing(D_Matrix,Sigma,KernelSize)
%AUTHOR : Sameeksha Mehrotra
%This function convolves the Image with Guassian Smoothening Filter to
%calculate the smoothened Image with noise components removed.

SSD_Matrix=zeros(size(D_Matrix,1),size(D_Matrix,2));
[GaussianKernel]=ConstructGaussianKernel( Sigma,KernelSize );

RangeY=size(D_Matrix,1);
RangeX=size(D_Matrix,2);

for intY=1 : RangeY,
    for intX= 1 : RangeX,
        SUM=0;
         if(intY == 1 || intY == RangeY)
             SUM=0;
         elseif(intX ==1 || intX == RangeX)
             SUM=0;
         else
             counter1=0;
             for intRow=(intY-1) : (intY+1),
                 counter1=counter1 + 1;
                 counter2=0;
                 for intCol= (intX-1) : (intX+1),
                     counter2=counter2 + 1;
                     SUM=SUM + str2double(num2str(D_Matrix(intRow,intCol)))*GaussianKernel(counter1,counter2);  
                 end
             end
         end       
         if(SUM > 255)
             SUM=255;
         elseif(SUM < 0)
             SUM=0;
         else
             SSD_Matrix(intY,intX)=int8(SUM);
         end       
    end
end
end

