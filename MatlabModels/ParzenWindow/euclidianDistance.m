%% Distancia Euclidiana
% Calcula la distancia usando el algoritmo euclidiana del grupo de entrenamiento al grupo de
% estimación
% 
% Input
% Xtrain: Conjunto de entrenamiento
% X: Conjunto de estimacion
% 
% Output
% dist: Distancia Euclidiana del conjunto de estimacion al de entrenamiento
function dist = euclidianDistance(Xtrain, X)
    [N1] = size(X,1);
    [N2] = size(Xtrain,1);
    
    L = Xtrain*X';
    
    D = repmat(sum(Xtrain.^2,2), [1,N1]) + repmat(sum(X.^2,2)', [N2,1]) - 2*L;
    dist = sqrt( D );
end
