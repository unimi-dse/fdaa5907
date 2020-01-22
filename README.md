# fdaa5907

# Ethereum Price Index

This app show the actual Ethereum price and the chart of all Ethereum data. In addition it is possibile to run a forecast with the choosen number of observation.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Install the R package "devtools" if not installed

```
install.packages("devtools")
```

Install (if it are not already) and load the "shiny" package

```
install.packages("shiny")
library(shiny)
```


### Installing

Install the R package

```
devtools::install_github('unimi-dse/fdaa5907')
```

### Requisites

Load the package

```
require(ethereum)
```

Load the required library and automatically install (if they are not already) by run the function

```
installPack()
```

## Running the app

You can run the app with the command:

```
runFun()
```

### Documentation and Test

If you want to check if packages are installed properly, run:

```
testFun()
```

If it works, it will return:

```
[1] "Yes, it works!"
```

It's possible to see the documentation (how it works) of the developed functions, by typing:

```
?getEth()
?calculateRange()
?getPricePerc()
?server()
?setOutPricePerc()
```

## Built With

* [Shiny](https://shiny.rstudio.com/) - The app framework used


## Authors

* **Tommaso Pessina** - *Initial work* - (https://github.com/tommasopessina)
