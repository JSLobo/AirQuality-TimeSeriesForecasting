
%clc
%clear all
close all



disp('Regresión (MLP)')


   
    
    load('database.mat');
    
    Y = database(:,7);
    X = database(:,1:6);
    mallaEpocas = [50 100 200 500 1000];
    mallaNeuronas = [3 5 15 20];
    errorMatrix1 = zeros(length(mallaEpocas),length(mallaNeuronas));
    errorMatrix2 = zeros(length(mallaEpocas),length(mallaNeuronas));
    
    for posMallaEpocas = 1 : length(mallaEpocas)
        %%%Ingrese aquí las neuronas
        %mallaNeuronas = [20 30 40 50 60];
        
        
        for posMallaNeuronas = 1 : length(mallaNeuronas)
            % bootstrapping
            rept = 20;
            
            
            %         errTest = zeros(1, rept);
            %         raeTest = zeros(1, rept);
            %         time_test = zeros(1, rept);
            %         Features = struct([]);
            %         NumMuestras=size(X,1);
            %%% Se hace la partición entre los conjuntos de entrenamiento y prueba.
            %%% Esta partición se hace forma aletoria %%%
            
            N=size(X,1);
            
            %porcentaje=round(N*0.7);
            porcentaje=round(N*0.033);
            rng('default');
            %ind=randperm(N); %%% Se seleccionan los indices de forma aleatoria
            
            ECM1 = zeros(20,1);
            ECM2 = zeros(20,1);
            
            for k = 1:rept
                %Xtrain=X(ind(1:porcentaje),:);
                %Xtest=X(ind(porcentaje+1:end),:);
                %Xtrain=X(1:porcentaje,:);
                %Xtest=X(porcentaje+1:end,:);
                Xtrain=X(porcentaje*2:porcentaje*3,:);
                Xtest=X((porcentaje*3)+1:porcentaje*4,:);
                
                %Ytrain=Y(ind(1:porcentaje),:);
                %Ytest=Y(ind(porcentaje+1:end),:);
                %Ytrain=Y(1:porcentaje,:);
                %Ytest=Y(porcentaje+1:end,:);
                Ytrain=Y(porcentaje*2:porcentaje*3,:);
                Ytest=Y((porcentaje*3)+1:porcentaje*4,:);
                                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%% Normalización %%%
                
                [Xtrain,mu,sigma]=zscore(Xtrain);
                Xtest=normalizar(Xtest,mu,sigma);
                
                %%%%%%%%%%%%%%%%%%%%%
                
                %%% Se crea y se entrena el modelo  %%%
                epochs = mallaEpocas(posMallaEpocas);
                capas_neuronas = [mallaNeuronas(posMallaNeuronas)]; % El número de entradas de este arreglo indica el número
                % de capas ocultas. El valor de cada entrada
                % del arreglo indica el número de neuronas
                % en esa capa. [10] indica una capa oculta
                % con 10 neuronas.
                model = entrenarMLP(Xtrain, Ytrain, 1, capas_neuronas, epochs); % 1 para regresión, 2 para clasificación
                
                %%% Se aplica la regresión usando ANN-MLP  %%%
                
                Yesti=validarMLP(model,Xtest,1);
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%% Se encuentra el error cuadratico medio %%%
                error = ((sum((Yesti-Ytest).^2))/length(Ytest));
                
                ECM1(k,1) = error(1);
                %ECM2(k,1) = rsquare(Ytest,Yesti);
                
            end
            
            Texto=strcat('El Error cuadrático medio en validación es:  ', num2str(mean(ECM1)));
            disp(Texto);
            
            errorMatrix1(posMallaEpocas,posMallaNeuronas) = mean(ECM1);
            %errorMatrix2(posMallaEpocas,posMallaNeuronas) = mean(ECM2);
            %     Texto=strcat('El Error cuadrático medio en validación para Y2 es:  ', num2str(mean(ECM2)));
            %     disp(Texto);
            %     errorMatrix2(posMallaEpocas,posMallaNeuronas) = mean(ECM2);
            %     %%%%%%%%%%%
            %     time = mean(time_test);
            %         timeIC = std(time_test);
            %         %
            %         %
            %         disp('');
            %         disp('==================');
            %         Texto = ['Comienzo neurona: ',num2str(mallaNeuronas(posMallaNeuronas)), ' para número de épocas: ', num2str(mallaEpocas(posMallaEpocas)) ];
            %         disp(Texto);
            %         disp('==================');
            %
            %
            %         Eficiencia = mean(EficienciaTest);
            %         IC = std(EficienciaTest);
            %         Texto=['La eficiencia obtenida fue = ', num2str(Eficiencia),' +- ',num2str(IC)];
            %         disp(Texto);
            %         fprintf('Tiempo %.5f +- %.5f \n', time, timeIC);
            %         %
            %         disp('');
            %         disp('==================');
            %         disp('Final');
            %         disp('==================');
            %%%%%%%%%%%
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% Fin %%%
    
    