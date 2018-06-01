function Salida = testFOREST(Modelo,X)
% Aqui se realizan las predicciones de las muestras de validacion en
    % base a la prediccion del random forest.
    
    Salida = predict(Modelo,X);
    Salida = str2double(Salida);
    
    
end