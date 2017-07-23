X = linspace(1,14,14)
Y = [20.2;3;6.4;11.6;8.2;2.2;11.2;5.2;6.2;0.2;1.0;4.8;2.4;3.8]
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
    eccentr = [eccentr;(2*prox(i))/(sum(prox))]
end
