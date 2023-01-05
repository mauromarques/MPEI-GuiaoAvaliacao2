bf = BloomFilter(10, 3);
for i = 1:1:129
    i
    bf = bf.insert('Madre');
end
bf
bf.count('Madre')
