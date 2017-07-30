clear all, close all
X = load('driftdata.txt');
vidObj = VideoWriter('test1.avi');
open(vidObj);
% aviobj = avifile('example.avi')
set(gcf,'renderer','zbuffer') 
k_test = 1;

for i=1:50:length(X)-100
plotdata(X(i:i+200,:));
title('Artificial data with anomaly');
xlabel('X1');
ylabel('X2');
% M = getframe(gcf);
axis([min(X(:,1)) max(X(:,1)) min(X(:,2)) max(X(:,2))]);
% M = getframe;
% aviobj=addframe(aviobj,M);
% drawnow
pause(0.02);
M(k_test) = getframe;
writeVideo(vidObj, M);
k_test = k_test + 1;
% writeVideo(vidObj, M);
% pause(.1);
% M = getframe(gcf);


end

close(vidObj);
