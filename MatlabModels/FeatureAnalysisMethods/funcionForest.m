function Error=funcionForest(Xtrain,Ytrain,Xtest,Ytest)
    % Se establece un numero de arboles
    NumArboles=10;
    
    % Se entrena el random forest con los datos de entrenamiento
    Modelo = TreeBagger(NumArboles,Xtrain,Ytrain);
    
    % Luego, se realizan las predicciones de las muestras de validacion
    Yest = predict(Modelo,Xtest);
    Yest = str2double(Yest);
    
    % Y para terminar se retorna el error de la clasificacion
    Error = sum(Ytest ~= Yest)/length(Ytest);
    
    % NOTA::::
    % Porque EL ERROR y no la eficiencia, el motivo es porque la funcion
    % sequentialfs de MATLAB siempre buscara reducir el retorno de la
    % funcion criterio y por consiguiente si le dejamos como eficiencia
    % entonces se tratara de disminuir la eficiencia de clasificacion lo
    % cual es lo opuesto a lo buscado, por tanto debe ser el error.
end