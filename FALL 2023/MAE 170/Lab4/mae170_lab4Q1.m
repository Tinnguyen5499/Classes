
norm_transfer_vec = ((transfer_vec.^(-2))-1).^(1/2);
norm_f_vec = f_vec.*(2*pi);
figure(5)
plot(norm_f_vec, norm_transfer_vec);

figure(5)
scatter(f_vec,transfer_vec)
yline(0.707)