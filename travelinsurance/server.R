function(input, output) { 
    output$plt1<- renderHighchart(plot1)
    output$plt2<- renderHighchart(plot2)
    output$plt3<- renderHighchart(plot3)
    output$tables = renderDataTable({travel})
    
}