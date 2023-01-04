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
            genreDistance = jaccardDistance(data.moviesGenreSignaturesMatrix,100);
            evaluatedMovies = data.C{id};
            %get [row number, collumn number] of the elements that have
            %distance < 0.8
            [id1, id2, ~] = find(genreDistance < 0.8 & genreDistance > 0);
            %concatenate them in a single matrix (easier to use)
            t = [id1 id2];
            %first collumn of t should be the movies already watched by the
            %user
            [~,id1,~] = intersect(t(:,1),evaluatedMovies);
            %remove the lines that contain movies (in collumn 1) that the 
            %user hasnt watched
            t = t(id1,:);
            %second collumn should only have movies the user hasnt watched
            [~,id2,~] = intersect(t(:,2),evaluatedMovies);
            %remove the lines that contain movies that the user has watched
            t(id2,:) = [];
            
            ut = unique(t(:,2));

            %how many times each element appears in t
            c = histcounts(t(:,2),ut);
            clear id1 id2 t
            %save the id of the movie(s) that appear most often
            m = max(c);
            toRecommend = ut(c == m);
            if length(toRecommend) == 1
                c(c == m) = 0;
                m = max(c);
                toRecommend = [toRecommend ut(c == m)];
            end

            %print the name of the movies to recommend
            toRecommend = toRecommend(1:2);
            fprintf("\nMovies you might like:\n")
            for i=1:length(toRecommend)
                disp(data.dic{toRecommend(i),1});
            end
            fprintf("\n");     
        case 4
            moviesFeedback(dic, bloomFilter)
    end
end

