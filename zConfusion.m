function dctVector = zigzag(A, needNumCoefficient)

	if size(A, 1) ~= size(A, 2)
		display('Warning: your matrix should be square!');
		if size(A, 1) > size(A, 2)
			A = A(1:size(A, 2), 1:size(A, 2));
		else
			A = A(1:size(A, 1), 1:size(A, 1));
		end
	end
	
	if needNumCoefficient > (size(A, 1) * size(A, 2))
		needNumCoefficient = size(A, 1) * size(A, 2);
	end
	
	A = A';
	count = 1;    
	for dim_sum = 2 : (size(A, 1) + size(A, 2))
		if mod(dim_sum, 2) == 0
			for i = 1 : size(A, 1)
				if dim_sum - i <= size(A, 1) & dim_sum - i > 0
					dctVector(count) = A(i, dim_sum - i);
					count = count + 1;
				end
			end
		else
			for i = 1 : size(A, 1)
				if dim_sum - i <= size(A, 1) & dim_sum - i >0
					dctVector(count) = A(dim_sum - i, i);
					count = count + 1;
				end                   
			end   
		end
	end
	dctVector = dctVector(1:needNumCoefficient);
	dctVector = dctVector';
	
end