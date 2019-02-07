close all
clear all
clc
imc=imread('bid3.jpg');
img=rgb2gray(imc);
sx=[1 0 -1;2 0 -2;1 0 -1];
sy=[1 2 1;0 0 0;-1 -2 -1];
g=(1/159)*[2 4 5 4 2;4 9 12 9 4;5 12 15 12 5;4 9 12 9 4;2 4 5 4 2];
[r,c]=size(img);Ix=zeros(r,c);Iy=Ix;Ix2=Ix;Iy2=Ix;Ixy=Ix;Hx=Ix;Hy=Ix;Hxy=Ix;R=Ix;Fim=Ix;
im=padarray(img,[1,1]);
k=0.05;
for i=1:r
    for j=1:c
        Ix(i,j)=sum(sum(double(im(i:i+2,j:j+2)).*sx));
        Iy(i,j)=sum(sum(double(im(i:i+2,j:j+2)).*sy));
        Ix2(i,j)=Ix(i,j)^2;
        Iy2(i,j)=Iy(i,j)^2;
        Ixy(i,j)=Ix(i,j)*Iy(i,j);
    end
end
Ix2=padarray(Ix2,[2,2]);
Iy2=padarray(Iy2,[2,2]);
Ixy=padarray(Ixy,[2,2]);
for i=1:r
    for j=1:c
        Hx(i,j)=sum(sum(double(Ix2(i:i+4,j:j+4).*g)));
        Hy(i,j)=sum(sum(double(Iy2(i:i+4,j:j+4).*g)));
        Hxy(i,j)=sum(sum(double(Ixy(i:i+4,j:j+4).*g)));
    end
end

for i=1:r
    for j=1:c
        M=[Hx(i,j),Hxy(i,j);Hxy(i,j),Hy(i,j)];
        e=eig(M);
        a1=e(1);a2=e(2);
        R(i,j)=(a1*a2)-(k*((a1+a2)^2));
    end
end
m=mean(R(:));s=std2(R(:));

 for i=1:r
     for j=1:c
         if R(i,j)<(m+s)
             R(i,j)=0;                                %THRESHOLDING.
         end
     end
 end
 
 Rp=padarray(R,[1,1]);
 for i=1:r
     for j=1:c
         m=Rp(i:i+2,j:j+2);
         if R(i,j)==max(m(:))                         %NON-MAXIMAL SUPPRESSION.
             continue;
         else
             R(i,j)=0;
         end
     end
 end
figure
imshow(imc)
 for i=1:r
     for j=1:c
         if R(i,j)~=0
             str='o';
             text(j,i,str,'Fontsize',12,'Color','r','HorizontalAlignment','center','VerticalAlignment','middle');
             
         end
     end
 end
  