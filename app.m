clear all;
id = -1;
while id < 1 || id > 943
    id = input("Insert User ID (1 to 943): ");
end

data = load("data.mat");

option = 1;
while option ~= 5
    disp("1 - Your movies")
    disp("2 - Suggestion of movies based on other users")
    disp("3 - Suggestion of movies based on already evaluated movies")
    disp("4 - Movies feedback based on popularity")
    disp("5 - Exit")
    option = input("Select choice: ");

    switch option
        case 1
            movies(id, data.C, data.dic)
        case 2
            similarities = jaccardSimillarity(data.userMoviesSignaturesMatrix, id);
            likelyUsers = zeros(1,2);
            likelyUsers(1,1) = similarities(1, length(similarities));
            likelyUsers(1,2) = similarities(1, length(similarities)-1);
            movies1 = cell2mat(data.C(likelyUsers(1,1)));
            movies2 = cell2mat(data.C(likelyUsers(1,2)));
            movies3 = cell2mat(data.C(id));
            moviesToReccommend = unique(cat(1, movies2, movies1));
            moviesToReccommend = setdiff(movies3, moviesToReccommend);
            answer = cell(1,length(moviesToReccommend));
            for i = 1:length(moviesToReccommend)
                name = data.dic{moviesToReccommend(i)};
                answer{i} = name;
            end
            answer
        case 3
            disp("3")
        case 4
            moviesFeedback(dic, bloomFilter)
    end
end

