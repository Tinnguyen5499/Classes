% Partial Derivative Function
function [dudx_FW,dudx_BW,dudy_FW,dudy_BW,dudx_central,dudy_central,...
          dvdx_FW,dvdx_BW,dvdy_FW,dvdy_BW,dvdx_central,dvdy_central,...
          dTdx_FW,dTdx_BW,dTdy_FW,dTdy_BW,dTdx_central,dTdy_central] =Midterm_PDs(u,v,T,dx,dy)

        dudx_FW= ddx_fwd(u,dx);
        dudx_BW= ddx_bwd(u,dx);
        dudy_FW= ddy_fwd(u,dy);
        dudy_BW= ddy_bwd(u,dy);
        dudx_central= ddx_central(u,dx);
        dudy_central= ddy_central(u,dy);
        
        dvdx_FW= ddx_fwd(v,dx);
        dvdx_BW= ddx_bwd(v,dx);
        dvdy_FW= ddy_fwd(v,dy);
        dvdy_BW= ddy_bwd(v,dy);
        dvdx_central= ddx_central(v,dx);
        dvdy_central= ddy_central(v,dy);
        
        dTdx_FW= ddx_fwd(T,dx);
        dTdx_BW= ddx_bwd(T,dx);
        dTdy_FW= ddy_fwd(T,dy);
        dTdy_BW= ddy_bwd(T,dy);
        dTdx_central= ddx_central(T,dx);
        dTdy_central= ddy_central(T,dy);
end 