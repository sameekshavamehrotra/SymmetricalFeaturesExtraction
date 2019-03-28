function [ LOGImage ] = ComputeLOG( InputImage,Sigma,KernelSize)
%AUTHOR : Sameeksha Mehrotra
%This function computes Laplacian of the Gaussian function on an Input Image.

%LOGKernel=[0,1,1,2,2,2,1,1,0;1,2,4,5,5,5,4,2,1;1,4,5,3,0,3,5,4,1;2,5,3,-12,-24,-12,5,3,2;2,5,0,-24,-40,-24,0,5,2;2,5,3,-12,-24,-12,3,5,2;1,4,5,3,0,3,5,4,1;1,2,4,5,5,5,4,2,1;0,1,1,2,2,2,1,1,0]; 

[LOGKernel]=ConstructLOGKernel( Sigma,KernelSize );
LOGImage=zeros(size(InputImage,1),size(InputImage,2));

RangeY=size(LOGImage,1);
RangeX=size(LOGImage,2);

for intY=1 : RangeY,
    for intX= 1 : RangeX,
        SUM=0;
         if(intY == 1 || intY == 2 || intY ==3 || intY == 4 || intY == (RangeY-3) || intY == (RangeY-2)||intY ==(RangeY-1) || intY == RangeY)
             SUM=0;
         elseif(intX == 1 || intX == 2 || intX ==3 || intX == 4 || intX == (RangeX-3) || intX == (RangeX-2)||intX ==(RangeX-1) || intX == RangeX)
             SUM=0;
         else
             counter1=0;
             for intRow=(intY-4) : (intY+4),
                 counter1=counter1 + 1;
                 counter2=0;
                 for intCol= (intX-4) : (intX+4),
                     counter2=counter2 + 1;
                     SUM=SUM + str2double(num2str(InputImage(intRow,intCol)))*LOGKernel(counter1,counter2);  
                 end
             end
         end       
         if(SUM > 255)
             SUM=255;
         elseif(SUM < 0)
             SUM=0;
         else
             LOGImage(intY,intX)=int8(SUM);
         end       
    end
end
figure;
imshow(mat2gray(LOGImage));
end

