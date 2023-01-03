id = -1;
while id < 1 || id > 943
    id = input("Insert User ID (1 to 943): ")
end

udata = load("u.data");
u = udata(1:end, 1:2); clear udata;
%utilizadores
utiliz = unique(u(:,1));
Nu = length(utiliz);
%lista de filmes
C = cell(Nu, 1);
for n = 1:Nu
    ind = u(:,1) == utiliz(n);
    C{n} = [C{n} u(ind, 2)];
end

dic = readcell('films.txt', 'Delimiter', '\t');

udata2 = load("u.data");
u2 = udata2(1:end, 2:3); clear udata;
bloomFilter = BloomFilter(10000,1);
u2 = u2(i,2) >= 3;
for i = 1:length(u2)
    bloomFilter.insert(u2(i,1))
end

option = 1;
while option ~= 5
    disp("1 - Your movies")
    disp("2 - Suggestion of movies based on other users")
    disp("3 - Suggestion of movies based on already evaluated movies")
    disp("4 - Movies feedback based on popularity")
    disp("5 - Exit")
    option = input("Select choice: ")

    switch option
        case 1
            movies(id, C, dic)
        case 2
            disp("2")
        case 3
            disp("3")
        case 4
            moviesFeedback(dic, bloomFilter)
    end
end

