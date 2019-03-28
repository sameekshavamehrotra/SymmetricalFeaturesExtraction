function [ minValue ] = ArrayMinValue( Image1D )
%AUTHOR : Sameeksha Mehrotra
%This function computes minimum value of the array Image1D
%where Image1D is the array of gray levels in an image
    minValue=Image1D(1);
    
    for intjCounter=1 : numel(Image1D),
        if(Image1D(intjCounter) < minValue)
            minValue=Image1D(intjCounter);
        end
    end
end

