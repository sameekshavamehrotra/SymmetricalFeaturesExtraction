function [ Cardinality ] = SYM_SymmetryGroupCardinality(FEP_Matrix,MinR,MaxR,MinC,MaxC)
%AUTHOR : Sameeksha Mehrotra
%This function determines the cardinality of the symmetry Group.

DFTCoefficient=zeros(1,floor(MaxC-MinC)+1);
FEP_Double=double(FEP_Matrix(MinR:MaxR,MinC:MaxC));
DFT=fft2(FEP_Double,size(FEP_Double,1),size(FEP_Double,2));

for intCol= 1 : size(DFT,2),
    Sum=0;
    for intRow=1 : size(DFT,1),
        Sum=Sum + DFT(intRow,intCol);        
    end
    DFTCoefficient(1,intCol)=Sum;
end

figure;
plot(2:floor(size(DFTCoefficient,2)/2),abs(DFTCoefficient(1,2:floor(size(DFTCoefficient,2)/2))));

MaxValue=max(max(DFTCoefficient(1,2:floor(size(DFTCoefficient,2)/2))));
[Row,Column]=find(DFTCoefficient(1,2:floor(size(DFTCoefficient,2)/2)) == MaxValue);
Cardinality=Column-1;
end

