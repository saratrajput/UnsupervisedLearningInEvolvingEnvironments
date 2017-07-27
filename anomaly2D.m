

X = X;
n = 1
%X = [1,2,3,4]
%Y = [10,3,4,5]
%scatter(X(:,1),X(:,2))

%calculating accumulated proximity
prox = [];
for i=1:length(X)
    pi = 0;
    for j=1:length(X)
        pi = pi + sqrt((X(j,1)-X(i,1))^2+(X(j,2)-X(i,2))^2);
    end
    prox= [prox; pi];
end
    
%calculating the vanila eccentricity
eccentr = [];
for i=1:length(prox)
    eccentr = [eccentr;[i,2*prox(i)/(sum(prox))]];
end

%calculating the normalized eccentricity
sigma_square = [std(X(:,1),1)^2,std(X(:,2),1)^2];
eccentr = [];
for i=1:length(prox)
    eccentricity = ((X(i,1)-mean(X(:,1)))^2)/(2*length(X)*sigma_square(1)) + ((X(i,2)-mean(X(:,2)))^2)/(2*length(X)*sigma_square(2)) + 1/(2*length(X));
    eccentr = [eccentr;[i,eccentricity]];
end

%Check anomaly
gap = n/length(X)
[sorted, index] = sortrows(eccentr,2);
anomaly = [];
for i=1:(length(X)-1)
    if (sorted(length(X)+1-i,2) -sorted(length(X)-i,2)) > gap
        for j=1:i
            % in world coordinates this is the point
            %anomaly = [anomaly;X(sorted(length(X)+1-j,1),:)]
            anomaly = [anomaly;sorted(length(X)+1-j,:)]
        end
    end
end

figure(1)
scatter(eccentr(:,1),eccentr(:,2),'filled')
hold on
%hline = refline([0 mean(eccentr)])
scatter(anomaly(:,1),anomaly(:,2),'filled')
