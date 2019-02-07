close all
clear all
clc
image=imread('peppers.png');    
Red = image(:,:,1);
    Green = image(:,:,2);
    Blue = image(:,:,3);
    %Get histValues for each channel
    Red = imhist(Red);
    Green = imhist(Green);
    Blue = imhist(Blue);
    y=[Red,Green,Blue];
    Red1=histeq(Red);
    Green1=histeq(Green);
    Blue1=histeq(Blue);
    
    %Plot them together in one plot
    figure
    subplot(2,1,1)
    stem(y);
    subplot(2,1,2)
    imhist(Red1);    
    imhist(Green1);    
    imhist(Blue1);
    
    