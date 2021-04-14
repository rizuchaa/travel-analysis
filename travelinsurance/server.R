function(input, output) { 
    output$map<- renderPlotly(map2)
    output$plt1<- renderPlotly(plot1)
    output$plt2<- renderPlotly(plot2)
    output$plt3<- renderPlotly(plot3)
    output$tables = renderDataTable({travel})
    
}