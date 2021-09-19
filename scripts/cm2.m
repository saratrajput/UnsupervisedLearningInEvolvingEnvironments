function [Uout, Yout, Youtn, b] = cm2(X,k,b,maxiter,replicates,epsilon,Y0,eta,a)
% general central clustering skeleton
% [U, Y] = cm(X,k,maxiter)

    % checking mandatory arguments
    if nargin < 2
        disp('At least X and k must be provided')
        Y = [];
        U = [];
        return
    end
    
    % checking and setting optional arguments
    if exist('maxiter')==0
        maxiter = 10; 
    end
    if exist('epsilon')==0
        epsilon = 0;
    end
    if exist('replicates')==0 || replicates<1
        replicates = 1;
    end
    if exist('Y0')
        replicates = 1; 
    end
    
    % normalizing training set
%     Normvals(1,:) = min(X);
%     Normvals(2,:) = max(X);
%     X = (X-repmat(Normvals(1,:),size(X,1),1))./repmat(Normvals(2,:)-Normvals(1,:),size(X,1),1);
    
    %initializing run
    Jopt = sum(min(dist2(min(X),X)))/size(X,1);
    %b=.05;
    for cnt = 1:replicates
        % initializing replicate
        if Y0==0 
            
            [Y,Ufcm] =fcm(X,k);
            b = betafcm(X,Y,Ufcm);  % beta for every cluster.
            %b=b/sqrt(k) ; % added
             b=b/k ;
        else
            %Y = .4*rand(k,size(X,2))+.3; %modification to the
            %intialization
            Y = Y0;
        end
        for h = 1:maxiter
            % computing memberships
            U = membership2(X,Y,b,a);
 
            % computing centroids
            YN = U'*X./repmat(sum(U)',1,size(X,2));
            
            % checking mean squared variation
            if sum(sum((Y-YN).^2,2)) <= epsilon
                break
            else
                Y = eta*YN+(1-eta)*Y;
            end
        end
        
        % cost at the end of iteration
        J = sum(min(dist2(Y,X)))/size(X,1);
        if exist('Uout') == 0 | J<Jopt
            Uout = U;
            Yout = Y;
            
           % Ul=Ulog;
        end
    end
    
    % remapping centroids into original data space (de-normalization)
            Youtn=Y;
%     Yout = Yout.*repmat(Normvals(2,:)-Normvals(1,:),k,1)+repmat(Normvals(1,:),k,1);
end