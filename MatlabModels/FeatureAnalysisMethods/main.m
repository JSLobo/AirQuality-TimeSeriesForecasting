% Se limpian el workspace, el command window y se cierra cualquier figura
clc
clear all
close all

% Se despliegua un mensaje para saber cual punto se desea ejecutar
punto=input('Seleccione:\n1 - Para coeficiente de correlación de Pearson \n2 - Para método de búsqueda secuencial hacia adelante (SFS)\n3 - Para análisis de componentes principales (PCA)'); %Se cargan los datos (Se usa el mismo conjunto de datos para todos los puntos)
load('database.mat');
Y = database(:,7);
X = database(:,1:6);
if (punto == 1)
    % Se normalizan los datos
    X = zscore(X);
    % NOTA: Ya revise y no hace la diferencia si se normaliza o no
    
    %%%%%%%%%%%% Correlacion entre las caracteristicas X
    
    alpha = 0.05; % Use 0.05 para un IC del 95% [Opcion por defecto] | Use 0.1 para un IC del 90% | etc.....
    [correlacion,p]= corrcoef([X,Y],'alpha',alpha); % Se calcula la matriz de coeficientes de correlacion y valores p
    
    % Luego se grafican dichas matrices
    figure(1)
    plottable(correlacion);
    title('Matriz De Correlacion X');
    
    figure(2)
    imagesc(correlacion);
    colorbar;
    
    figure(3)
    plottable(p);
    title('Matriz De Valores P');
    %NOTA1: Si el valor de p es más pequeño que el valor de alpha entonces hay una correlacion significativa
    
    %NOTA2: Recuerde que lo ideal es:
    %                   Poca correlacion entre las X porque ello me indica
    %                   que las caracteristicas son independientes y cada
    %                   una aporta informacion.
    %                   Mucha correlacion entre las X y la Y porque ello indica
    %                   que si hay algun vinculo o relacion entre las
    %                   muestras y la salida esperada.
    
 
%     
%     %%%%%%%%% Fin punto 1
    
elseif (punto == 2)
    %%%%%%%%%%%% Método de búsqueda secuencial hacia adelante (SFS)
    
    Rept=10; % Se establece el numero de pliegues (folds) para la validación cruzada
    NumMuestras=size(X,1); % Se determina cuantas son las muestras de entrenamiento
    %EficienciaTest=zeros(1,Rept); % Se inicializa un vector columna en donde se guardara la eficiencia de los modelos en cada iteracion
    ECMTest=zeros(1,Rept);
    % Se crean una variables de configuración para el proceso de seleccion de caracteriticas
    opciones = statset('display','iter'); % Si desea ver los resultados en cada iteracion use 'iter', pero si solo desea ver el resultado final use 'final'
    sentido = 'forward'; % Use 'forward' para busqueda hacia adelante (opcion por defecto) o 'backward' para busqueda hacia atras
    
    % Ahora, se realiza la seleccion de caracteristicas, de modo que: en el primer retorno estara en binario si se debe incluir o no la caracteristica de la columna.
    % Por otra parte, en el segundo retorno se guarda un historial de como se fueron añadiendo las caracteristicas.
    %     rng('default');
    [caracteristicasElegidas, proceso] = sequentialfs(@funcionForest,X,Y,'direction',sentido,'options',opciones);
    
    % Antes de pasar al entrenamiento y validacion del modelo, se separan o se dejan solo las caracteristicas con las cuales se desea trabajar
    X = X(:, caracteristicasElegidas);
    
    % Ahora se hace la fase de entrenamiento y validacion del sistema, por lo que:
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
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%% Se normalizan los datos %%%
        
        [Xtrain,mu,sigma] = zscore(Xtrain);
        Xtest = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Estas instrucciones lo que hacen es que realizan la seleccion de caracteristicas en cada iteracion. Pero esto es muy demorado!!
        
        % % % % %         [caracteristicasElegidas, proceso] = sequentialfs(@funcionForest,Xtrain,Ytrain,'direction',sentido,'options',opciones);
        % % % % %         XReducidas = X(:, caracteristicasElegidas);
        % % % % %         [NumMuestras,~] = size(XReducidas);
        % % % % %         indices=randperm(NumMuestras);
        % % % % %         porcionEntrenamiento = round(NumMuestras*0.7);
        % % % % %         Xtrain=XReducidas (indices(1:porcionEntrenamiento),:);
        % % % % %         Xtest=XReducidas(indices(porcionEntrenamiento+1:end),:);
        % % % % %         Ytrain=Y(indices(1:porcionEntrenamiento),:);
        % % % % %         Ytest=Y(indices(porcionEntrenamiento+1:end),:);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Se hace el entrenamiento del modelo
        NumArboles=10;
        Modelo = TreeBagger(NumArboles,Xtrain,Ytrain);
        
        % Se obtienen las predicciones del modelo con base al modelo
        % entrenado y las muestras separadas para la validacion del sistema
        Yest = predict(Modelo,Xtest);
        Yest = str2double(Yest);
        
        % Por ultimo, se calcula la eficiencia de esta iteracion
        ECMTest(fold)=(sum((Yest-Ytest).^2))/length(Ytest);
        %EficienciaTest(fold) = sum(Ytest == Yest)/length(Ytest);
    end
    
    % Una vez sale del ciclo, se muestra cual fue la eficiencia promedio del sistema
%     Eficiencia = mean(EficienciaTest);
%     IC = std(EficienciaTest);
    ECM = mean(ECMTest);
            IC = std(ECMTest);
    Texto=['ECM = ', num2str(ECM),' +- ',num2str(IC)];
    disp(Texto);
    
    %%%%%%%%% Fin punto 2

elseif (punto == 3)
    %%%%%%%%%%%% Transformacion PCA
    
    Rept=10; % Se establece el numero de pliegues (folds) para la validación cruzada
    NumMuestras=size(X,1); % Se determina cuantas son las muestras de entrenamiento
    %EficienciaTest=zeros(1,Rept); % Se inicializa un vector columna en donde se guardara la eficiencia de los modelos en cada iteracion
    ECMTest=zeros(1,Rept);
    umbralPorcentajeDeVarianza = 95; % Como ultimo parametro del sistema se establece el porcentaje de varianza que definira cuantos componentes se deben incluir para el sistema
    
    for fold=1:Rept
        %%% Se hace la partición de las muestras %%%
        %%%      de entrenamiento y prueba       %%%
        rng('default');
        particion=cvpartition(NumMuestras,'Kfold',Rept);
        indices=particion.training(fold);
        Xtrain=X(particion.training(fold),:);
        Xtest=X(particion.test(fold),:);
        Ytrain=Y(particion.training(fold));
        Ytest=Y(particion.test(fold));
        
        %%% Se normalizan los datos %%%
        
        [Xtrain,mu,sigma] = zscore(Xtrain);
        Xtest = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Ahora, se extraen los componentes principales, de modo que:
        
        % Se usa la función PCA de matalab para obtener los coeficientes de los componentes principales, los scores, las
        % varianzas de los componentes principales y el porcentaje de varianza explicada de estos. La sumatoria de este ultimo
        % retorno debe dar un total del 100%
        [coefCompPrincipales,scores,covarianzaEigenValores,~,porcentajeVarianzaExplicada,~] = pca(Xtrain);
        
        % A continuacion, se almacena el numero original de variables que tiene el sistema
        numVariables = length(covarianzaEigenValores);
        % También, se crea un variable con la cual se guardara el numero de componentes principales cuyos porcentajes de varianza sumada superan el porcentaje de varianza limite deseada
        numCompAdmitidos = 0;
        
        % Luego, se crean unas variables que almacenaran coordenadas de unas graficas que se dibujaran más adelante
        porcentajeVarianzaAcumulada = zeros(numVariables,1);
        puntosUmbral = ones(numVariables,1)*umbralPorcentajeDeVarianza;
        ejeComponentes = 1:numVariables;
        
        % PARA k que comienza en 1 HASTA el numero original de componentes HAGA
        for k=1:numVariables
            % Sume la varianza de los componentes 1 hasta k y guadelo en porcentajeVarianzaAcumulada(k)
            porcentajeVarianzaAcumulada(k) = sum(porcentajeVarianzaExplicada(1:k));
            
            %porcentajeVarianzaAcumulada(k) = sum(covarianzaEigenValores(1:k)) ./ sum(covarianzaEigenValores); % Otra forma de hacer la instruccion anterior pero los valores quedan entre 0 y 1.
            
            % SI la suma de los k componentes supera el limite de varianza deseado Y todavia no se ha establecido un numero de componentes a dejar para el sistema ENTONCES
            if (sum(porcentajeVarianzaExplicada(1:k)) >= umbralPorcentajeDeVarianza) && (numCompAdmitidos == 0)
                numCompAdmitidos = k; % Se guarda el numero de la iteracion puesto que este es el numero de componentes a tener en cuenta para el sistema
            end
        end
        
        % Una vez se calculan los varianzas acumuladas, se dibujan dos graficas:
        
        % La primera es una grafica de la magnitud de los EigenValores
        figure(1)
        stem(ejeComponentes, covarianzaEigenValores)
        xlim([1 numVariables]);
        title('Varianza de los componentes principales');
        xlabel('Componentes principales');
        ylabel('EigenValor');
        
        % La segunda grafica consiste en la acumulacion progresiva de la varianza a medida que se recorren los componentes y cual es el limite o umbral de varianza acumulada que se fijo para incluir el numero de componentes principales.
        figure(2)
        plot(ejeComponentes, porcentajeVarianzaAcumulada);
        xlim([1 numVariables]);
        hold on;
        plot(ejeComponentes, puntosUmbral,'r');
        title('Varianza acumulada de los componentes principales');
        xlabel('Componentes principales');
        ylabel('Varianza explicada (%)');
        hold off;
        
        % Ya determinado el numero de componentes con los que se quiere trabajar se estiman o proyectan los datos sobre dichos componentes principales para que el sistema trabaje con ellos
        aux = Xtrain*coefCompPrincipales;
        Xtrain = aux(:,1:numCompAdmitidos);
        
        aux = Xtest*coefCompPrincipales;
        Xtest = aux(:,1:numCompAdmitidos);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Se hace el entrenamiento del modelo
        NumArboles=10;
        Modelo = TreeBagger(NumArboles,Xtrain,Ytrain);
        
        % Se obtienen las predicciones del modelo con base al modelo
        % entrenado y las muestras separadas para la validacion del sistema
        Yest = predict(Modelo,Xtest);
        Yest = str2double(Yest);
        
        % Por ultimo, se calcula la eficiencia de esta iteracion
          ECMTest(fold)=(sum((Yest-Ytest).^2))/length(Ytest);
    end
  
    % Una vez sale del ciclo, se muestra cual fue la eficiencia promedio del sistema
     ECM = mean(ECMTest);
            IC = std(ECMTest);
    Texto=['ECM = ', num2str(ECM),' +- ',num2str(IC)];
    disp(Texto);
    
    %%%%%%%%% Fin punto 3

else
    disp('Por favor ingrese una opción válida!');
end