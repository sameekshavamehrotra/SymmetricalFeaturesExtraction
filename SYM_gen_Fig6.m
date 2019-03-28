function Fig6 = SYM_gen_Fig6
%

num_rows = 101;
num_cols = 101;
radius1 = 25;
radius2 = 17;
radius3 = 7;
Fig6 = ones(num_rows,num_cols);
ctr_r = 51;
ctr_c = 51;
ctr_x = ctr_c;
ctr_y = 101 - ctr_r + 1;
del_theta = 1/radius1;
for theta = 0:del_theta:2*pi
    cos_theta = cos(theta);
    sin_theta = sin(theta);
    for rho = 0:0.5:radius1
        x = rho*cos_theta + ctr_x;
        y = rho*sin_theta + ctr_y;
        r = max(1,floor(x));
        c = num_rows - max(1,floor(y)) + 1;
        Fig6(r,c) = 0.7;
    end
end
del_theta = 1/radius2;
for theta = 0:del_theta:2*pi
    cos_theta = cos(theta);
    sin_theta = sin(theta);
    for rho = 0:0.5:radius2
        x = rho*cos_theta + ctr_x;
        y = rho*sin_theta + ctr_y;
        r = max(1,floor(x));
        c = num_rows - max(1,floor(y)) + 1;
        Fig6(r,c) = 0.25;
    end
end
del_theta = 0.01;
for theta = 0:del_theta:2*pi
    cos_theta = cos(theta);
    sin_theta = sin(theta);
    del_rho = 9+9*sin(16*theta);
    for rho = 0:0.5:radius3+del_rho
        x = rho*cos_theta + ctr_x;
        y = rho*sin_theta + ctr_y;
        r = max(1,floor(x));
        c = num_rows - max(1,floor(y)) + 1;
        Fig6(r,c) = 0.5;
    end
end
