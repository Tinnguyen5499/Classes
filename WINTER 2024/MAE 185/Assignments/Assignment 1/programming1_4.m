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

end 

for ti=1:nt
    %plot u
    subplot(2,1,1)
    pcolor(x,y,squeeze(uf(ti,:,:)))
    rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]);
    xlabel('x')
    ylabel('y')
    title('u')
    shading interp
    axis equal tight
    colorbar
    drawnow

    %plot v
    subplot(2,1,2)
    pcolor(x,y,squeeze(vf(ti,:,:)))
    rectangle('Position',[-0.5 -0.5 1 1],'Curvature',[1 1],'LineStyle','none','FaceColor',[1 1 1]);
    xlabel('x')
    ylabel('y')
    title('v')
    shading interp
    axis equal tight
    colorbar
    drawnow
     

end 