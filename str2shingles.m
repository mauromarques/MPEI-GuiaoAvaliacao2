function shingles = str2shingles(str, shingle_size)
    str = str(find(~isspace(str)));
    l = length(str) - shingle_size + 1;
    for i = 1:l
        t='';
        for j = i:(i + shingle_size - 2)
            t = strcat(t,str(j),' ');
        end
        t = strcat(t, str(i + shingle_size - 1));
        shingles{i} = t;
    end
end
