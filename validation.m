function success = validation(fileSolve, filePainting)


% File Solve reading
fid = fopen(fileSolve);
dim = str2num(fgets(fid));
lines = textscan(fid, '%s' ,dim(1), 'Delimiter','\n');
fclose(fid);

paint = paintToMatrix(filePainting);
solution = zeros(size(paint));

% Rellana la soluci?n con los comandos del fichero
for i = 1:dim(1)
    line = strsplit(lines{1}{i});
    if strcmp(line(1),'PAINT_SQUARE')
        fila = str2num(cell2mat(line(2)));
        columna = str2num(cell2mat(line(3)));
        lado = str2num(cell2mat(line(4)));

        for f = fila - lado + 1 : fila + lado + 1
            for c = columna - lado + 1 : columna + lado + 1
                solution(f,c) = 1;
            end
        end
    elseif strcmp(line(1),'PAINT_LINE')
        filastart = str2num(cell2mat(line(2)));
        columnastart = str2num(cell2mat(line(3)));     
        filaend = str2num(cell2mat(line(4)));
        columnaend = str2num(cell2mat(line(5)));        
        
        for f = filastart + 1 : filaend + 1
            for c = columnastart + 1 : columnaend + 1
                solution(f,c) = 1;
            end
        end
        
    elseif strcmp(line(1),'ERASE_CELL')
        fila = str2num(cell2mat(line(2)));
        columna = str2num(cell2mat(line(3)));
        solution(fila + 1,columna + 1) = 0;
    else
        disp('Invalid command');
    end
end

% Compara ambas matrices si son iguales
success = isequal(solution, paint);

end
