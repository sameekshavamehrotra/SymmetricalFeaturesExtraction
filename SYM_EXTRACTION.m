function [FEP,RSSCenterR,RSSCenterC,SSDCenterR,SSDCenterC,SegmentMatrix,SymmetryGroup,Cardinality,Shape]=SYM_EXTRACTION(OriginalImage)
%AUTHOR : Sameeksha Mehrotra
%This algorithm is the center of execution off entire software and calls
%different functions to accomplish following tasks for extraction of
%symmetry features.

%INPUT: Original Image
%OUTPUT: 
%1. FEP Matrix
%2. Centers detected by RSS,SSD
%3. Cell Matrix containing Segments as Individual cell Matrices
%4. Symmetry Group Type
%5. Symmetry Group Cardinality
%6. Shape matrix of an Object

%SECTION 1: Extraction of Symmetrical Features.
%Detects Frieze Expansion Pattern in an Image.

%Computes DFT Matrix and Spectral Density Matrix for a FEP.

%Detects Center of Rotation Symmetry in an Image using RSS/SSD algorithm.

%Determine supporting regions(Segmented Regions)in a DFT of Frieze
%Expansion Pattern.

%Determine Symmetry Group of an Object by analyzing the symmetry group for
%every supporting region.

%Determine the Cardinality of Symmetry Group for every Supporting Region.

Image=OriginalImage(:,:,1);
RSSIntensityValue=255;

Equations=cell(144,1);            
counter=0;

% Iterate through a 12 by 12 kernel around supposed center of an Image to %find center of rotation symmetry.
for C1= -6 : 6
    for C2=-6 : 6            
        PX=size(Image,2)/2 + C1;
        PY=size(Image,1)/2 + C2;
        counter=counter + 1;

% Calls SYM_FEP to calculate FEP of the prospective center.
        [FEP_Matrix] = SYM_FEP(Image,PX,PY);
        FEP=FEP_Matrix/RSSIntensityValue;
        [R,C]=find(FEP ~= 1);
        ColSize=size(FEP,2);  

% Display the distribution of intensity for a row of the FEP.                  
        figure;
        plot(0,0,'.k',(ColSize + 10),2,'k.',(1:ColSize),FEP(R(1),:));

% Calls SYM_DFT to calculate DFT for the FEP of the prospective center 
% (X,Y) of an Image.
        [DFT_Matrix,SD_Matrix]=SYM_DFT(FEP_Matrix);

% Calls SYM_RSS to compute the RSS values of the DFT of an Image for prospective center (X,Y).
        RSS_Matrix=zeros(size(Image,1),size(Image,2));
        [RSS_Value]=SYM_RSS(SD_Matrix); 
        RSS_Matrix(round(PY),round(PX))=RSS_Value;

% Calls SYM_BIDIRECTION to form equation of a bi-directional line passing 
% through prospective center (X,Y).
        [Equations] = SYM_BIDIRECTION(DFT_Matrix,Equations,counter,PX,PY);
    end
end 

%Calculate the point with maximum RSS Value and highlight it as center on 
% an Image with white color.

RSSMaxValue=ArrayMaxValue(RSS_Matrix);
[Row,Col]=find(RSS_Matrix == RSSMaxValue);
RSSCenterR=Row;RSSCenterC=Col;
Image(Row,Col)=RSSIntensityValue;            
figure;
imshow(Image);
title('Center of Rotation Symmetry determined by RSS Algorithm.');

% Calls the SYM_Labelling and SYM_Segment to determine the supporting 
% regions of an Image using DFT. 

[LabeledMatrix,im3_peaks,im3_values] = SYM_Labelling(SD_Matrix);
[SegmentMatrix]=SYM_Segment(LabeledMatrix,FEP_Matrix,SD_Matrix,DFT_Matrix,Image);

% Rounds off the Spectral Density of the region to one decimal place for 
% the computation of Symmetry Group.
for intCount= 1 : size(SegmentMatrix,2),
    Matrix=cell2mat(SegmentMatrix(1,intCount));
    Matrix=Matrix/255;
    for intR= 1 : size(Matrix,1),
        for intC= 1 : size(Matrix,2),
                E0=Matrix(intR,intC)*10000;
                E1=floor(E0/1000);
                E2=E1/10;
                Matrix(intR,intC)=E2;
        end
    end
    if((size(Matrix,1)*size(Matrix,2)) ~= 0)
        [R,C]=find(Matrix ~= 0);  
        counter = 0;
        RMatrix=zeros(1,max(max(R)));
        for intR = 1 : max(max(R)),
            [R1,C1]=find(Matrix(intR,:) == 0);
            if(numel(C1) == 0)
                counter = counter + 1;
                RMatrix(1,counter)=intR;
            end
        end
        MinR=RMatrix(1,1);
        MaxR=max(max(RMatrix));
        MinC=min(min(C));
        MaxC=max(max(C)); 
        if(MinR ~= 0 && MaxR ~= 0 && MinC ~= 0 && MaxC ~= 0)
            RegionSegment=Matrix(MinR : MaxR,MinC : MaxC);
% Calls SYM_SymmetryGroup to compute the symmetry group for the supporting % region.
            [SymmetryGroup] = SYM_SymmetryGroup(RegionSegment);
% Calls SYM_SymmetryGroupCardinality to detect cardinality of Symmetry 
% Group.
            [Cardinality] = SYM_SymmetryGroupCardinality(FEP_Matrix,MinR,MaxR,MinC,MaxC);
        end
    end
end

%Calls SYM_SOLVEBIDIRECTION to solve for equations made for every 
% prospective center(X,Y),such that to find intersection point of every 
% pair of equation in set Equations.

[D_Matrix]=SYM_SOLVEBIDIRECTION(Image,Equations);
Sigma=0.5;KSize=3;
[SSD_Matrix]=GaussianSmoothing(D_Matrix,Sigma,KSize);

% Calculate the point intersection point with maximum SSD value and display % it on an Image in red color.

SSDMaxValue=ArrayMaxValue(SSD_Matrix);
[Row,Col]=find(SSD_Matrix == SSDMaxValue);       
SSDCenterR=Row;SSDCenterC=Col;
X=floor(mean(Col));
Y=floor(mean(Row));

OriginalImage(Y,X,1)=76;
OriginalImage(Y,X,2)=0;
OriginalImage(Y,X,3)=0;

figure;
imshow(OriginalImage);
title('Center of Rotation Symmetry determined by SSD Algorithm.');

%SECTION 2: Extraction of Shape of an Object.
%This section extracts the Shape of an object using Laplacian of
%Gaussian algorithm over an Object.

Sigma=0.7;
KernelSize=9;
Shape=ComputeLOG(Image,Sigma,KernelSize);

end

