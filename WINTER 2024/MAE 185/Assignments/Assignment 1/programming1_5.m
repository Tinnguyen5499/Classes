close all;
clear all;
clc;

load('cylinder_Re100.mat')

%% find the temperal mean of u and v, while discarding the first 150 time instances
u_bar=squeeze(mean(u(150:end,:,:)));
v_bar=squeeze(mean(v(150:end,:,:)));
threeD_u_bar(1,:,:)=u_bar;
threeD_v_bar(1,:,:)=v_bar;
figure
[nt,nx,ny] = size(u)

for ti=1:nt

    uf(ti,:,:)=u(ti,:,:)-threeD_u_bar;
    vf(ti,:,:)=v(ti,:,:)-threeD_v_bar;
    uf_square(ti,:,:)=uf(ti,:,:).^2;
    vf_square(ti,:,:)=vf(ti,:,:).^2;

end 

uf_square_mean=squeeze(mean(uf_square(150:end,:,:)));
vf_square_mean=squeeze(mean(vf_square(150:end,:,:)));

k=(1/2) * (uf_square_mean+vf_square_mean)

%% plot u

pcolor(x,y,k)
rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]);
xlabel('x')
ylabel('y')
title('u bar')
shading interp
axis equal tight
colorbar
