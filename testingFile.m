close all
clear all

%X = linspace(1,31,31)
Y = [20.2;3;6.4;11.6;8.2;2.2;11.2;5.2;6.2;0.2;1.0;4.8;2.4;3.8;11;9.2;3.2;11.8;0.2;0.2;4.8;0.2;1;8.8;2.6;9.4;6.6;5.6;0.2;0.2;15.6]
X = linspace(1,14,14);
Y = Y(1:14);

n = 1
%X = [1,2,3,4]
%Y = [10,3,4,5]
scatter(X,Y)

%calculating accumulated proximity
prox = []
for i=1:length(Y)
    pi = 0
    for j=1:length(Y)
        pi = pi + abs(Y(j) - Y(i));
    end
    prox= [prox; pi]
end
    
%calculating the vanila eccentricity
eccentr = []
for i=1:length(prox)
    eccentr = [eccentr;2*prox(i)/(sum(prox))]
end

%calculating the normalized eccentricity
sigma_square = std(Y,1)^2;
eccentr = []
for i=1:length(prox)
    eccentr = [eccentr;(((Y(i)-mean(Y))^2)/(2*length(Y)*sigma_square)+(1/2/length(Y)))]
end

%Check anomaly
gap = n/length(Y)
sorted = sort(eccentr,'descend')
anomaly = []
for i=1:(length(Y)-1)
    if (eccentr(i) -eccentr(i+1)) > gap % i think eccentr should be replaced by sorted
        for j=1:i
            anomaly = [anomaly;[i,eccentr(i)]]
        end
    end
end

figure(1)
scatter(X,eccentr,'filled')
hold on
scatter(anomaly(:,1),anomaly(:,2),'filled')
