function [U ,V,Z]= membership2(X,Y,b,a)
  
  U = [];
  Z = [];
  
  V = dist2(X,Y);
  if(length(b)==1)
    V = exp(-V./b);
    if sum(sum(isnan(V)))>0
      1;
    end
    
  elseif size(b(:),1)== size(V,2)
    b=b(:)';
    V = exp(-V./repmat(b,size(V,1),1));
    if sum(sum(isnan(V)))>0
      1;
    end
    
  else
    disp('b should either be a scalar or contain one value per cluster')
    V = [];
    return
  end
  
  Z = repmat(sum(V,2),1,size(V,2));
  
  %Z(Z<1)=1;
  if exist('a','var')
    Z=Z.^a;
  end
  U = V./Z;
  U(isnan(U))=0;
  
end