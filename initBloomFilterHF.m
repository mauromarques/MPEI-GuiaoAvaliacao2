function h = initBloomFilterHF(n)
    ff = 1000;
    pp = ff * max(n+1,76);
    pp = pp + ~mod(pp,2);
    while isprime(pp) == false
        pp = pp + 2;
    end

    h.p = pp;
    h.a = randi([1,(pp-1)]);
    h.b = randi([0,(pp-1)]);
    h.c = randi([1,(pp-1)]);
end