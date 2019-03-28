function [ RSS_Value ] = SYM_RSS(SD_Matrix,N)
%AUTHOR : Sameeksha Mehrotra
%This function computes RSS value at every pixel position in an Image.
    RSS_Value=0;
    Rows=size(SD_Matrix,1);
    
    N=size(SD_Matrix,2);
    
    for intRow=1 : Rows,
        VectorX=SD_Matrix(intRow,2:(N/2));
        Mean=mean(VectorX);  
        StandDeviation=std(VectorX);

        Value=Mean + 2*StandDeviation;
        [Row,Col,PeakValues]=find(SD_Matrix(intRow,:)> Value);

        MinValue=ArrayMinValue(PeakValues);
        NumberDivisible=0;

        for iRow=1 : size(PeakValues,2),
            Dividend=PeakValues(1,iRow);
            Quotient=idivide(int32(Dividend),int32(MinValue));
            Remainder=int32(Dividend)-(int32(Quotient)*int32(MinValue));
            if(Remainder == 0)
                NumberDivisible=NumberDivisible + 1;
            end
        end

        if(NumberDivisible == length(PeakValues))
            Rho=1;
        else
            Rho=0;
        end        
        RSS_Value=RSS_Value + (mean(PeakValues)*Rho)/(Mean);
    end
end

