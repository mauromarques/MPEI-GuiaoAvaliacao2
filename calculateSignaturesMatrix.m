function M = calculateSignaturesMatrix(Conjuntos,v,nhf)
    nc = length(Conjuntos);
    M = zeros(nhf,nc);
    %h = waitbar(0,"Calculando as assinaturas (MinHash)");

    for nu=1:nc
        %waitbar(nu/nc,h);
        C = Conjuntos{nu};

        for nh=1:nhf
            M(nh,nu) = mod(v.a(nh) * C(1) + v.b(nh),v.p);

            for nf=2:length(C)
                htmp = mod(v.a(nh) * (C(nf)) + v.b(nh),v.p);
                if htmp < M(nh,nu)
                    M(nh,nu) = htmp;
                end
            end
        end
    end
end
