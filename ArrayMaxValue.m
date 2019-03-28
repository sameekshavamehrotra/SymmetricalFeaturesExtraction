function [ maxValue ] = ArrayMaxValue( Image1D )
%AUTHOR : Sameeksha Mehrotra
%This function computes maximum value of the array Image1D 
% where Image1D is the array of gray levels in an image

    maxValue=Image1D(1);
    
    for intjCounter=1 : numel(Image1D),
        if(Image1D(intjCounter) > maxValue)
            maxValue=Image1D(intjCounter);
        end
    end
end

