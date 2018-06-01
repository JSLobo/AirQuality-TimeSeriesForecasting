function K = kernel_mat(X,Y,sigma,k_type)
% Linear kernel matrix
[N1]= size(X,1);
[N2,~]= size(Y);
L = Y*X';
D = sum(Y.^2,2)*ones(1,N1)+ones(N2,1)*sum(X.^2,2)'-2*L;
switch(k_type)
    case 'gauss'
        K = exp(-D/(2*sigma^2));
    case 'laplacian'
        K = exp(-sqrt(D)/sigma);
    case 'linear'
        K = Y*X';
    otherwise
        disp('Check the kernel type')
end
