function M = calculateSignaturesMatrix(Conjuntos,hf,nhf)
    nc = length(Conjuntos);
    M = zeros(nhf,nc);

    for nu=1:nc
        C = Conjuntos{nu};

        for nh=1:nhf
            M(nh,nu) = mod(hf.a(nh) * C(1) + hf.b(nh),hf.p);

            for nf=2:length(C)
                htmp = mod(hf.a(nh) * (C(nf)) + hf.b(nh),hf.p);
                if htmp < M(nh,nu)
                    M(nh,nu) = htmp;
                end
            end
        end
    end
end
