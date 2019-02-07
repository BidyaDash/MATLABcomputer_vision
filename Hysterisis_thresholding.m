kim2=padarray(kim,[1,1]);t2=padarray(theta,[1,1]);lt=80;
for i=2:r+1
    for j=2:c+1
        if kim2(i,j)>=200
            if t2(i,j)==0
                if (t2(i+1,j)==0 )||( t2(i-1,j)==0)
                    if (kim2(i+1,j)>lt) || (kim2(i-1,j)>lt)
                        if ((kim2(i+1,j)>kim2(i+1,j-1) && kim2(i+1,j)>kim2(i+1,j+1))||(kim2(i-1,j)>kim2(i-1,j-1) && kim2(i-1,j)>kim2(i-1,j+1)))
                            kim2(i+1,j)=255;kim2(i-1,j)=255;
                        end
                    end
                end
            end
            elseif t2(i,j)==45
                if (t2(i-1,j+1)==45) || (t2(i+1,j-1)==45)
                    if (kim2(i-1,j+1)>lt) || (kim2(i+1,j-1)>lt)
                         if ((kim2(i-1,j+1)>kim2(i,j+2) && kim2(i-1,j+1)>kim2(i-2,j))||(kim2(i+1,j-1)>kim2(i+2,j) && kim2(i+1,j-1)>kim2(i,j-2)))
                            kim2(i+1,j)=255;kim2(i-1,j)=255;
                         end
                    end
                end
        
            elseif t2(i,j)==90
                if (t2(i,j-1)==45) || (t2(i,j+1)==45)
                    if (kim2(i,j-1)>lt) || (kim2(i,j+1)>lt)
                         if ((kim2(i,j-1)>kim2(i+1,j-1) && kim2(i,j-1)>kim2(i-1,j-1))||(kim2(i,j+1)>kim2(i-1,j+1) && kim2(i,j+1)>kim2(i+1,j+1)))
                            kim2(i,j-1)=255;kim2(i,j+1)=255;
                         end
                    end
                end
             elseif t2(i,j)==135
                if (t2(i-1,j-1)==135) || (t2(i+1,j+1)==135)
                    if (kim2(i-1,j-1)>lt) || (kim2(i+1,j+1)>lt)
                         if ((kim2(i-1,j-1)>kim2(i,j-2) && kim2(i-1,j-1)>kim2(i-2,j))||(kim2(i+1,j+1)>kim2(i+2,j) && kim2(i+1,j+1)>kim2(i,j+2)))
                            kim2(i-1,j-1)=255;kim2(i+1,j+1)=255;
                         end
                    end
                end
        
        
        end
    end
end
for i=1:r
    for j=1:c
        if kim2(i,j)~=255
            kim2(i,j)=0;
        end
    end
end