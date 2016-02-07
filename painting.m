function commands = painting(m)

tam = size(m);
ncommand = 1;

for i = 1:tam(1) 
    indIzq = -1;
    for j = 1:tam(2)
        if m(i,j) == 1 && indIzq == -1
            indIzq = j;
        elseif m(i,j) == 0 && indIzq > -1
            commands{ncommand,1} = 'PAINT_LINE';
            commands{ncommand,2} = i - 1;
            commands{ncommand,3} = indIzq - 1;
            commands{ncommand,4} = i - 1;
            commands{ncommand,5} = j - 1 - 1;
            indIzq = -1;
            ind = -1;
            
            ncommand = ncommand + 1;
        end
    end
    if indIzq > -1
        commands{ncommand,1} = 'PAINT_LINE';
        commands{ncommand,2} = i - 1;
        commands{ncommand,3} = indIzq - 1;
        commands{ncommand,4} = i - 1;
        commands{ncommand,5} = tam(2) - 1;
        ncommand = ncommand + 1;
    end
end

%Escritura del fichero de comandos
fileID = fopen('celldata.dat','w');

fprintf(fileID,'%d \n',size(commands,1));

formatSpec = '%s %d %d %d %d \n';
[nrows,ncols] = size(commands);
for row = 1:nrows
    fprintf(fileID,formatSpec,commands{row,:});
end
fclose(fileID);

end