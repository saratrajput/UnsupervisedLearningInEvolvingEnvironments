clear
X = load('data.txt');
% for i=1:50:length(X)-100
% plotdata(X(i:i+200,:));
% axis([min(X(:,1)) max(X(:,1)) min(X(:,2)) max(X(:,2))]);
% drawnow
% pause(.1);
% end
diste = [];
for i = 1:size(X,1)-1
    diste = [diste; abs(X(i)-X(i+1))];
end

sum_diste = sum(diste);

%% proximity
prox1 = [];
for j = 1:size(X,1)
    prox1 = [prox1; abs(X(1) - X(j))];
end