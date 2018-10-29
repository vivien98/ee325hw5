%% Q2a)
mean_exp = 0.2;
number_of_samp = [10,20,50,100,500,1000,5000,10000,50000,100000];
[w,h] = size(number_of_samp);
mean_sample = zeros(1,h);
variance_sample = zeros(1,h);
for i =1:h
    values = zeros(1,number_of_samp(i));
    for j=1:number_of_samp(i)
        X= rand;
        exp_rand = -mean_exp*log(1-X);
       values(j)= exp_rand;
    end
    mean_sample(i) = sum(values)/number_of_samp(i);
    variance_sample(i) = var(values);
end  
figure;
plot(number_of_samp,mean_sample);    
title("Sample mean vs Number of Samples for exponential RV");
figure;
plot(number_of_samp,variance_sample);
title("Sample Var vs Number of Samples for exponential RV");
figure;
histogram(values,50000);

%% Q2b)
mean_gauss = 5;
variance_gauss = 1; 
number_of_samp = [10,20,50,100,500,1000,5000,10000,50000];
[w,h] = size(number_of_samp);
mean_sample = zeros(1,h);
variance_sample = zeros(1,h);
for i =1:h
    values = zeros(1,number_of_samp(i));
    for j=1:number_of_samp(i)
        X= rand;
        Y = rand;
        Z_0 = sqrt(-2*log(X))*cos(2*pi*Y);
        Z_1 = Z_0*sqrt(variance_gauss) + mean_gauss;
       values(j)= Z_1;
    end
    mean_sample(i) = sum(values)/number_of_samp(i);
    variance_sample(i) = var(values);
end  
figure;
plot(number_of_samp,mean_sample);    
title("Sample mean vs Number of Samples for Gaussian RV");
figure;
plot(number_of_samp,variance_sample);
title("Sample Var vs Number of Samples for Gaussian RV");
figure;
histogram(values,50000);

%% Q2c) Generating PDF using Accept/Reject method
%Using Exponential to generate with Accept/reject
number_of_samp=5000000;
mean_exp =1 ;
c= 1.4;
values = zeros(1,number_of_samp);
p_of_accepting = zeros(1,number_of_samp);
for i=1:number_of_samp
    iter_exceeded =1;
    while iter_exceeded
    X= rand;
    Z_0 =  -log(1-X);
    f_Z_0 = sqrt(2/pi)*exp(-(Z_0)^2/2);
    f1_Z_0 = exp(-Z_0);
    not_accepted=1;
    total_iterations = 0;
    while not_accepted
         U=rand;
        if U < f_Z_0/(c*f1_Z_0)
            values(i) = Z_0;
            not_accepted = 0;
            iter_exceeded =0;
        end   
         total_iterations = total_iterations+1;
         if(total_iterations>100000)
             break 
         end
    end
        
    end
    p_of_accepting(i) = 1/total_iterations;
end
figure;
histogram(values,'Normalization','pdf');
disp(['On an average the acceptance rate was ',num2str(sum(p_of_accepting)/number_of_samp)])
