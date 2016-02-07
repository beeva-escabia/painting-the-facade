function m = painting(file)

% File reading
fid = fopen(file);
dim = str2num(fgets(fid));
picture = textscan(fid, '%C' ,dim(2)); 
fclose(fid);

% Format and parse data
m = zeros(dim(1),dim(2));
for i = 1:dim(1)
    row = char(cellstr(picture{1}(i)));
    for j = 1:dim(2)
        if row(j) == '#'
            m(i,j) = 1;
        end
    end
end
  
end