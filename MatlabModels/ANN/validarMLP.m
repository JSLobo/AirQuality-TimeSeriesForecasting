function Yesti = validarMLP(Modelo, Xval,tipo)

%%% El parametro 'tipo' es el tipo de problema que se va a resolver
%1 para regresión
%2 para clasificación

%%% La función debe retornar el valor de predicción Yesti para cada una de
%%% las muestras en Xval.

%Regresión
if tipo == 1
    
    %Complete el código para evaluar la Red
    Yesti = sim(Modelo, Xval');
    Yesti = Yesti';
    
    %Clasificación
    elseif tipo == 2
        
        %Complete el código para evaluar la Red
        Yesti = sim(Modelo, Xval');
        Yesti = Yesti';
    end
end