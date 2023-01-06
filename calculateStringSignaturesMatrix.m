function minhash = calculateStringSignaturesMatrix(strings,hf,nhf)
    minhash = zeros(nhf,length(strings));  
    for i=1:length(strings)
        % strings is a cell array of cell arrays
        % ex: {{"Animation","Children's","Comedy"} {"Comedy","Animation","Children's","Crime","Thriller","Horror"}}
        st = strings(i,:);
        for nh=1:nhf
            s = double(cell2mat(st(1)));
            minhash(nh,i) = mod(hf.a(nh) * sum(s) + hf.b(nh),hf.p);
            for nf=2:length(st)
                %ignore missing cells
                if ismissing(st{nf})
                    continue
                end
                s2 = double(cell2mat(st(nf)));
                htmp = mod(hf.a(nh) * sum(s2) + hf.b(nh),hf.p);
                if htmp < minhash(nh,i)
                    minhash(nh,i) = htmp;
                end
            end
        end
    end
end

