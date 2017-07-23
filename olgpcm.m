function [rhovals,summembership,U, Youtn, Y, Normvals, bend] = olgpcm(X,Y,bi0,K,eta0,alphamin)
% OnLine Graded Possibilistic C Means

  % SET SOME VALUES
  absc = 1; %absicissa, X cordinate axis
  ord = 2;  %ordinata, Y coordinate axis
  
  a0= .25; % orignal 0.3  (set low)
  t1= .1; %orignal .1  (set low)
  k=50;  %(set high) orignal 50
  g=.55; %orignal .5 (set high)
  bi=bi0; %remove it again
  eta=eta0;
  maxitr=100;
  nout=50;
  close;
  alpha=1;
  firstbatch=1000;
  Normvals=[zeros(1,size(X,2)); ones(1,size(X,2))];
  
  % uncomment the following line to check parameters
  %   plot(0:.01:1,  1+a0*exp(-((0:.01:1)./t1))-exp(-(((0:.01:1)./(k*t1)).^(g*log(1/t1)))));pause
  
  
  % USE THE FIRST firstbatch DATA TO TRAIN AN INITIAL MODEL
  tinterval=1:firstbatch;
  [Ui, Y, Youtn,bend] = cm2(X(tinterval,:),K,bi0,maxitr,1,0,Y,eta,alphamin);
  summembership = sum(Ui,2)';
  
  plot(Y(:,absc),Y(:,ord),'r*',X(tinterval,absc),X(tinterval,ord),'b.')
  axis([0 1 0 1]);
  grid;
  drawnow;
  count=0;
  U = zeros(1,size(Y,1));
  rhovals = [];
  numiter = size(X,1)-firstbatch;
  
  Omega = 1-summembership;
  Omega(Omega<0)=0;
  rho=mean(Omega(:));
  b=bend;
  
  
  % START ONLINE LEARNING
  % Goes trough the points one at a time
  for j=firstbatch+1:size(X,1)
    
    count = count + 1;
    % COMPUTE MEMBERSHIP OF CURRENT POINT
    U=membership2(X(j,:),Y,b,alpha);

    % COMPUTE ITS DEGREE OF OUTLIERNESS Omega
    % AND OUTLIER DENSITY rho
    Omega = 1-sum(U);
    Omega(Omega<0)=0;
    rho=.01*mean(Omega)+.99*rho;
    rhovals = [rhovals rho];
    
    % COMPUTE "LEARNING INTENSITY" theta AND "UPDATING COEFFICIENT" eta
    
    theta=1+a0*exp(-(rho./t1))-exp(-((rho./(k*t1)).^(g*log(1/t1))));
    eta=theta*eta0;

    % COMPUTE MODEL PARAMETERS alpha AND b
    alpha=alphamin+rho*(1-alphamin);
    dist=dist2(X(j,:),Y);
    b= bi0+bi0*(1-exp(-10*theta+.6)).*sum(dist(1:size(U,2)).*U,2)./sum(U,2) ;
    
    % UPDATE CENTROIDS
    if count >= 1050
      1;
    end
    if (sum(U) > 1/K)
        Y=Y+((eta*(repmat(X(j,:),size(Y,1),1)-Y).*repmat(U,size(X,2),1)')./sum(U)); % added /sum(U)
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Printing stuff and plotting
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % PRINT STATUS INFO EVERY nout ITERATIONS
    if ~mod(count,nout)
      fprintf('iter %i of %i - rho = %f , theta = %f , eta = %f , alpha = %f\n',count, numiter,rho,theta,eta,alpha);
    end
    
    % SHIFT FORWARD CURRENT "SLIDING WINDOW" OF DATA
    tinterval=max(1,j-30):j;
    tintervalpast=max(1,j-100):j;
    
    % GRAPHICALLY SHOW STATUS
    plot(X(tintervalpast,absc),X(tintervalpast,ord),'c.',X(tinterval,absc),X(tinterval,ord),'b.',Y(:,absc),Y(:,ord),'r*');
    axis([0 1 0 1]);
    grid;
    drawnow;
    
  end