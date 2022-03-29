function animate(r_a,theta_a,t,R0)
    figure
    theta_b=theta_a+pi;
    x_a = r_a.*cos(theta_a);
    y_a = r_a.*sin(theta_a);
    
    X0_A=R0*cos(theta_a);
    Y0_A=R0*sin(theta_a);
    
    
    
    x_b=r_a.*cos(theta_b);
    y_b=r_a.*sin(theta_b);
    
    X0_B=R0*cos(theta_b);
    Y0_B=R0*sin(theta_b);

    hold on
    plot(0,0,'o');
    h = animatedline("LineStyle","-.");
    f = animatedline("LineStyle",":");

    axis([-25,25,-25,25])
    axis equal




    a=plot(x_a(1),y_a(1), 'b.', 'MarkerSize', 30);    
    b=plot(x_b(1),y_b(1), 'r.', 'MarkerSize', 30);
    
    cablea=plot([0,X0_A(1)],[0,Y0_A(1)],'k-');
    cableb=plot([0,X0_B(1)],[0,Y0_B(1)],'k-');
    
    springa=plot([X0_A(1),x_a(1)],[Y0_A(1),y_a(1)],'b');
    springb=plot([X0_B(1),x_b(1)],[Y0_B(1),y_b(1)],'r');
    for k = 1:length(t)


        set (a, 'XData',x_a(k), 'YData', y_a(k))
        set (b, 'XData',x_b(k), 'YData', y_b(k))
        
        set(springa,'XData',[X0_A(k),x_a(k)], 'YData', [Y0_A(k),y_a(k)])
        set(springb,'XData',[X0_B(k),x_b(k)], 'YData', [Y0_B(k),y_b(k)])

        
        set (cablea, 'XData',[0,X0_A(k)], 'YData', [0,Y0_A(k)])
        set (cableb, 'XData',[0,X0_B(k)], 'YData', [0,Y0_B(k)])
        
        
        drawnow;
         addpoints(h,x_a(k),y_a(k));
         addpoints(f,x_b(k),y_b(k));

        hold off
        drawnow
    end
    set(stop,'style','pushbutton','string','close','callback','close(gcf)');
    hold off


end






