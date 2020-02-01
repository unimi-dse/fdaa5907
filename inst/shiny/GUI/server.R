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
  
  #try to retrive the data. If something goes wrong show a message
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
  
  #Enable or disable the state of the input slider for the input number of observation for the forecast
  shiny::observe({
    shinyjs::toggleState(id = "slider1", condition = input$option == 3)
  })
  
  # Reload the data when the user click on a "relaod" button. Show a pop-up message as a feedback for the user
  shiny::observeEvent(input$reload, {
    tryCatch(
       expr = {
          eht <- getEth() #Get the total index values 
          p <- getPricePerc() #Get the actual price and percentage of change of ether
          setOutPricePerc(p@price,p@perc,output) #set the data in the output
       },
        error = function(e){ 
          shinyalert::shinyalert("Error!", "Data not retrived.", type = "error")
        },
         warning = function(w){
          shinyalert::shinyalert("Warning!", "Something goes wrong.", type = "warning")
         }
      )
      shinyalert::shinyalert("Okay!", "Data updated correctly.", type = "success")
  })
  
  #The plot with the 3 types of charts
  output$distPlot <- shiny::renderPlot({
    
    #Case of price index only
    if(input$option==1){
      ggplot2::ggplot(eth, ggplot2::aes(x = eth$Date, y = eth$Last)) +
        ggplot2::labs(x = "Date", y = "Price", title = "Ether Price Chart", subtitle = "Daily data") +
        ggplot2::geom_line() +
        ggplot2::scale_x_date(labels = scales::date_format("%Y-%m-%d"))+ 
        ggplot2::theme(plot.title = ggplot2::element_text(face = "bold"))
    }
    
    #Case of price index + moving average
    else if(input$option==2){
      smDF <- data.frame("Date"=eth$Date,"MA"=zoo::rollmean(eth$Last, k = 13, fill = NA))
      ggplot2::ggplot() + 
        ggplot2::labs(x = "Date", y = "Price",title = "Moving Average Chart", subtitle = "Daily data") + 
        ggplot2::geom_line(ggplot2::aes(x=eth$Date, y=eth$Last, colour="Ether price"), eth) +  
        ggplot2::geom_line(ggplot2::aes(x=Date, y=MA, colour="Moving average"), smDF) + 
        ggplot2::theme(plot.title = ggplot2::element_text(face = "bold"))
    }
    
    #Case of forecast
    else if(input$option==3){
      obs <- input$slider1 #take the number of observation given in input (in the slider)
      end <- nrow(eth) #Calculate the total number of observation
      start <- calculateRange(obs,end) #the range of the observation is the last given obs
      ts1 <- stats::ts(eth$Last[start:end], start = 1, frequency = 1, class = "ts")
      plot(forecast::forecast(forecast::auto.arima(ts1)), sub = paste("Forecast with ",obs," observation"))
    }
    else{
      #In case of an error show a popup message for the user
      shinyalert::shinyalert("Error!", "Input option not defined.", type = "error")
    }
  })
}
