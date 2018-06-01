% funcion para probar el modelo SVM
function [Yest, YestContinuo] = testSVM(Model,Xtest)

    [Yest, YestContinuo] = simlssvm(Model,Xtest);
    
end