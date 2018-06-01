function Yesti = validarMLP(Modelo, Xval,tipo)

%%% El parametro 'tipo' es el tipo de problema que se va a resolver
%1 para regresi�n
%2 para clasificaci�n

%%% La funci�n debe retornar el valor de predicci�n Yesti para cada una de
%%% las muestras en Xval.

%Regresi�n
if tipo == 1
    
    %Complete el c�digo para evaluar la Red
    Yesti = sim(Modelo, Xval');
    Yesti = Yesti';
    
    %Clasificaci�n
    elseif tipo == 2
        
        %Complete el c�digo para evaluar la Red
        Yesti = sim(Modelo, Xval');
        Yesti = Yesti';
    end
end