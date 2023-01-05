function distance = jaccardDistance(base,signatures,nhf)
    %% Calcula a distancia de Jaccard entre todos os pares pela definicao.
    Nu = length(signatures);
    distance=zeros(Nu); % array para guardar distancias
    for n1= 1:size(base,2)
        for n2= n1+1:Nu
            simJ = sum(signatures(:,n1) == signatures(:,n2)) / nhf;
            distance(n1,n2) = 1-simJ;
            %distance(n2,n1) = 1 - simJ;
        end
    end
end