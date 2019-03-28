function [DFT_Matrix,SD_Matrix]=SYM_DFT(FEP_Matrix)
%AUTHOR : Sameeksha Mehrotra
%This function computes the 2 dimensional DFT for an Image.

    Rows=size(FEP_Matrix,1);
    Cols=size(FEP_Matrix,2);
    N=Cols;    

    for intRow= 1 : Rows,
        for intCol=1 :  Cols,           
            r=intRow;
            k=intCol;            
            RealPart=0;
            ImaginaryPart=0;
            for n= 1 : N,
                Step=2*pi/N;
                Theta=Step*(n-1)*(k-1);
                RealPart=RealPart + cos(Theta)*double(FEP_Matrix(r,k));
                ImaginaryPart=ImaginaryPart + (-1)*sin(Theta)*double(FEP_Matrix(r,k));
            end
            Frequency_Value=[num2str(RealPart),'+',num2str(ImaginaryPart),'i'];
            DFT_Matrix(r,k)=mat2cell(str2mat(Frequency_Value));
            SD_Matrix(r,k)=sqrt(double(RealPart^2) + double(ImaginaryPart^2));
         end
    end
end

