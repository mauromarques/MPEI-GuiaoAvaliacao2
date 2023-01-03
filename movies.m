function [filmes] = movies(id, listaUtilizadores, listaFilmes)
    idsArray = listaUtilizadores{id};
    filmes = cell(1, length(idsArray));
    for i = 1:length(idsArray)
        filmes{i} = listaFilmes{idsArray(i), 1};
    end
end