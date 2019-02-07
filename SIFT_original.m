clear all
close all
clc
img=imread('images/lena.png');
imb=rgb2gray(img);temp=impyramid(imb,'expand');
b={};dog={};
for k=1:4
    temp=impyramid(temp,'reduce');
    [r,c]=size(temp);
    for i=1:5
        im(1:r,1:c,i)=imgaussfilt(temp,(1/sqrt(2))*(2^(k-1))*(sqrt(2)^(i-1)));
    end
    b(1,k)={im(1:r,1:c,:)};
end
for k=1:4
   dog_temp=cell2mat(b(1,k));
   [r1,c1,a1]=size(dog_temp);
    for i=1:4
        im_temp(1:r1,1:c1,i)=dog_temp(1:r1,1:c1,i)-dog_temp(1:r1,1:c1,i+1);
    end
   dog(1,k)={im_temp(1:r1,1:c1,:)};
end


    
   

        