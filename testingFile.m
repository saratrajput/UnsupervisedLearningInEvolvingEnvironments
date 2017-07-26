X = linspace(1,31,31)
Y = [20.2;3;6.4;11.6;8.2;2.2;11.2;5.2;6.2;0.2;1.0;4.8;2.4;3.8;11;9.2;3.2;11.8;0.2;0.2;4.8;0.2;1;8.8;2.6;9.4;6.6;5.6;0.2;0.2;15.6]
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
    
%calculating eccentricity
eccentr = []
for i=1:length(prox)
    eccentr = [eccentr;prox(i)/(sum(prox))]
end

%Check anomaly
gap = n/length(Y)
sorted = sort(eccentr,'descend')
anomaly = []
for i=1:(length(Y)-1)
    if (eccentr(i) -eccentr(i+1)) > gap
        for j=1:i
            anomaly = [anomaly;[i,eccentr(i)]]
        end
    end
end

figure(1)
scatter(X,eccentr,'filled')
hold on
scatter(anomaly(:,1),anomaly(:,2),'filled')
