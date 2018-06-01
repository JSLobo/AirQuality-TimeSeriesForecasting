% Función para hacer una predicción de Regresion de
% muestras, basado en el algoritmo Ventana de Parzen
%
% Input
% Xtrain: matriz NxM, N muestras de entrenamiento del sistema,
%         con M variables
% Ytrain: matriz Nx1, clases asociadas a cada una de las N muestras
%         de Xtrain
% Xest: matriz PxM, P muestras de M variables, a las que se les hará
%       la predicción de la clase
% h: ventana de suavizado para el algoritmo
%
% Output
% ClasesEst: matriz de Px1, con las clases predichas para las muestras
%            de la matriz Xest
function ValoresEst = regressionParzen(Xtrain, Ytrain, Xest, h)
    % n: número de muestras de entrenamiento
    % p: número de muestras para predecir
    n = size(Xtrain, 1);
    p = size(Xest, 1);
    ValoresEst = zeros(p, 1);
    
    for i = 1:p
        % Con temp se compara la muestra i con
        % todas las muestras de entrenamiento
        temp = repmat(Xest(i, :), n, 1);
        
        % Calculamos el valor con el predictor
        ValoresEst(i) = predictor(Xtrain, Ytrain, temp, h);        
    end
end

function yest = predictor(Xtrain, Ytrain, Xest, h)
    % Calculamos el valor del kernel para los valores dados    
    k = kernelGauss(Xtrain, Xest, h);
    
    % Calculamos el numerador y el denominador del predictor
    num = sum(k .* Ytrain);
    den = sum(k);
    
    % Hacemos la predicción y retornamos el valor calculado
    yest = num / den;  
end

function k = kernelGauss(Xtrain, Xest, h)
    % dist: distancia entre los vectores fila de Xtrain y Xest
    % ucuad: parámetro u del kernel, elevado al cuadrado
    dist = distEuclid(Xtrain, Xest);
    ucuad = (dist / h) .^ 2;
    
    % Calculamos el kernel y retornamos el valor
    k = 0.5 * exp(-0.5 * ucuad); 
end

function d = distEuclid(X1, X2)
    if size(X1, 2) ~= size(X2, 2)
        error('Las matrices deben tener igual número de columnas');
    end    
    % dcuadrado: valor de la distancia entre vectores, elevada a la 2
    dcuadrado = sum((X1 - X2).^2, 2);
    d = sqrt(dcuadrado);
end