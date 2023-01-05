function similarity = minhash(str1, str2, shingle_size, nhf, nbits)
    % Calculate the shingles for the two input strings
    shingles1 = str2shingles(str1, shingle_size);
    shingles2 = str2shingles(str2, shingle_size);
    
    % Create a counting Bloom filter for each string
    filter1 = BloomFilter(nbits,nhf);
    filter2 = BloomFilter(nbits,nhf);
    
    % Insert the shingles into the Bloom filters
    for i = 1 : length(shingles1)
        filter1 = filter1.insert(shingles1{i});
    end
    
    for i = 1 : length(shingles2)
        filter2 = filter2.insert(shingles2{i});
    end
    
    % Initialize a counter to track the number of equal shingles
    counter = 0;
    
    % Iterate over the shingles in the first string
    for i = 1 : length(shingles1)
        shingle = shingles1{i};
        
        % Check if the shingle is present in the second string
        multiplicity1 = filter1.count(shingle);
        multiplicity2 = filter2.count(shingle);
        if multiplicity1 > 0 && multiplicity2 > 0
            % If the shingle is present in both strings, increment the counter
            counter = counter + 1;
        end
    end
    
    % Calculate the Jaccard similarity
    similarity = counter / (length(shingles1) + length(shingles2) - counter);
end
