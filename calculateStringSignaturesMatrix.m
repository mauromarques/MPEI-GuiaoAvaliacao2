%clear all;
%strings1 = {{"Animation","Children's","Comedy"} {"Comedy","Animation","Children's","Crime","Thriller","Horror"}};
%nhf = 10;
%hf = initHashFuncs(100000,nhf);
%c = calculateStringSignaturesMatrix(strings1,hf,nhf);
%simJ = sum(c(:,1) == c(:,2)) / nhf;
%distance = 1 - simJ;
%fprintf("\nDistancia: %.2f\n",distance);

function minhash = calculateStringSignaturesMatrix(strings,hf,nhf)
    minhash = zeros(nhf,length(strings));  
    for i=1:length(strings)
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

