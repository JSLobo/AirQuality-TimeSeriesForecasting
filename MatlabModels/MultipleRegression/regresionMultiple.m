function W = regresionMultiple(X,Y,eta)

[N,D]=size(X);
W=zeros(D,1);

for iter = 1:500
    %%% Completar el c�digo %%% 
    for j = 1:D
        W(j) = W(j) - eta*(X*W - Y)'*X(:,j)/N;
    end
    %%% Fin de la modificaci�n %%%
end

end