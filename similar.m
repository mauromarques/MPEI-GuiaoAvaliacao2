function SimilarUsers = similar(users,dist,threshhold)
    %% Com base na distancia, determina pares com
    %% distancia inferior a um limiar pre-definido
    
    %Nu = length(users);
    %ti = tic;
    % Array para guardar pares similares (user1, user2, distancia)
    [id1, id2, ~] = find(dist < threshhold & dist > 0);
    SimilarUsers= zeros(length(id1),3);
    for k= 1:length(id1)
        n1 = id1(k);
        n2 = id2(k);
        SimilarUsers(k,1) = users(n1);
        SimilarUsers(k,2) = users(n2);
        SimilarUsers(k,3) = dist(n1,n2);
    end
end
