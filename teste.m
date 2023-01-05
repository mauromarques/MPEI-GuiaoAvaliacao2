str1 = 'Borboleta';
str2 = 'tyborboletaetaupl';
shingle_size = 3;
nhf = 4;
nbits = 100
similarity = minhash(str1, str2, shingle_size, nhf, nbits)
