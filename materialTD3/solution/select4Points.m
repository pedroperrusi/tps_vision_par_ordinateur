function [x,y] = select4Points(I)
%Select 4 points in image I. Snap the points to the nearest
%corner
%Requires cornerfinder from calib_toolbox

wintx = 10;
winty = 10;
x= [];y = [];
hd=figure();hold on; imshow(I)
for count = 1:4,
    [xi,yi] = ginput4(1);
    [xxi] = cornerfinder([xi;yi],I,winty,wintx);
    xi = xxi(1);
    yi = xxi(2);
    figure(hd);hold on;
    plot(xi,yi,'+','color',[ 1.000 0.314 0.510 ],'linewidth',2);
    plot(xi + [wintx+.5 -(wintx+.5) -(wintx+.5) wintx+.5 wintx+.5],yi + [winty+.5 winty+.5 -(winty+.5) -(winty+.5)  winty+.5],'-','color',[ 1.000 0.314 0.510 ],'linewidth',2);
    x = [x;xi];
    y = [y;yi];
    plot(x,y,'-','color',[ 1.000 0.314 0.510 ],'linewidth',2);
    drawnow;
end;
plot([x;x(1)],[y;y(1)],'-','color',[ 1.000 0.314 0.510 ],'linewidth',2);
drawnow;
hold off;

end

