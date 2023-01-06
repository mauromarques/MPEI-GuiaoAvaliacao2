function similarities = jaccardSimillarity(signatures, id)

    signatures1 = signatures(:,id);
    nhf = height(signatures1);
    similarities = zeros(2, length(signatures));
    % Iterate over the users
    for j = 1 : length(signatures)
        if j == id
            continue
        end

        signatures2 = signatures(:,j);
        % Calculate the Jaccard similarity
        similarity = sum(signatures2(:) == signatures1(:)) / nhf;
        similarities(1,j) = j;
        similarities(2,j) = similarity;
    end

    [~, order] = sort(similarities(2,:));
    similarities = similarities(:,order);
end