
clc
clear all
close all


    load('database.mat');
     Y = database(:,7);
    X = database(:,1:6);
    Y = zscore(Y);

    
    %%% Se hace la partición entre los conjuntos de entrenamiento y prueba.
        %%% Esta partición se hace forma aletoria %%%

    N=size(X,1);

    porcentaje=round(N*0.033);
    rng('default');
    ind=randperm(N); %%% Se seleccionan los indices de forma aleatoria

    Xtrain=X(1:porcentaje,:);
    Xtest=X(porcentaje+1:porcentaje*2,:);
    Ytrain=Y(1:porcentaje,:);
    Ytest=Y(porcentaje+1:porcentaje*2,:);
%     Xtrain=Xreg(ind(1:porcentaje),:);
%     Xtest=Xreg(ind(porcentaje+1:end),:);
%     Ytrain=Yreg(ind(1:porcentaje),:);
%     Ytest=Yreg(ind(porcentaje+1:end),:);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%% Normalizaciï¿½n %%%

    [Xtrain,mu,sigma]=zscore(Xtrain);
    Xtest=normalizar(Xtest,mu,sigma);

    %%%%%%%%%%%%%%%%%%%%%

    %%% Se aplica la regresiï¿½n usando ventana de parzen  %%%

    h=2;
    %Yesti = regressionParzen(Xtrain, Ytrain, Xtest, h);
    Yesti=ventanaParzen(Xtest,Xtrain,Ytrain,h,'regress');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%% Se encuentra el error cuadratico medio %%%

    ECM=(sum((Yesti-Ytest).^2))/length(Ytest);

    Texto=strcat('El Error cuadrático medio en prueba es: ',{' '},num2str(ECM));
    disp(Texto);
    
    %-----------
   
%     determinationCoefficient=rsquare(Ytest,Yesti);
    
   
%     Texto=['El Coeficiente de determinación de la regresión en prueba es: ',num2str(determinationCoefficient)];
%     disp(Texto);
    %-----------
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    