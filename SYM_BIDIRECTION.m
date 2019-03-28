function [ Equations ] = SYM_BIDIRECTION(DFT_Matrix,Equations,counter,X,Y)
%AUTHOR : Sameeksha Mehrotra
%This function computes a probable center of Symmetry points based on
%Intersection of bi-directional flows in an Image around the center.

Rows=size(DFT_Matrix,1);       

    Angle=rand(Rows,1);
    for intRow= 1 : Rows,
        ComplexNumber=str2num(eval(mat2str(cell2mat(DFT_Matrix(intRow,2)))));
        RealPart=real(ComplexNumber);
        ImaginaryPart=imag(ComplexNumber);
        Fraction=RealPart/ImaginaryPart;
        if(ImaginaryPart == 0)
            Angle(intRow,1)=0;
        else
            Angle(intRow,1)=atan(Fraction);
        end        
    end

    MedianValue=median(Angle);
    AngleTangent=tan(MedianValue);
    Slope=(-1)*(1/AngleTangent);
   
    Attributes=rand(1,3);
    
    Attributes(1,1)=X;
    Attributes(1,2)=Y;
    Attributes(1,3)=Slope;
    Equations(counter,1)=mat2cell(Attributes);
end

