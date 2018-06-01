function d = distEuclid(X1, X2)
    if size(X1, 2) ~= size(X2, 2)
        error('Las matrices deben tener igual número de columnas');
    end    
    % dcuadrado: valor de la distancia entre vectores, elevada a la 2
    dcuadrado = sum((X1 - X2).^2, 2);
    d = sqrt(dcuadrado);
end