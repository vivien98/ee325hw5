state_mat= zeros(3,1);
a = -2.5;
b = -2.0;
c = 0.7;
F = [a,b,c;1,0,0;0,1,0];
B = [1;0;0];
actual_state = zeros(1,100);
for i=1:100
    actual_state(i) = state_mat(1,1);
    X= rand;
    Y = rand;
    Z_0 = sqrt(-2*log(X))*cos(2*pi*Y);
    W = Z_0*sqrt(0.1);
   state_mat = F*state_mat + B*W;
end

plot(actual_state);