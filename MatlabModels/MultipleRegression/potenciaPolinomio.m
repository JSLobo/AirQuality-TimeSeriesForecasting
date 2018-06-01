function X2 = potenciaPolinomio(X,grado)

X2=X;

if grado~=1
    for i=2:grado

        Xe=X.^i;
        X2=[X2,Xe]; 

    end
end

end