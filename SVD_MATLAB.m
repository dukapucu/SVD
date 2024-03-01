clc;
clear;
close all;

image=imread("ist14.jpg");
subplot(1,2,1);
imshow(image);
title("Original Data");
image=double(image);
sizeImage=size(image);

[U1,S,V1]=svd(image(:,:,1),"econ");
S1=zeros(min(sizeImage(1),sizeImage(2)),1);
for i=1:min(sizeImage(1),sizeImage(2))
    S1(i)=S(i,i);
end

[U2,S,V2]=svd(image(:,:,2),"econ");
S2=zeros(min(sizeImage(1),sizeImage(2)),1);
for i=1:min(sizeImage(1),sizeImage(2))
    S2(i)=S(i,i);
end

[U3,S,V3]=svd(image(:,:,3),"econ");
S3=zeros(min(sizeImage(1),sizeImage(2)),1);
for i=1:min(sizeImage(1),sizeImage(2))
    S3(i)=S(i,i);
end  

x=15*(sizeImage(1)*sizeImage(2)/100)/(sizeImage(1)+sizeImage(2)+1);
approximation=zeros(sizeImage(1),sizeImage(2),sizeImage(3));

for i=1:x
    approximation(:,:,1)=approximation(:,:,1)+S1(i)*U1(:,i)*(V1(:,i))';
    approximation(:,:,2)=approximation(:,:,2)+S2(i)*U2(:,i)*(V2(:,i))';
    approximation(:,:,3)=approximation(:,:,3)+S3(i)*U3(:,i)*(V3(:,i))';
    compressedImage=uint8(approximation);
    subplot(1,2,2);
    imshow(compressedImage);
    per=(i*(sizeImage(1)+sizeImage(2)+1))/(sizeImage(1)*sizeImage(2))*100;
    title([num2str(per) '% of Original Data']);
    pause(0.001);
end



