function similarities = jaccardSimillarity(signatures, id)
    % Signatures of current user
    signatures1 = signatures(:,id);
    % Number of hash functions
    nhf = height(signatures1);
    % array for similarities
    similarities = zeros(2, length(signatures));
    % Iterate over the users
    for j = 1 : length(signatures)
        if j == id
            % Doesnt compare the user to itself
            continue
        end
        % Signature of another user
        signatures2 = signatures(:,j);
        % Calculate the Jaccard similarity
        similarity = sum(signatures2(:) == signatures1(:)) / nhf;
        similarities(1,j) = j;
        similarities(2,j) = similarity;
    end
    % Sort the array in crescent order of the similarity
    [~, order] = sort(similarities(2,:));
    similarities = similarities(:,order);
end