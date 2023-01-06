function hf= initHashFuncs(m,nhf)
    %nhf => number of hash functions
    ff=1000;
    pp=ff * max(m+1,76);
    pp=pp + ~mod(pp,2);
    while isprime(pp) == false
        pp = pp + 2;
    end
    hf.p = pp;
    hf.a = randi([1, (pp - 1)],1,nhf);
    hf.b = randi([0, (pp-1)],1,nhf);
end