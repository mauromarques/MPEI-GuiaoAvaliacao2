classdef BloomFilter
    properties
        n=0
        k=0
        bits=[]
        nElements=0
    end
    methods

        % INIT ------------------------
        function obj = BloomFilter(nInput, kInput)
            obj.n = nInput;
            obj.k = kInput;
            obj.bits = zeros(1, nInput);
        end
        
        % INSERT -----------------------
        function obj = insert(obj, toInsert)
            str = toInsert;
            for i = 1 : obj.k
                str = [str num2str(i)];
                hash = string2hash(str);
                idx = mod(hash, obj.n) +1;
                obj.bits(idx) = obj.bits(idx) + 1;
            end
            obj.nElements = obj.nElements + 1;
        end

        % EXISTS -----------------------
        function returnValue = exists(obj, toCheck)
            returnValue = True;
            str = toCheck;
            for i = 1:obj.k
                str = [str num2str(i)];
                hash = string2hash(str);
                idx = mod(hash, obj.n) +1;
                returnValue = (obj.bits(idx) > 0) && returnValue;
            end
        end
        
        % COUNT -------------------------
        function minimum = count(obj, element)
            % Determines the multiplicity of an element using the "minimum selection" algorithm.
            str = element;
            minimum = 0;
            for i = 1 : obj.k
                str = [str num2str(i)];
                hash = string2hash(str);
                idx = mod(hash, obj.n) +1;
                value = obj.bits(idx);
                if i == 1
                    minimum = value;
                end
                if value < minimum
                    minimum = value;
                end
            end
        end
    end
end
