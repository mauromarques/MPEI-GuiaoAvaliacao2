function similarities = jaccardSimillarity(signatures, id)

    signatures1 = signatures(:,id);
    nhf = height(signatures1);
    similarities = zeros(2, length(signatures));
    % Iterate over the users
    for j = 1 : length(signatures)
        if j == id
            continue
        end
        % Iterate over the rows of the signature matrices
        signatures2 = signatures(:,j);
        % Initialize a counter to track the number of equal MinHash values
        %counter = 0;
        %for i = 1 : nhf
        %    if j~= id
        %       % Compare the MinHash values for the two sets
        %        if signatures1(i) == signatures2(i)
        %            % If the values are equal, increment the counter
        %            counter = counter + 1;
        %        end
        %    end
        %end
        % Calculate the Jaccard similarity
        similarity = sum(signatures2(:) == signatures1(:)) / nhf;
        similarities(1,j) = j;
        similarities(2,j) = similarity;
    end

    [~, order] = sort(similarities(2,:));
    similarities = similarities(:,order);
end