function h = hash(str)
    % Hash function for strings
    h = 0;
    for i = 1 : length(str)
        h = h + uint8(str(i));
    end
end