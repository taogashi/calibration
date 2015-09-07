function [ center, radii, vrec] = ellipsoid_fit_rls(X)
 
if size( X, 2 ) ~= 3
    error( 'Input data must have three columns!' );
else
    x = X( :, 1 );
    y = X( :, 2 );
    z = X( :, 3 );
end

% need nine or more data points
if length( x ) < 6 && flag == 1
   error( 'Must have at least 6 points to fit a unique oriented ellipsoid' );
end


% fit ellipsoid in the form Ax^2 + By^2 + Cz^2 + 2Gx + 2Hy + 2Iz = 1

v = [1 1 1 1 1 1]';
P = 10 * eye(6);
Q = zeros(6,6);
R = 1;

last_data = [0;0;0];
too_close = 0;

lastv = v;
j = 1;
endcnt = 1;

for i = 1:length(x)
    if norm([x(i);y(i);z(i)]-last_data)/norm([x(i);y(i);z(i)]) < 0.1
        too_close = too_close + 1;
        if too_close > 5
            continue;
        end
    else
        too_close = 0;
        last_data = [x(i);y(i);z(i)];
    end

    H = [x(i)^2 y(i)^2 z(i)^2 2*x(i) 2*y(i) 2*z(i)];
    K = P*H'/(H*P*H'+R);
    r = 1 - H * v;
    v = v + K * r;
    if max(abs((v - lastv)./v)) > 0.017
        endcnt = 0;
        lastv = v;
    end
    endcnt = endcnt + 1;
    if endcnt > 100                                                                          
        break;
    end
    vrec(:,j) = v;
    j = j + 1;
    P = (eye(6) - K*H)*P;
end

% find the ellipsoid parameters
v = [ v(1) v(2) v(3) 0 0 0 v(4) v(5) v(6) ];

center = ( -v( 7:9 ) ./ v( 1:3 ) )';
gam = 1 + ( v(7)^2 / v(1) + v(8)^2 / v(2) + v(9)^2 / v(3) );
radii = ( sqrt( gam ./ v( 1:3 ) ) )';

end

