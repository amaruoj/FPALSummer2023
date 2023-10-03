function plotNormRe(radiusMatrix,stressTensor,xinput)
% input:
% radiusMatrix: matrix of normalized radius
% stressTensor: reynolds stress tensor
% xinput:   different xvals to plot at, scalar or vector input

% output:
% plots! :3

x = linspace(0.1,30,300);
if nargin == 2
    xinput = [10,50,100,200];
end

xidx = xinput;

for i = 1:length(xidx)
    figure
    
    re11 = stressTensor(xidx(i),51:end,1);
    re12 = stressTensor(xidx(i),51:end,2);
    re22 = stressTensor(xidx(i),51:end,3);
    re33 = stressTensor(xidx(i),51:end,4);
    plotr = radiusMatrix(xidx(i),:);
    f11 = fit(plotr',re11','gauss1');
    f12 = fit(plotr',re12','gauss1');
    f22 = fit(plotr',re22','gauss1');
    f33 = fit(plotr',re33','gauss1');
    
    fig = plot(plotr,re11);
    hold on
    plot(plotr,re12);
    plot(plotr,re22);
    plot(plotr,re33);
    
    title(['Profiles of Reynolds Stresses at X/D_e = ',num2str(x(xidx(i))),' (normalized)']);
    xlabel('$r/r_{1/2}$','Interpreter','latex','fontsize',15);
    ylabel('$\frac{\langle u_i u_j\rangle}{U^2_0}$','Interpreter','latex','Rotation',0,'FontSize',18);
    legend('$\langle u^2\rangle$','$\langle uv\rangle$','$\langle v^2\rangle$','$\langle w^2\rangle$','Interpreter','latex');
    
    
    figure
    fig2 = plot(f11);
    hold on
    plot(plotr,re11,'o');
    title(['Fitted Profile of UU Component Reynolds Stress at X/D_e = ',num2str(x(xidx(i)))]);
    xlabel('$r/r_{1/2}$','Interpreter','latex','fontsize',15);
    ylabel('$\frac{\langle u_i u_j\rangle}{U^2_0}$','Interpreter','latex','Rotation',0,'FontSize',18);

    figure
    fig3 = plot(f11,'red');
    hold on
    plot(f12,'blue');
    plot(f22,'magenta');
    plot(f33,'cyan');
    title(['Fitted Profiles of Reynolds Stresses at X/D_e = ',num2str(x(xidx(i))),' (normalized)']);
    xlabel('$r/r_{1/2}$','Interpreter','latex','fontsize',15);
    ylabel('$\frac{\langle u_i u_j\rangle}{U^2_0}$','Interpreter','latex','Rotation',0,'FontSize',18);
    legend('$\langle u^2\rangle$','$\langle uv\rangle$','$\langle v^2\rangle$','$\langle w^2\rangle$','Interpreter','latex');

    disp(['saving plot ',num2str(i),' of ',num2str(length(xinput))])
    filename = append('normRe_x',num2str(x(xidx(i))),'.fig');
    saveas(fig,fullfile('..','figs',filename))
    filename = append('normRe_x',num2str(x(xidx(i))),'.png');
    saveas(fig,fullfile('..','figs',filename))
    filename = append('normRe_x',num2str(x(xidx(i))));
    disp(['done! saved as ', filename, '.fig AND .png! ~\(≧▽≦)/~'])

    
    disp(['saving plot ',num2str(i),' of ',num2str(length(xinput))])
    filename = append('Ufit_normRe_x',num2str(x(xidx(i))),'.fig');
    saveas(fig2,fullfile('..','figs',filename))
    filename = append('Ufit_normRe_x',num2str(x(xidx(i))),'.png');
    saveas(fig2,fullfile('..','figs',filename))
    filename = append('Ufit_normRe_x',num2str(x(xidx(i))));
    disp(['done! saved as ', filename, '.fig AND .png! ~\(≧▽≦)/~'])


    
    disp(['saving plot ',num2str(i),' of ',num2str(length(xinput))])
    filename = append('fit_normRe_x',num2str(x(xidx(i))),'.fig');
    saveas(fig3,fullfile('..','figs',filename))
    filename = append('fit_normRe_x',num2str(x(xidx(i))),'.png');
    saveas(fig3,fullfile('..','figs',filename))
    filename = append('fit_normRe_x',num2str(x(xidx(i))));
    disp(['done! saved as ', filename, '.fig AND .png! ~\(≧▽≦)/~'])

end
end

