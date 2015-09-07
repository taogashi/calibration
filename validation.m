% validation
v = zeros(1,6);
yita = 1-center(1)^2/radii(1)^2-center(2)^2/radii(2)^2-center(3)^2/radii(3)^2;
v(1) = 1/(radii(1)^2*yita);
v(2) = 1/(radii(2)^2*yita);
v(3) = 1/(radii(3)^2*yita);
v(4) = -center(1)*v(1);
v(5) = -center(2)/radii(2)^2/yita;
v(6) = -center(3)/radii(3)^2/yita;
v*1000