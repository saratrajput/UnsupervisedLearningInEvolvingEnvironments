

X = X(1:300,:)
n = 1
%X = [1,2,3,4]
%Y = [10,3,4,5]
%scatter(X(:,1),X(:,2))

%calculating accumulated proximity
prox = []
for i=1:length(X)
    pi = 0;
    for j=1:length(X)
        pi = pi + sqrt((X(j,1)-X(i,1))^2+(X(j,2)-X(i,2))^2);
    end
    prox= [prox; pi];
end
    
%calculating the vanila eccentricity
eccentr = []
for i=1:length(prox)
    eccentr = [eccentr;[i,2*prox(i)/(sum(prox))]];
end

%calculating the normalized eccentricity
sigma_square = [std(X(:,1),1)^2,std(X(:,2),1)^2];
eccentr = []
for i=1:length(prox)
    eccentricity = ((X(i,1)-mean(X(:,1)))^2)/(2*length(X)*sigma_square(1)) + ((X(i,2)-mean(X(:,2)))^2)/(2*length(X)*sigma_square(2)) + 1/(2*length(X));
    eccentr = [eccentr;[i,eccentricity]]
end

%Check anomaly
gap = n/length(X)
sorted = sort(eccentr,'descend')
anomaly = []
for i=1:(length(X)-1)
    if (eccentr(i) -eccentr(i+1)) > gap
        for j=1:i
            anomaly = [anomaly;[i,eccentr(i)]]
        end
    end
end

figure(1)
scatter(eccentr(:,1),eccentr(:,2),'filled')
hold on
scatter(anomaly(:,1),anomaly(:,2),'filled')
