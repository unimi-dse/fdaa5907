library(ggplot2)
library(scales)
library(Quandl)
library(dplyr)
library(readr)
library(forecast)
library(zoo)

eth <- Quandl("BITFINEX/ETHUSD", api_key="-GNJxjPntak8s-AxpM5o")

ethts <- Quandl("BITFINEX/ETHUSD", api_key="-GNJxjPntak8s-AxpM5o", type = "xts")

ggplot(eth, aes(x = eth$Date, y = eth$Last)) +
  labs(x = "Date", y = "Price") +
  geom_line() +
  scale_x_date(labels = date_format("%Y-%m-%d"))

#sm <- ma(eth$Last,order=12)
#lines(eth$date,sm,col="green")

startDF <- data.frame("Date"=eth$Date, "Price"=eth$Last)

smDF <- data.frame("Date"=eth$Date,"MA"=rollmean(startDF$Price, k = 13, fill = NA))

#arDF <- data.frame("Date"=eth$Date,"AR"=arima.sim(list(ar=c(0.5)),n=100,innov=eth$Price))

# Automated forecasting using an exponential model
fit <- ets(startDF$Price)
df1 <- data.frame("Date"=eth$Date,"fit"=fit)

# Automated forecasting using an ARIMA model00
#fit2 <- auto.arima(startDF$Price)
#df2 <- data.frame("Date"=eth$Date,"fit2"=fit2)

ggplot() + 
  geom_line(aes(x=Date, y=Price, colour="Ethereum price"), startDF) +  
  geom_line(aes(x=Date, y=MA, colour="Moving average"), smDF) +
  #(aes(x=Date, y=AR, colour="AR"), arDF) +
  geom_line(aes(x=Date, y=fit, colour="fit"), df1) 
  #geom_line(aes(x=Date, y=fit2, colour="fit2"), df2)
