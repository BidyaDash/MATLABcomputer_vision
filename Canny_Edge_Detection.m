
clear all
close all
clc
imc=imread('gt1.jpg');
k=(1/159)*[2 4 5 4 2;4 9 12 9 4;5 12 15 12 5;4 9 12 9 4;2 4 5 4 2];

im=rgb2gray(imc);
img1=padarray(im,[2,2]);
[r,c]=size(im);
z=zeros(r,c);px=z;py=z;p=z;theta=z;fim=z;
for i=1:r
    for j=1:c
        z(i,j)=sum(sum(double(img1(i:i+4,j:j+4)).*k));         %GAUSSIAN SMOOTHING.
        
    end
end
img2=padarray(z,[1,1]);
gy=[1 2 1;0 0 0;-1 -2 -1];
gx=[1 0 -1;2 0 -2;1 0 -1];
for i=1:r
    for j=1:c
        px(i,j)=sum(sum(double(img2(i:i+2,j:j+2)).*gx));
        py(i,j)=sum(sum(double(img2(i:i+2,j:j+2)).*gy));        %CALCULATING GRADIENTS/M-VALUES.
        p(i,j)=sqrt((px(i,j)^2)+(py(i,j)^2));
        theta(i,j)=atand(py(i,j)/px(i,j));
    end
end
for i=1:r
    for j=1:c
        if theta(i,j)<0
            theta(i,j)=theta(i,j)+180;                          %ADJUSTING NEGATIVE VALUE OF ANGLES IN THE POSITIVE REGION.
        end
    end
end

for i=1:r
    for j=1:c
        if (theta(i,j)>157.5 && theta(i,j)<=22.5)
            theta(i,j)=0;
        elseif (theta(i,j)>22.5 && theta(i,j)<=67.5)                     %ROUNDING OFF ANGLES TO NEAREST 45 DEGREE.
            theta(i,j)=45;
        elseif (theta(i,j)>67.5 && theta(i,j)<=112.5)
            theta(i,j)=90;
        elseif (theta(i,j)>112.5 && theta(i,j)<=157.5)
            theta(i,j)=135;
        end
    end
end
pim=padarray(p,[1,1]);theta=padarray(theta,[1,1]);fim=padarray(fim,[1,1]);
disp('OVER');
for i=2:r+1
    for j=2:c+1
        if theta(i,j)==0
            if ((pim(i,j-1)<=pim(i,j)) && (pim(i,j)>=pim(i,j+1)))
            fim(i,j)=pim(i,j);
            else
                fim(i,j)=0;                                                  %NON-MAXIMAL SUPPRESSION.
            end
        elseif theta(i,j)==45
            if ((pim(i-1,j-1)<=pim(i,j)) && (pim(i,j)>=pim(i+1,j+1)))
            fim(i,j)=pim(i,j);
            else
                fim(i,j)=0;
            end
        elseif theta(i,j)==90
            if ((pim(i-1,j)<=pim(i,j)) && (pim(i,j)>=pim(i+1,j)))
            fim(i,j)=pim(i,j);
            else
                fim(i,j)=0;
            end
        elseif theta(i,j)==135
            if ((pim(i-1,j+1)<=pim(i,j)) && (pim(i,j)>=pim(i+1,j-1)))
            fim(i,j)=pim(i,j);
            else
                fim(i,j)=0;
            end
        end
    end
end
 fim(1,:)=[];fim(:,1)=[];fim(r+1,:)=[];fim(:,c+1)=[];
 htr=0.05;ltr=0.025;ut=max(fim(:))*htr;lt=ut*ltr;
for i=1:r
    for j=1:c
        if fim(i,j)>ut
            fim(i,j)=255;
        elseif fim(i,j)>=lt && fim(i,j)<=ut
            continue;
        else
            fim(i,j)=0;
        end
    end
end


   
   
     aboveT2 = fim > lt;                               %HYSTERISIS THRESHOLDING                                                       % Edge points above lower threshold
                                               
     [aboveT1r, aboveT1c] = find(fim > ut);
                                                       % Row and column coords of points above upper threshold.
      bw = bwselect(aboveT2, aboveT1c, aboveT1r, 8);   % Obtain all connected region above lower thresh 
                                                       %that include a point that has a value above upper thresh%
 
 
  
  
 figure
    imshowpair(imc,bw,'montage')
    title('CANNY EDGES')
    disp('END')