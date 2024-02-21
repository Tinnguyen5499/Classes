%plotting function
function Midterm_plottingM1(xx,yy,rho,u,v,e,p,T,n,dt,convdata)
    figure(1)
    ax(1)=subplot(3,3,1);
    pcolor(xx,yy,rho)
    title('rho [kg/m^3]' )
    xlim([0 1e-5]);ylim([0 8e-6])
    xlabel('x');ylabel('y')
    colorbar
    colormap(ax(1),turbo)
    shading interp
    axis equal tight
    
    ax(2)=subplot(3,3,2);
    pcolor(xx,yy,u)
    title('u [m/s]')
    xlim([0 1e-5]);ylim([0 8e-6])
    xlabel('x');ylabel('y')
    colorbar
    colormap(ax(2),turbo)
    shading interp
    axis equal tight
    
    ax(3)=subplot(3,3,3);
    pcolor(xx,yy,v)
    title('v [m/s]')
    xlim([0 1e-5]);ylim([0 8e-6])
    xlabel('x');ylabel('y')
    colorbar
    colormap(ax(3),turbo)
    shading interp
    axis equal tight

    ax(4)=subplot(3,3,4);
    pcolor(xx,yy,e)
    title('e [J/kg]')
    xlim([0 1e-5]);ylim([0 8e-6])
    xlabel('x');ylabel('y')
    colorbar
    colormap(ax(4),turbo)
    shading interp
    axis equal tight
    
    ax(5)=subplot(3,3,5);
    pcolor(xx,yy,p)
    title('P [Pa]')
    xlim([0 1e-5]);ylim([0 8e-6])
    xlabel('x');ylabel('y')
    colorbar
    colormap(ax(5),turbo)
    shading interp
    axis equal tight
    
    ax(6)=subplot(3,3,6);
    pcolor(xx,yy,T)
    title('T [K]')
    xlim([0 1e-5]);ylim([0 8e-6])
    xlabel('x');ylabel('y')
    colorbar
    colormap(ax(6),hot)
    shading interp
    axis equal tight

    ax(7)=subplot(3,3,[7,9]);
    x=linspace(0,dt*1500,1500);
    plot(x,convdata(1:1500))
    title('Convergence (based on u)')
    xlim([0 dt*1500]);%ylim([0 2.5])
    xlabel('Time [s]');ylabel('RMS(u-u_{previous})')
    drawnow
end