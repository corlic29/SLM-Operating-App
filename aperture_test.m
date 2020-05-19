clear all;
%We want to inscribe a circle of diameter n on an nxn matrix A.
%More generally we want an index based method for assinging
%values to a matrix without having to run a calculation on each element.
%Presumably we want the circle center in the middle. My plan of attack is
%to generate a list of index pairs first and then assign it to the matrix.
%Matrix row/column and coincidentally circle diameter
n=95;
%For efficiency, instantiate the matrix A
A = zeros(1080,1920);
%Use a paramterized function to generate the i and j indices to appropriate
%resolution(This will change based on how big n is; higher n, more
%resolution required in this step.)
%We must use linear indexing to assign scattered values so calculate a new
%indices vector which gives a numeric value for the element number of each
%index pair i.e. A(1,1) = 1 and A(n,n) would be like 10,000 for n=100.
%luckily we have the sub2ind function which does this for us.
t=0:.01:2*pi;
idx = sub2ind(size(A), int16((n/2).*sin(t))+n/2, int16((n/2).*cos(t))+n/2); 
%assign values to your generated indices in A
A(idx)=100;
%Check your work
imshow(A,[]);