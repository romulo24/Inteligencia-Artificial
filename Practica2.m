clc;clear; close all;
load("Inteligencia Artificial/matricesPr2.mat");
x1 = Xnum(1,:);
x1 = transpose(x1);
A1 = reshape(x1,5,4);
figure
imshow(A1)
x2 = Xnum(2,:);
x2 = transpose(x2);
A2 = reshape(x2,5,4);
figure
imshow(A2)
x3 = Xnum(3,:);
x3 = transpose(x3);
A3 = reshape(x3,5,4);
figure
imshow(A3)
x4 = Xnum(4,:);
x4 = transpose(x4);
A4 = reshape(x4,5,4);
figure
imshow(A4)
y=[3;1;4;2];
x1b=im1(:);
x2b=im2(:);
x3b=im3(:);
Xletters = [x1b'; x2b'; x3b'];
s = sum(Xletters, 2);
figure
scatter(X1(:,1),X1(:,2));
figure
scatter3(X2(:,1), X2(:,2), X2(:,3));
cars = readmatrix("cars.xlsx");
xcars = cars(:,1:3);
ycars = cars(:,4);
figure
subplot(1,2,1);
scatter3(xcars(:,1), xcars(:,2), xcars(:,3));
xlabel('distancia');
ylabel('Age');
zlabel('Cilindraje');
subplot(1,2,2);
scatter3(xcars(:,1), xcars(:,2), xcars(:,3));
xlabel('distancia');
ylabel('Age');
zlabel('Cilindraje');
view(0,90);
figure 
scatter(xcars(:,1), ycars);
xlabel('distancia');
ylabel('precio');
