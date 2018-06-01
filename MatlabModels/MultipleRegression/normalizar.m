function Z=normalizar(Datos,MU,SIG)

    N=length(MU);
    Z=[];
    
    for i=1:N
        
        vector=(Datos(:,i)-MU(i))./SIG(i);
        Z=[Z,vector];
                
    end

end