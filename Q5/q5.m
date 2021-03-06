minima_vals = zeros(1,91);
n_vals = zeros(1,91);
for n=10:100
n_vals(n-9) = n;    
k_values = zeros(1,n);
p_k_n_vals = zeros(1,n);
q_k_n_vals = zeros(1,n);
for k =1:n
    k_values(k)=k;
end

for k =1:n
    not_choose_spouse=0;
    error_in_choosing = 0;
    for i=1:1000
       seq=zeros(1,n);
        for j=1:n
        seq(j) =rand;
        end
        max_before = max(seq(1:k_values(k)));
        [max_after,id] = max(seq(k_values(k)+1:n));
        if max_after<max_before
                not_choose_spouse=not_choose_spouse+1;
        else 
           if max_before<max(seq(k_values(k)+1:id-1))
                    error_in_choosing = error_in_choosing +1;
           end
        end 
    end

p_k_n_vals(k) = (error_in_choosing+not_choose_spouse)/1000;
q_k_n_vals(k)= not_choose_spouse/1000;
end
[val,idx] = min(p_k_n_vals(1:n-5));
minima_vals(n-9) = idx;
% figure;
% plot(k_values,p_k_n_vals);
% hold on
% plot(k_values,q_k_n_vals);
% legend('p_k_n','q_k_n');
end
plot(n_vals,minima_vals);
title('Optimum k vs n');
