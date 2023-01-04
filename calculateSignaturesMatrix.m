function signatures = calculateSignaturesMatrix(Conjuntos,hf,nhf)
    nc = length(Conjuntos);
    signatures = zeros(nhf,nc);

    for nu=1:nc
        C = Conjuntos{nu};

        for nh=1:nhf
            signatures(nh,nu) = mod(hf.a(nh) * C(1) + hf.b(nh),hf.p);

            for nf=2:length(C)
                htmp = mod(hf.a(nh) * (C(nf)) + hf.b(nh),hf.p);
                if htmp < signatures(nh,nu)
                    signatures(nh,nu) = htmp;
                end
            end
        end
    end
end
