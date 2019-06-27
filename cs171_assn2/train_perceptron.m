function w = train_perceptron(input_x, output_y, w_init)
w = zeros(size(input_x,2),1); %creates w with input_x's rows x 1 matrix
w_init = ones(size(input_x,2),1)*rand; % initializes w_init with random numbers [0,1]
for i = 1:size(input_x,2) %iterates through rows
     output_y = zeros(size(input_x,2),1); %creates an output y with same rows
     for j = 1:size(input_x,2) %for each row
          if input_x(j,11) == 2 % benign is pos
              num = 1;
          else 
              num = -1; % malignant is neg
          end
          output_y(j) = sign(num); % produces a sign
          w(j,1) = w_init(j,1)*input_x(j,1)* output_y(j); % produces that in w matrix
     end
end

end