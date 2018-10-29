state_mat= zeros(3,1);
state_predictor = zeros(3,1);
number_of_samp = 20;
obs= 0;
a = 2.5;
b = -2.0;
c = 0.7;
F = [a,b,c;1,0,0;0,1,0];
B = [1;0;0];
H= [1;0;0];
state_mat=[0;0;0];
error_k_1givenk_1 = zeros(3);
actual_state = zeros(1,number_of_samp);
predicted_state = zeros(1,number_of_samp);
obs_state = zeros(1,number_of_samp);
actual_error = zeros(1,number_of_samp);
predicted_error = zeros(1,number_of_samp);
kalman_gain = zeros(1,number_of_samp);

for i=1:number_of_samp
    %Generating V and W
    X= rand;
    Y = rand;
    Z_0 = sqrt(-2*log(X))*cos(2*pi*Y);
    W = Z_0*sqrt(0.1);
    X= rand;
    Y = rand;
    V = sqrt(-2*log(X))*cos(2*pi*Y);
    actual_state(i) = state_mat(1,1);
    predicted_state(i) = state_predictor(1,1);
    actual_error(i) = state_mat(1,1) - state_predictor(1,1);
    %Next State and Obs
    obs = (H.')*state_mat + V;
    obs_state(i) = obs; 
    state_mat = F*state_mat + B*W;
    error_kgivenk_1 = F*error_k_1givenk_1*(F.')+0.1*(B*(B.'));
    Kalman_gain = F*error_kgivenk_1*H/(((H.')*error_kgivenk_1*H )+1);
    kalman_gain(i) = Kalman_gain(1,1);
    state_predictor = F*state_predictor + Kalman_gain*(obs - (H.')*state_predictor);
    error_k_1givenk_1 = error_kgivenk_1 - error_kgivenk_1*H/(((H.')*error_kgivenk_1*H )+1)*(H.')*error_kgivenk_1;
end
figure;
plot(actual_state,'LineWidth',1);
hold on;
plot(predicted_state,'LineWidth',0.5);
hold on;
plot(obs_state,'LineWidth',0.5);
legend('Actual state','Predicted state','Observed state');

figure;
plot(kalman_gain);
hold on
plot(actual_error);
legend('Kalman Gain','Actual error');






































