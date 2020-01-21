# fdaa5907

# Ethereum Price Index

This app show the actual Ethereum price and the chart of all Ethereum data. In addition it is possibile to run a forecast with the choosen number of observation.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Install the R package "devtools" if not installed

```
install.packages("devtools")
```

### Installing

Install the R package.

```
devtools::install_github('unimi-dse/fdaa5907')
```

Now the necessary libraries will be installed (if they are not already)
You can skip (enter 3) the updating of the packages. 

## Running the app

Load the package

```
require(ethereum)
```
If you want to check if the packages is correctly installed run:

```
testFun()
```
If it works, it will return:

```
[1] "Yes, it works!"
```

You can run the app with the command:

```
runFun()
```

## Built With

* [Shiny](https://shiny.rstudio.com/) - The app framework used


## Authors

* **Tommaso Pessina** - *Initial work* - (https://github.com/tommasopessina)
