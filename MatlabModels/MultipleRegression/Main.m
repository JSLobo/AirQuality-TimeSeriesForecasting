
clc
close all
clear all

eta=1; %%% Taza de aprendizaje
grado=5;     %%% Grado del polinomio

rng('default');
 %Problema de Regresion
    
    load('database.mat');
    Y = database(:,7);
    X = database(:,1:6);
    %    Y = DataReg(:,1);
    %Y = Y/100000; %La predicción se harán en unidades de 100000
    Y = zscore(Y);
    %    X = DataReg(:,2:end);
    [N,d] = size(X); % N = nÃºmero de muestras, d = nÃºmero de variables
    %Y = Y + round(randn(N,1)*2 + 5);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% Se cambia el grado del polinomio %%%
    
    X=potenciaPolinomio(X,grado);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% Se hace la particiï¿½n entre los conjuntos de entrenamiento y prueba.
    %%% Esta particiï¿½n se hace forma aletoria %%%
    porcentaje=round(N*0.033);
    rng('default');
    %ind=randperm(size(X,1)); %%% Se seleccionan los indices de forma aleatoria
    Xtrain=X(1:porcentaje,:);
    Xtest=X(porcentaje+1:porcentaje*2,:);
%     Ytrain=Y(1:porcentaje,:);
%     Ytest=Y(porcentaje+1:porcentaje*2,:);
    
    %Ytrain=Y(ind(1:porcentaje),:);
    %Ytest=Y(ind(porcentaje+1:end),:);
    Ytrain=Y(1:porcentaje,:);
    Ytest=Y(porcentaje+1:porcentaje*2,:);
    
    
    %     Xtrain=X(ind(1:ceil(0.7*N)),:);
    %     Xtest=X(ind(ceil(0.7*N)+1:end),:);
    %     Ytrain=Y(ind(1:ceil(0.7*N)),:);
    %     Ytest=Y(ind(ceil(0.7*N)+1:end),:);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% NormalizaciÃ³n %%%
    
    [Xtrain,mu,sigma]=zscore(Xtrain);
    Xtest=normalizar(Xtest,mu,sigma);
    
    %%%%%%%%%%%%%%%%%%%%%
    
    %%% Se extienden las matrices %%%
    
    Xtrain=[Xtrain,ones(size(Xtrain,1),1)];
    Xtest=[Xtest,ones(size(Xtest,1),1)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% Se aplica la regresiï¿½n multiple %%%
    
    W=regresionMultiple(Xtrain,Ytrain,eta); %%% Se optienen los W coeficientes del polinomio
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
    %%% Se calcula el error cuadratico medio %%%
    
    
    %------------ Entrenamiento -------------------------------------------
    Yesti=(W'*Xtrain')';
    ECM=(sum((Yesti-Ytrain).^2))/length(Ytrain);
    
    %     Texto=strcat('El Error cuadrï¿½tico medio en prueba es: ',{' '},num2str(ECM));
    Texto=['El Error cuadrático medio en entrenamiento es: ',num2str(ECM)];
    disp(Texto);
    
    
    % ---------- Prueba ---------------------------------------------------
    Yesti=(W'*Xtest')';
    ECM=(sum((Yesti-Ytest).^2))/length(Ytest);
    
    %     Texto=strcat('El Error cuadrï¿½tico medio en prueba es: ',{' '},num2str(ECM));
    Texto=['El Error cuadrático medio en prueba es: ',num2str(ECM)];
    disp(Texto);
    %-----------
   
    SE=sqrt((sum((Ytest-Yesti).^2))/(length(Ytest)-2));
    
    %     Texto=strcat('El Error cuadrï¿½tico medio en prueba es: ',{' '},num2str(ECM));
    Texto=['El Error estándar de la regresión en prueba es: ',num2str(SE)];
    disp(Texto);
    %-----------
    %-----------
   
    determinationCoefficient=rsquare(Ytest,Yesti);
    
    %     Texto=strcat('El Error cuadrï¿½tico medio en prueba es: ',{' '},num2str(ECM));
    Texto=['El Coeficiente de determinación de la regresión en prueba es: ',num2str(determinationCoefficient)];
    disp(Texto);
    %------------- Gráfica -------------------------------------------------
    plot(Ytest,'r');
    hold on
    plot(Yesti,'b');
    legend('Real','Predicho');
    title('Real vs predicción');
    xlabel('Muestras');
    ylabel('Nivel de CO - Multisensor de referencia');
    %----------------------------------------------------------------------
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
