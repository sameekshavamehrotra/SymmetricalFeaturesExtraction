function [SymmetryGroup] = SYM_SymmetryGroup(RegionSegment)
%AUTHOR : Sameeksha Mehrotra
%This function detects the group of segmented region in an Image.
MaxFrequency=ArrayMaxValue(RegionSegment);
Matrix2=repmat(MaxFrequency,size(RegionSegment,1),size(RegionSegment,2));
Difference=Matrix2 - RegionSegment;
for intR= 1 : size(Difference,1),
for intC= 1 : size(Difference,2),
    E0=Difference(intR,intC)*10000;
    E1=floor(E0/1000);
    E2=E1/10;
    Difference(intR,intC)=E2;
end
end
[Row,Col]=find(Difference <= 0.1);
Number=numel(Row);
if(Number == (size(RegionSegment,1)*size(RegionSegment,2)))
        % Group=1 stands for O(2) Group present in the region of an Object and
        % shows that frequency distribution is constant throughout.
        Group=1;
else
    Rows=size(RegionSegment,1);
    Cols=size(RegionSegment,2);
    SimilarCounter=0;
    DifferentCounter=0;
    
    for intiCounter=1 : size(RegionSegment,2),            
        FirstColIndex=intiCounter;
        SecondColIndex=size(RegionSegment,2)-(FirstColIndex-1);
        Difference=RegionSegment(1 : Rows,FirstColIndex)-RegionSegment(1 : Rows,SecondColIndex);
        [R,C]=find(Difference <= 0.1);
        [R1,C1]=find(Difference > 0.1);
        if((numel(R) >= round(0.90*Rows)) && (numel(R1) <= round(0.10*Rows)))
            SimilarCounter=SimilarCounter + 1;
        else
            DifferentCounter=DifferentCounter + 1;
%             break;
        end
    end
    if((SimilarCounter >= (0.90*Cols)) && (DifferentCounter <= (0.10*Cols)))
        Proceed=1;
    else
        Proceed=0;
    end
    if(Proceed == 1)
        %Group=2 is the detection of Di-hedral Group in the region of an
        %Object.
        Group=2;
    else
        %Group=3 is the Cyclic Group in the region of an Object.
        Group=3;
    end 
end
    SymmetryGroup=Group;    
end

