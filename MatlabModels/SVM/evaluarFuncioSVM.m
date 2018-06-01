
%%%%% Autor: Juan Felipe P�rez Calle
%%%%% Fecha: 20/04/2015

%%%%% Funci�n para evaluar un vector en la funci�n de una 
%%%%% Maquina de Soporte Vectorial. [sumatoria(Yi*Ai*Kernel(Xi,V))+b]

%%%%% Parametros:
%%%%%       * Alpha: Es un vector con los valores de Alpha (multiplicadores
%%%%%                   de Lagrange).
%%%%%       * Bias: Es el valor del Bias.
%%%%%       * Targets: Es un vector con la clase a la que corresponde cada
%%%%%                   vector de soporte. En cada posici�n del vector solo 
%%%%%                   pueden haber los valores 1 � -1.
%%%%%       * SupportVectors: Es una matriz con los vectores de soporte.
%%%%%       * Muestra: Es el vector a evaluar en la funci�n de la
%%%%%                   maquina de soporte.
%%%%%       * sigma: Es el valor de sigma con el que fue entrenada el
%%%%%                   modelo, en caso de necesitarlo.
%%%%%       * kernel: Es un string con el tipo de kernel utilizado en el
%%%%%                   modelo. Estan implementados el kernel Gaussiano 
%%%%%                   ('gauss'), kernel laplaciano ('laplacian'), 
%%%%%                   y kernel lineal ('linear').

%%%%% Retorno:
%%%%%       * Salida: Es el valor de evaluar el vector en la funci�n.

%%%%% Nota: 
%%%%%       * La funci�n esta implementada de forma vectorial. 
%%%%%       * El parametro 'Muestra' puede ser una matriz con varias 
%%%%%         muestras evaluar. 
%%%%%       * Las matrices y vectores utilizados deben tener las muestras 
%%%%%         en cada fila.

function Salida = evaluarFuncioSVM(Alpha,Bias,Targets,SupportVectors,Muestra,sigma,kernel)

    Alpha=abs(Alpha);
    Salida=((Alpha.*Targets)'*kernel_mat(Muestra,SupportVectors,sigma,kernel))+Bias;

end