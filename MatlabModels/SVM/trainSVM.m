% funcion para entrenar el modelo SVM
function Modelo = trainSVM(X,Y,tipo,boxConstraint,sigma, tipoKernel)
    
    if (tipoKernel == 1) % Kernel Lineal
        Modelo = trainlssvm({X,Y,tipo,boxConstraint,sigma,'lin_kernel'});
    elseif(tipoKernel == 2) % Kernel Gaussiano
        Modelo = trainlssvm({X,Y,tipo,boxConstraint,sigma,'RBF_kernel'});
    else
        error('Elija 1 ó 2!!')
    end
end