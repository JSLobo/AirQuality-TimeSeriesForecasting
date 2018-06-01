  function Yesti = ventanaParzen(Xval,Xent,Yent,h,tipo)

          %%% La funci贸n debe retornar el valor de predicci贸n Yesti para cada una de 
	  %%% las muestras en Xval. Por esa raz贸n Yesti se inicializa como un vectores 
	  %%% de ceros, de dimensi贸n M.
  
    
      M=size(Xval,1); 
      %N=size(Xent,1); 
      
      [N,d]=size(Xent);
      
      Yesti=zeros(M,1);

      if strcmp(tipo,'regress')
      
	  for j=1:M
	    %%% Complete el codigo %%%
        % Con temp se compara la muestra i con
        % todas las muestras de entrenamiento
        temp = repmat(Xval(j, :), N, 1);
        
        % Calculamos el valor con el predictor
        Yesti(j) = predictor(Xent, Yent, temp, h);          
        
	    %%%%%%%%%%%%%%%%%%%%%%%%%%
	    
	  end
      
      elseif strcmp(tipo,'class')
          
          for j=1:M
              %%% Complete el codigo %%%
              num=0;
              den=0;
              for l=1:N
                  distancia=0;
                  
                  for m=1:d
                      distancia=distancia+(Xval(j,m)- Xent(l,m))^2;
                  end
                  
                  distancia=sqrt(distancia)/h;
                  den=den+gaussianKernel(distancia);
              end
              N*power(h,d)
              Yesti(j)=(den)/(N*power(h,d));
          
          %%%%%%%%%%%%%%%%%%%%%%%%%%
          
      end
      
  end
  
  end
  
  function yest = predictor(Xent, Yent, Xval, h)
    % Calculamos el valor del kernel para los valores dados    
    dist = distEuclid(Xent, Xval);
    ucuad = (dist/h);
    k = gaussianKernel(ucuad);
    
    % Calculamos el numerador y el denominador del predictor
    num = sum(k .* Yent);
    den = sum(k);
    
    % Hacemos la predicci髇 y retornamos el valor calculado
    yest = num / den;  
end
