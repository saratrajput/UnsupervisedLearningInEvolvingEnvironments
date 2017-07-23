clear
X = load('driftdata.txt');
for i=1:50:length(X)-100
plotdata(X(i:i+200,:));
axis([min(X(:,1)) max(X(:,1)) min(X(:,2)) max(X(:,2))]);
drawnow
pause(.1);
end

