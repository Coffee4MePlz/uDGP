function retval = PlotESave (Build)
  
       [nB,mB] = size(Build);
       figure(1)
       hold on
  %      scatter(plx,ply,'filled')
        Adj=ones(mB) - eye(mB);
        gplot(Adj,Build', '-o');
        set (get (gca, ("children")), "markersize", 13);
        title ("Plot");
        
  %Para salvar, mudar diretorio:     
         % saveas(1, "/home/guscafe/Dropbox/UFSC/PIBIC/Ciclo 2018e19/Algoritmo/Prints/Plot.jpg");
retval=0;
end
