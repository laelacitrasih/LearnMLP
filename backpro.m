function [ dw1 dw2 db1 db2 ] = backpro( input,a1,a2,w2,e )

[m n] = size(a2);
s = ones(m,n);

d2 = a2*(s-a2).'*e;
dw2 = a1.'*0.1*d2;
db2 = sum(0.1*d2,1);

[a b] = size(a1);
r = ones(a,b);

p = input(:,1:2);
d1 = a1*((r-a1).')*d2*w2.';
dw1 = p.'*0.1*d1;
db1 = sum(0.1*d1,1);