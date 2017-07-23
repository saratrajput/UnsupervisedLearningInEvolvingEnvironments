clear
X1 = load('data.txt');
% for i=1:50:length(X)-100
% plotdata(X(i:i+200,:));
% axis([min(X(:,1)) max(X(:,1)) min(X(:,2)) max(X(:,2))]);
% drawnow
% pause(.1);
% end
diste = [];
X1 = X1(1:14,1);
for i = 1:size(X1,1)-1
    diste = [diste; abs(X1(i)-X1(i+1))];
end

sum_diste = sum(diste);

%% proximity
% distance from one point to every other point
row_num = size(X1, 1);
col_num = size(X1, 1);
proxi = zeros(row_num, col_num);

for j = 1:size(X1,1)
    for k = 1 : size(X1, 1)
        proxi(j, k) = [abs(X1(k) - X1(j))];
    end
end

%% accumulated proximity
% sum of distaces to each data point from every point
proxsum = [];
for i = 1 : size(X1, 1)
    proxsum = [proxsum; sum(proxi(:,i))];
end

%% eccentricity
% ((2 * accumlated proximity(j)) / sum of all accumulated proximities)
eccen = [];
for i = 1: size(X1, 1)
    eccen = [eccen; (2 * proxsum(i)) / sum(proxsum)];
end

%% typicality

typic = [];
for i = 1 : size(X1, 1)
    typic = [typic; 1 - eccen(i)];
end
