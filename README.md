# fdaa5907

# Ethereum Price Index

This app show the actual Ethereum price and the chart of all Ethereum data. In addition it is possibile to run a forecast with the choosen number of observation.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Installing

Install the R package "devtools" if not installed

```
install.packages("devtools")
```

Install the R package

```
devtools::install_github('unimi-dse/fdaa5907')
```

Load the package

```
require(ethereum)
```

### Documentation and Test


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
