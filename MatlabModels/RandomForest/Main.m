
clc
clear all
% close all

load('database.mat');

Y = database(:,7);
X = database(:,1:6);

N=size(X,1); 
Rept=10;


    
    
    ECMTest=zeros(1,Rept);
    %%% Random Forest %%%
    contador = 0;
    
    
    for fold=1:Rept

        %%% Se hace la partición de las muestras %%%
        %%%      de entrenamiento y prueba       %%%
        
        porcentaje=round(N*0.033);
        rng('default');
        %ind=randperm(size(X,1)); %%% Se seleccionan los indices de forma aleatoria
        Xtrain=X(1:porcentaje,:);
        Xtest=X(porcentaje+1:porcentaje*2,:);
        Ytrain=Y(1:porcentaje,:);
        Ytest=Y(porcentaje+1:porcentaje*2,:);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      
 tic % Con tic le pido a matlab que inicie el cronometro para medir cuanto se demora la ejecucion de las siguientes lineas en esta iteracion
        NumArboles=10;
        Modelo=entrenarFOREST(NumArboles,Xtrain,Ytrain);
toc % Con toc paro el cronometro e imprimo el tiempo que se tomo
contador = contador + toc;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%% Validación de los modelos. %%%
        
        Yest=testFOREST(Modelo,Xtest);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ECMTest(fold)=(sum((Yest-Ytest).^2))/length(Ytest);
       
        
    end
    ECM = mean(ECMTest);
            IC = std(ECMTest);
            Texto='|  |---------------------------------------------------------------- |  |';
            disp(Texto);
            Texto='|  |                                                                 |  |';
            disp(Texto);
            Texto=['|  |Múmero de Árboles: ',num2str(NumArboles),' ECM = ', num2str(ECM),' IC: +- ',num2str(IC),'|  |'];
            disp(Texto);
            Texto='|  |                                                                 |  |';
            disp(Texto);
            Texto='|  |---------------------------------------------------------------- |  |';
            disp(Texto);
    



