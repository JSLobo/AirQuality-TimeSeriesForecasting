function fitnessVals=FitnessSelection(pop,X,Y)

CVO = cvpartition(size(X,1),'k',4);
Ncromosomas = size(pop,1);
Costos = zeros(1,Ncromosomas);
for i = 1: Ncromosomas % Se debe evaluar cada individuo de la población
    X2 = X(:,pop(i,:)); % Se usa el subcojunto de variables descritas por el individuo i
    Error = zeros(1,4);
    for j = 1:4 %Número de Folds
        Xtrain = X2(CVO.training(j),:);
        Xtest = X2(CVO.test(j),:);
        Ytrain = Y(CVO.training(j));
        Ytest = Y(CVO.test(j));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %------------------------------------------------------------------
        Yest = classify(Xtest,Xtrain,Ytrain);% Se usa una Función Discriminante Gausiana como criterio
        %------------------------------------------------------------------
        Error(j) = sum(Ytest ~= Yest)/length(Yest);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    Costos(i) = mean(Error);
end

%Caluclo del fitness a partir de la función de evaluación
[~,indice] = sort(Costos);
fitnessVals = 0.9.^(0:1:size(pop,1)-1);
fitnessVals(indice)=fitnessVals;