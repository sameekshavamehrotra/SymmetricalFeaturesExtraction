function [corr,peaks,values] = SYM_Labelling(pts)
%AUTHOR : Thomas C. Hnederson

[num_pts,pts_dim] = size(pts);
corr = zeros(num_pts,1);
pts_s = pts(:,2:floor(pts_dim/2)+1);
THRESH = min(100,0.2*max(max(pts_s)));
s_dim = size(pts_s,2);
peaks = zeros(num_pts,s_dim);
values = zeros(num_pts,s_dim);
T = ones(1,7)/7;
%for p = 1:num_pts
%    s = conv(pts_s(p,:),T,'same');
%    pts_s(p,:) = s;
%end
for p = 1:num_pts
    if (p==55)
        tch=0;
    end
    [sv,si] = sort(pts_s(p,:),'descend');
    si = si+ 1;
    first = si(1);
    index = 1;
    d = 2;
    while (rem(si(d),first)==0)&(si(d-1)<si(d))&(d<s_dim)
        index = index + 1;
        d = d + 1;
    end
    peaks(p,1:index) = si(1:index);
    values(p,1:index) = sv(1:index);
end
label = 1;
corr(1) = 1;
for p = 2:num_pts
    if values(p,1)<THRESH
        corr(p) = 0;
    elseif norm(peaks(p-1,:)-peaks(p,:))==0
        corr(p) = label;
    else
        label = label + 1;
        corr(p) = label;
    end
end
