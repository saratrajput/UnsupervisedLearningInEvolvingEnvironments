function d = dist2(x,y)
if nargin==0
    d=[];
    return;
end
if nargin ==1
    y=x;
end
d=repmat(sum(x'.^2)',1,size(y,1));
d=d+repmat(sum(y'.^2), size(x,1),1);
d=abs(d-2*x*y');

end

