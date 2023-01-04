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
            movies(id, C, dic)
        case 2
            disp("2")
        case 3
            disp("3")
        case 4
            moviesFeedback(dic, bloomFilter)
    end
end

