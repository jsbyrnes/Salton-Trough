function [ vp, vs ] = iasp91( zn )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    x = dlmread('IASP91.csv');
    
    vp = interp1(x(:, 1) + cumsum(0.01*ones(size(x(:, 4)))), x(:, 3), zn, 'nearest');
    vs = interp1(x(:, 1) + cumsum(0.01*ones(size(x(:, 4)))), x(:, 4), zn, 'nearest');

end

