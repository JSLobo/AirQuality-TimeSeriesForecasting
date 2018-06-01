function net = entrenarMLP(Xent,Yent,tipo, capas_neuronas, ep)

    %%% El parametro 'tipo' es el tipo de problema que se va a resolver
    %1 para regresión
    %2 para clasificación
    
    %%% La función debe retornar el modelo (net) entrenado con las muestras de entrenamiento.

    %Regresión
    if tipo == 1
    
        %Complete el código para crear el modelo
%         net = fitnet(capas_neuronas,'trainlm');
%         net.trainParam.epochs=ep;
%         net = train(net,Xent',Yent');
        
        net = patternnet(capas_neuronas,'trainlm');
        
                %%
% Se establece el número de épocas
net.trainParam.epochs=ep;
        
     %view(net)
        %%
% Se deshabilita la ventana de entrenamiento de la red (defecto
% 1)
net.trainParam.showWindow=0;
        %Complete el código para entrenar el modelo
        net = train(net,Xent',Yent');
        

   
    
    %Clasificación
    elseif tipo == 2
        
        % Complete el código para crear el modelo Pattern Recognition Network
        net = fitnet(capas_neuronas,'trainlm');
        net.trainParam.epochs=ep;
        net.trainParam.showWindow=0;
        net = train(net,Xent',Yent');
        
        
        % Complete el código para entrenar el modelo
        
        
    end
end