clear all;
udata = load("u.data");
u = udata(1:end, 1:2); 
ratings = udata(udata(:,3) >= 3,2);
clear udata;
%utilizadores
utiliz = unique(u(:,1));
Nu = length(utiliz);
%lista de filmes
C = cell(Nu, 1);
for n = 1:Nu
    ind = u(:,1) == utiliz(n);
    C{n} = [C{n} u(ind, 2)];
end

dic = readcell("films.txt","Delimiter","\t");
moviesGenre = dic(:,2:end);
moviesName = dic(:,1);

nhf = 100;

udata2 = load("u.data");
u2 = udata2(1:end, 2:3); clear udata;
bloomFilter = BloomFilter(100000,nhf);
u2 = u2(u2(:,2) >= 3,1);
dlmwrite('matrix.txt', u2, 'delimiter', '\n', 'precision', 4);
for i = 1:length(u2)
    bloomFilter = bloomFilter.insert(u2(i)); 
end

N = 100000;
hf = initHashFuncs(N,nhf);


moviesGenreSignaturesMatrix = calculateStringSignaturesMatrix(moviesGenre,hf,nhf);
moviesNameSignaturesMatrix = calculateStringSignaturesMatrix(moviesName,hf,nhf);
userMoviesSignaturesMatrix = calculateSignaturesMatrix(C,hf,nhf);

save data.mat userMoviesSignaturesMatrix moviesGenreSignaturesMatrix bloomFilter C dic moviesNameSignaturesMatrix
