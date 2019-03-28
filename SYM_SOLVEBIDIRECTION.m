function [D_Matrix]=SYM_SOLVEBIDIRECTION(Image,Equations)
%AUTHOR: Sameeksha Mehrotra
%This function computes the intersection points of every pair of bi
%directional flows and calculate the frequency of occurrence of every
%intersection point in a D_Matrix.

    D_Matrix=zeros(size(Image,1),size(Image,2));
    for iFirst=1 : size(Equations,1)-1,
        for iSecond=(iFirst + 1) : size(Equations,1),
            EQ1=cell2mat(Equations(iFirst,1));
            EQ2=cell2mat(Equations(iSecond,1));
            
            s1=EQ1(1,3);
            x1=EQ1(1,1);
            y1=EQ1(1,2);
            
            s2=EQ2(1,3);
            x2=EQ2(1,1);
            y2=EQ2(1,2);
            
            X=(s1*x1-s2*x2+y2-y1)/(s1-s2);
            Y=(s1*s2*(x1-x2)+s1*y2-s2*y1)/(s1-s2);
            
            intX=floor(X);
            intY=floor(Y);
            if((intX >=1 && intX <= size(Image,2))&&(intY>=1 && intY<=size(Image,1)))
             D_Matrix(intY,intX)=D_Matrix(intY,intX) + 1;
            end
        end
    end
end

