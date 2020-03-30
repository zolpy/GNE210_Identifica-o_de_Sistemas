
A = [1,2,6;5,-2,1;-8,2,-3];
B = [2,9;-5,-1;9,2];
a = size(A);
b = size(B);

if (a(1,1) == a(1,2))
    disp('Matriz A e quadrada.');
 else 
    disp('Matriz A nao e quadrada.');
end

if (b(1,1) == b(1,2))
    disp('Matriz B e quadrada.');
 else 
    disp('Matriz B nao e quadrada.');
end

[a,b] = find(A==2);

[c,d] = find(A<0);

nthroot(8,3);
nthroot(27,3);

x1 = 4 +5j;
x2 = 12 -6j;
x3 = x1+x2;
x4 = real(x1);
x5 = imag(x1);

[teta,ro] = cart2pol(4,5)



