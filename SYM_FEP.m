function [ FEP_Matrix ] = SYM_FEP(Image,OriginX,OriginY)
%AUTHOR: Sameeksha Mehrotra
%This function calculates FEP of an Image.

N=90;
AngularStep=2*pi/N;

D(1,1)=OriginY-1;
D(1,2)=size(Image,1)-OriginY;
D(1,3)=OriginX-1;
D(1,4)=size(Image,2)-OriginX;

Radius=ArrayMinValue(D);

LinearStep=1/(2*Radius + 1);
Col=0;

for Angle= 0 : AngularStep : (2*pi)      
    Col=Col + 1;
    Row=0;
    P1X=OriginX + Radius*cos(Angle);
    P1Y=OriginY + Radius*sin(Angle);
    
    P2X=OriginX + Radius*cos(pi + Angle);
    P2Y=OriginY + Radius*sin(pi + Angle);
    
    for Step= 0 : LinearStep : 1
        Row=Row + 1;
        PX=round((1-Step)*P1X + (Step)*P2X);
        PY=round((1-Step)*P1Y + (Step)*P2Y);
        FEP_Matrix(Row,Col)=Image(PY,PX);
    end
end

% figure;
% imshow(mat2gray(FEP_Matrix));
% TitleName=['Frieze Expansion Plot for Coordiantes with X=',num2str(OriginX),'and Y=',num2str(OriginY)];
% title(TitleName);

end

