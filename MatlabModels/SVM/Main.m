
clc
clear all
close all

Rept=10;

% boxConstraint=0.01;
boxConstraintVector = [0.01 , 0.1, 1, 10, 100];
% gamma=0.01;
gammaVector = [0.01, 0.1, 1, 10, 100];
kernelType = 2; % 1 = Lineal, 2 = Gaussian(or RBF)


    
    %%% Regresión %%%
    
    load('database.mat');
    ECMTest=zeros(1,Rept);
    Y = database(:,7);
    X = database(:,1:6);
    NumMuestras=size(X,1);
    for i=1:size(boxConstraintVector,2)
        Texto='|-----------------------------------------------------------------------|';
        disp(Texto);
        for j=1:size(gammaVector,2)
            for fold=1:Rept
                
                %%% Se hace la partición de las muestras %%%
                %%%      de entrenamiento y prueba       %%%
                N=size(X,1);
                
                porcentaje=round(N*0.033);
                rng('default');
                
                Xtrain=X(1:porcentaje,:);
                Xtest=X(porcentaje+1:porcentaje*2,:);
                Ytrain=Y(1:porcentaje,:);
                Ytest=Y(porcentaje+1:porcentaje*2,:);
%                 particion=cvpartition(NumMuestras,'Kfold',Rept);
%                 Xtrain=X(particion.training(fold),:);
%                 Xtest=X(particion.test(fold),:);
%                 Ytrain=Y1(particion.training(fold));
%                 Ytest=Y1(particion.test(fold));
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%% Se normalizan los datos %%%
                
                [Xtrain,mu,sigma]=zscore(Xtrain);
                Xtest=(Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%% Entrenamiento del modelo. %%%
                
                Modelo=trainSVM(Xtrain,Ytrain,'f',boxConstraintVector(i),gammaVector(j),kernelType); %incluir parámetros adicionales, boxcontrain,gamma si aplica, etc...
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%% Validación del modelo. %%%
                
                Yest=testSVM(Modelo,Xtest);
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                ECMTest(fold)=(sum((Yest-Ytest).^2))/length(Ytest);
                
            end
            
            ECM = mean(ECMTest);
            IC = std(ECMTest);
            Texto='|  |---------------------------------------------------------------- |  |';
            disp(Texto);
            Texto='|  |                                                                 |  |';
            disp(Texto);
            Texto=['|  |Box Constraint: ',num2str(boxConstraintVector(i)), ' Gamma: ',num2str(gammaVector(j)),' ECM = ', num2str(ECM),' IC: +- ',num2str(IC),'|  |'];
            disp(Texto);
            Texto='|  |                                                                 |  |';
            disp(Texto);
            Texto='|  |---------------------------------------------------------------- |  |';
            disp(Texto);
        end
        Texto='|-----------------------------------------------------------------------|';
        disp(Texto);
        Texto='|                                                                       |';
        disp(Texto);
        Texto='|                                                                       |';
        disp(Texto);
    end
    %%% Fin punto de regresión %%%
    
