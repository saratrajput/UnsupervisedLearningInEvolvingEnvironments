function d = dist2(x,y)
    %distance of a single point x, from the centorids y
    if nargin==0
        d=[];
        return;
    end
    if nargin ==1
        y=x;
    end
    %euclidian distance in mattrix form, the output is a raw vectr distance from each centroid 
    d=repmat(sum(x'.^2)',1,size(y,1));
    d=d+repmat(sum(y'.^2), size(x,1),1);
    d=abs(d-2*x*y');
end

