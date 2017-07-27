clear all
close all
X1 = load('data.txt');
% for i=1:50:length(X)-100
% plotdata(X(i:i+200,:));
% axis([min(X(:,1)) max(X(:,1)) min(X(:,2)) max(X(:,2))]);
% drawnow
% pause(.1);
% end
diste = [];
X1 = X1(1:14,1);
X1(14) = 19.5;
num = size(X1, 1);
for i = 1:size(X1,1)-1
    diste = [diste; abs(X1(i)-X1(i+1))];
end

sum_diste = sum(diste);

%% proximity
% distance from one point to every other point
row_num = num;
col_num = num;
proxi = zeros(row_num, col_num);

for j = 1 : num
    for k = 1 : num
        proxi(j, k) = [abs(X1(k) - X1(j))];
    end
end

%% accumulated proximity
% sum of distaces to each data point from every point
proxsum = [];
for i = 1 : num
    proxsum = [proxsum; sum(proxi(:,i))];
end

%% eccentricity
% ((2 * accumlated proximity(j)) / sum of all accumulated proximities)
eccen = [];
for i = 1: num
    eccen = [eccen; (2 * proxsum(i)) / sum(proxsum)];
end

%% typicality

typic = [];
for i = 1 : num
    typic = [typic; 1 - eccen(i)];
end

%% average

% mean = sum(X1)/size(X1,1);
avg = mean(X1);

% sig_sq = var(X1);

test = [];
for i = 1 : num
    test = [test; (X1(i) - avg)^2];
end

sigang = std(X1, 1);
sigang_sq = std(X1, 1) ^ 2;

% sig_test = sum(test)/ num;


%% normalised eccentricity eta
eta = [];
for i = 1 : num
    eta = [eta; ((X1(i) - avg)^2) / (2 * num * sigang_sq)+(1/(2*num))];
end

%% plot
x_axis = linspace(1, num, num);

scatter(x_axis, X1, '*')
axis([0 15 0 25])
hline = refline([0 avg])
hline.Color = 'g';
hline = refline([0 avg+sigang])
hline.Color = 'r';
hline = refline([0 avg+3*sigang])
hline.Color = 'r';
hline = refline([0 avg-sigang])
hline.Color = 'k';
title('Real data of rainfall (in mm) during the first 2 weeks of Jan 2014') 
xlabel('January 2014, date')
ylabel('rainfall in mm')

%% 
figure
scatter(x_axis, eta, '*')
axis([0 15 0 0.4])
hline = refline([0 1/num])
hline.Color = 'g';
hline = refline([0 5/num])
hline.Color = 'k';
% hline = refline([0 mean(eta)])
% hline.Color = 'k';
title('"Sigma Gap" principle')
xlabel('January 2014, date')
ylabel('Normalized Eccentricity(\zeta)')

%%
%Check anomaly

n = 1;
gap = n/num;
[sorted, ind] = sort(eta,'descend');
anomaly = [];
for i= 1 : (num - 1)
    if (sorted(i) - sorted(i + 1)) > gap
        for j=1:i
            anomaly = [anomaly; [ind(j), sorted(j)]]
        end
    end
end

%% epsilon vicinity

