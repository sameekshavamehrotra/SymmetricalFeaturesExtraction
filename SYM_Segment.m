function [SegmentMatrix]=SYM_Segment(LabeledMatrix,FEP_Matrix,SD_Matrix,DFT_Matrix,Image)
%AUTHOR : Thomas C. Henderson
%This function segments the Image in Frequency Domain.
k = max(LabeledMatrix);
k_s = k;
MIN_SHOW_NUM = 20;
for s = 1:k
    s_set = find(LabeledMatrix==s);
    if MIN_SHOW_NUM<length(s_set)
        k_s = k_s - 1;
    end
end
[num_rows,num_cols] = size(DFT_Matrix);
change_rows = zeros(num_rows,num_cols);
for r = 1:num_rows-1
    if (LabeledMatrix(r)-LabeledMatrix(r+1))>0
        change_rows(r:r+1,:) = 0;
    else
        change_rows(r,:) = LabeledMatrix(r);
    end
end
num_p_rows = floor(k_s/4) + 2;
figure(1);
subplot(num_p_rows,4,1);
imshow(Image);
subplot(num_p_rows,4,2);
imshow(mat2gray(FEP_Matrix));
subplot(num_p_rows,4,3);
imshow(SD_Matrix>2000);
subplot(num_p_rows,4,4);
plot(0,0,'k.',4,4,'k.');
hold on
plot(LabeledMatrix);
hold off
s_s = 4;
SegmentMatrix=cell(1,k);
for s = 1:k
    s_set = find(LabeledMatrix==s);
    if length(s_set)>MIN_SHOW_NUM
        s_s = s_s + 1;
        LabelMatrix=(double(change_rows==s)).*double(FEP_Matrix);
        SegmentMatrix(1,s)=mat2cell(LabelMatrix);
        figure;
        imshow(mat2gray(LabelMatrix));
    end
end
end

