%draw ellipse

% clc;
clear;
close all;

data=textread('mag_raw.TXT');
mag=data;
figure(1);
hold off;
plot3(mag(:,1),mag(:,2),mag(:,3), '*');
grid on
axis equal;
xlabel('x');
ylabel('y');
zlabel('z');

figure(2);
subplot(2,2,1);
hold off;
plot(mag(:,1),mag(:,2));
legend('x-y');
axis equal;
grid on;

subplot(2,2,2);
hold off;
plot(mag(:,1),mag(:,3));
legend('x-z');
axis equal;
grid on;

subplot(2,2,3);
hold off;
plot(mag(:,2),mag(:,3));
legend('y-z');
axis equal;
grid on;

%fit
% [ center, radii, evecs, v ] = ellipsoid_fit(mag,1);
[ center, radii, rec] = ellipsoid_fit_rls(mag);
% center
% 1./radii*500
% evecs'

%
corMag=mag-repmat(center',length(mag),1);
% corMag=(evecs'*corMag')';
corMag(:,1) = corMag(:,1)/radii(1)*500;
corMag(:,2) = corMag(:,2)/radii(2)*500;
corMag(:,3) = corMag(:,3)/radii(3)*500;

figure(3);
plot3(corMag(:,1),corMag(:,2),corMag(:,3),'*');
grid on
axis equal;
xlabel('x');
ylabel('y');
zlabel('z');

figure(2);
subplot(2,2,1);
hold on;
plot(corMag(:,1),corMag(:,2),'r');
legend('x-y');
axis equal;
grid on;

subplot(2,2,2);
hold on;
plot(corMag(:,1),corMag(:,3),'r');
legend('x-z');
axis equal;
grid on;

subplot(2,2,3);
hold on;
plot(corMag(:,2),corMag(:,3),'r');
legend('y-z');
axis equal;
grid on;

subplot(2,2,4);
hold on;
plot(rec');
title('convergency');
% legend('residual');
grid on;