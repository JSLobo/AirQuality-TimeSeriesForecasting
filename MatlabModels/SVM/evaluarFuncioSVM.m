
%%%%% Autor: Juan Felipe Pérez Calle
%%%%% Fecha: 20/04/2015

%%%%% Función para evaluar un vector en la función de una 
%%%%% Maquina de Soporte Vectorial. [sumatoria(Yi*Ai*Kernel(Xi,V))+b]

%%%%% Parametros:
%%%%%       * Alpha: Es un vector con los valores de Alpha (multiplicadores
%%%%%                   de Lagrange).
%%%%%       * Bias: Es el valor del Bias.
%%%%%       * Targets: Es un vector con la clase a la que corresponde cada
%%%%%                   vector de soporte. En cada posición del vector solo 
%%%%%                   pueden haber los valores 1 ó -1.
%%%%%       * SupportVectors: Es una matriz con los vectores de soporte.
%%%%%       * Muestra: Es el vector a evaluar en la función de la
%%%%%                   maquina de soporte.
%%%%%       * sigma: Es el valor de sigma con el que fue entrenada el
%%%%%                   modelo, en caso de necesitarlo.
%%%%%       * kernel: Es un string con el tipo de kernel utilizado en el
%%%%%                   modelo. Estan implementados el kernel Gaussiano 
%%%%%                   ('gauss'), kernel laplaciano ('laplacian'), 
%%%%%                   y kernel lineal ('linear').

%%%%% Retorno:
%%%%%       * Salida: Es el valor de evaluar el vector en la función.

%%%%% Nota: 
%%%%%       * La función esta implementada de forma vectorial. 
%%%%%       * El parametro 'Muestra' puede ser una matriz con varias 
%%%%%         muestras evaluar. 
%%%%%       * Las matrices y vectores utilizados deben tener las muestras 
%%%%%         en cada fila.

function Salida = evaluarFuncioSVM(Alpha,Bias,Targets,SupportVectors,Muestra,sigma,kernel)

    Alpha=abs(Alpha);
    Salida=((Alpha.*Targets)'*kernel_mat(Muestra,SupportVectors,sigma,kernel))+Bias;

end