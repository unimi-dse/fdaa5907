#' Create a class for get the returned value of the function getPricePerc
setClass(Class="pricePerc",
         representation(
           price="character",
           perc="character"
         )
)

#' Define the server logic
#' #'
server <- function(input, output, session) {
  
  tryCatch(
     expr = {
        p <- getPricePerc()
        eth <- getEth()
        setOutPricePerc(p@price,p@perc, output)
     },
     error = function(e){ 
          shinyalert::shinyalert("Error!", "Data not retrived.", type = "error") #Show a pop-up message 
     },
     warning = function(w){
        shinyalert::shinyalert("Warning!", "Something goes wrong.", type = "warning") #Show a pop-up message 
     }
  )

  shiny::observe({
    shinyjs::toggleState(id = "slider1", condition = input$option == 3)
  })
  
  # Reload the data when the user click on a "relaod" button
  shiny::observeEvent(input$reload, {
    tryCatch(
     expr = {
      eht <- getEth()
      p <- getPricePerc()
      setOutPricePerc(p@price,p@perc,output)
     },
      error = function(e){ 
        shinyalert::shinyalert("Error!", "Data not retrived.", type = "error") #Show a pop-up message 
      },
       warning = function(w){
        shinyalert::shinyalert("Warning!", "Something goes wrong.", type = "warning") #Show a pop-up message 
       }
    )
    shinyalert::shinyalert("Okay!", "Data updated correctly.", type = "success") #Show a pop-up message 
  })
  
  output$distPlot <- shiny::renderPlot({
    
    if(input$option==1){
      ggplot2::ggplot(eth, ggplot2::aes(x = eth$Date, y = eth$Last)) +
        ggplot2::labs(x = "Date", y = "Price", title = "Ether Price Chart", subtitle = "Daily data") +
        ggplot2::geom_line() +
        ggplot2::scale_x_date(labels = scales::date_format("%Y-%m-%d"))+ 
        ggplot2::theme(plot.title = ggplot2::element_text(face = "bold"))
    }
    
    else if(input$option==2){
      smDF <- data.frame("Date"=eth$Date,"MA"=zoo::rollmean(eth$Last, k = 13, fill = NA))
      ggplot2::ggplot() + 
        ggplot2::labs(x = "Date", y = "Price",title = "Moving Average Chart", subtitle = "Daily data") + 
        ggplot2::geom_line(ggplot2::aes(x=eth$Date, y=eth$Last, colour="Ether price"), eth) +  
        ggplot2::geom_line(ggplot2::aes(x=Date, y=MA, colour="Moving average"), smDF) + 
        ggplot2::theme(plot.title = ggplot2::element_text(face = "bold"))
    }
    else if(input$option==3){
      obs <- input$slider1
      end <- nrow(eth)
      start <- calculateRange(obs,end)
      ts1 <- stats::ts(eth$Last[start:end], start = 1, frequency = 1, class = "ts")
      plot(forecast::forecast(forecast::auto.arima(ts1)), sub = paste("Forecast with ",obs," observation"))
    }
    else{
      shinyalert::shinyalert("Error!", "Input option not defined.", type = "error")
    }
  })
}
