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
            watchedMovies = data.C{id};
            fprintf("\nMovies you watched:\n");
            for i=1:length(watchedMovies)
                fprintf("%s\n",data.dic{i});
            end
            fprintf("\n");
        case 2
            % similarities between the current user and all the other users
            % in crescent order
            similarities = jaccardSimillarity(data.userMoviesSignaturesMatrix, id);
            % The two most likely users
            likelyUsers = zeros(1,2);
            likelyUsers(1,1) = similarities(1, length(similarities));
            likelyUsers(1,2) = similarities(1, length(similarities)-1);
            %The movies seen by the 2 most likely users 
            movies1 = cell2mat(data.C(likelyUsers(1,1)));
            movies2 = cell2mat(data.C(likelyUsers(1,2)));
            %The movies seem by the current user
            movies3 = cell2mat(data.C(id));
            % Movies seem by at least one of the two likely users AND that
            % havent been seen by the current user
            moviesToReccommend = unique(cat(1, movies2, movies1));
            [~,ids1,~] = intersect(moviesToReccommend,movies3);
            moviesToReccommend(ids1,:) = [];
            answer = cell(1,length(moviesToReccommend));
            % Print reccommendations
            fprintf("\nMovies you might like:\n");
            for i = 1:length(moviesToReccommend)
                fprintf("%s\n",data.dic{moviesToReccommend(i)});
            end
            fprintf("\n");
            
        case 3
            evaluatedMovies = data.C{id};
            t = [];
            g = [];
            for i=1:length(evaluatedMovies)
                simil = jaccardSimillarity(data.moviesGenreSignaturesMatrix,evaluatedMovies(i));
                [~,col,~] = find(simil(2,:) > 0.2);
                g(i) = length(col);
                t = [t simil(:,col)];
            end

            [~,col,col2] = intersect(t(1,:),evaluatedMovies);
            t(:,col) = [];
            
            ut = unique(t(1,:));

            %how many times each element appears in t
            c = histcounts(t(1,:),ut);
            
            %save the id of the movie(s) that appear most often
            m = max(c);
            toRecommend = ut(c == m);
            if length(toRecommend) == 1
                c(c == m) = 0;
                m = max(c);
                u = ut(c == m);
                toRecommend = [toRecommend u(1)];
            end
            % prevent more than 2 recommendations
            toRecommend = toRecommend(1:2);
            %print the name of the movies to recommend
            toRecommend = toRecommend(1:2);
            fprintf("\nMovies you might like:\n")
            for i=1:length(toRecommend)
                disp(data.dic{toRecommend(i),1});
            end
            fprintf("\n");    
        case 4
            % The search text
            search = input("Enter your search: ", "s");
            % Cell array to store similarities
            similarities = cell(1,length(data.dic));
            % For each movie title, compare with the search text and
            % populate the similarities cell array.
            for i = 1:length(data.dic)
                str1 = lower(search);
                str2 = lower(data.dic{i});
                % Shingle size
                shingle_size = 3;
                % Number of hash functions
                nhf = 10;
                % Number of counters in counting bloom filter
                nbits = 1000;
                % Add the result of the similarity  to the cell array
                similarities{i} = minhash(str1, str2, shingle_size, nhf, nbits);
            end
            % transform the cell array into an array and sort it in
            % descending order
            [as,idx] = sort(cell2mat(similarities),'descend');
            % Show the 5 results with a bigger similarity and uses the
            % bloom filter to count the number of reviews above 3 that the
            % movie has.
            for i = 1:5
                disp(data.dic{idx(i)})
                disp(data.bloomFilter.count(idx(i)))
            end
    end
end

