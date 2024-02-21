function [dudx_W,dudy_W,dudx_central,dudy_central,...
          dvdx_W,dvdy_W,dvdx_central,dvdy_central,...
          dTdx_W,dTdy_W] =Midterm_PDs2(u,v,T,dx,dy,opt)
% [dudx_BW,dudy_BW,dudx_central,dudy_central,...
%             dvdx_BW,dvdy_BW,dvdx_central,dvdy_central,...
%             dTdx_BW,dTdy_BW] =PDs2(u,v,T,dx,dy,'predictor');
% [dudx_FW,dudy_FW,dudx_central,dudy_central,...
%             dvdx_FW,dvdy_FW,dvdx_central,dvdy_central,...
%             dTdx_FW,dTdy_FW] =PDs2(u,v,T,dx,dy,'corrector');

    dudx_central= ddx_central(u,dx);
    dudy_central= ddy_central(u,dy);
    dvdx_central= ddx_central(v,dx);
    dvdy_central= ddy_central(v,dy);
    switch opt
        case 'predictor'
            dudx_W= ddx_fwd(u,dx);
            dudy_W= ddy_fwd(u,dy);
            dvdx_W= ddx_fwd(v,dx);
            dvdy_W= ddy_fwd(v,dy);
            dTdx_W= ddx_fwd(T,dx);
            dTdy_W= ddy_fwd(T,dy);
        case 'corrector'
            dudx_W= ddx_bwd(u,dx);
            dudy_W= ddy_bwd(u,dy);
            dvdx_W= ddx_bwd(v,dx);
            dvdy_W= ddy_bwd(v,dy);
            dTdx_W= ddx_bwd(T,dx);
            dTdy_W= ddy_bwd(T,dy);
    end
end