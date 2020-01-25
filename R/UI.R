
'%>%'  <- magrittr::`%>%`

# Define UI for app
ui <- shiny::fluidPage(
  
  shinyjs::useShinyjs(),
  shinyalert::useShinyalert(),
  
  # App title
  shiny::titlePanel(shiny::HTML("<font color='red'><h1>Ethereum (Cryptocurrency) Price Index</h1></font>")),
  
  shiny::sidebarPanel(  
    
    shiny::fluidRow(
      
      shiny::h3("Actual Ether price: ",shiny::textOutput("price")),
   
      shiny::h4(shiny::textOutput("percent"))),
    
    shiny::fluidRow(shiny::actionButton("reload", "Reload"),
                    shiny::h5("Last update: ",shiny::textOutput("hour"))),
    
    shiny::fluidRow(shiny::selectInput(inputId = "option", shiny::h3("Select option"), 
                choices = list("Price" = 1, "Moving Average" = 2,
                               "Forecast" = 3), selected = 1)),
    shiny::sliderInput("slider1", shiny::h4("Number of observations (only for forecast)"),
                min = 10, max = 500, value = 200),
    
  ),
  
  # Main panel for displaying outputs
  shiny::mainPanel(
      
      # Output: plot
    shiny::plotOutput(outputId = "distPlot")%>%shinycssloaders::withSpinner(color="#0dc5c1"),
    
    shiny::HTML('<style type="text/css">
                  .column {
                    float: left;
                    width: 50%;
                  }

                  .row:after {
                    content: "";
                    display: table;
                    clear: both;
                  }
                  </style>

    <br>
                  <div class="row">
                    <div class="column">
                        <h3>Tommaso Pessina</h3>
                         <h4> 
                          BC. in Computer Science @ UNIUPO <br>
                          MSc. student of Data Science & Economics @ UNIMI
                        </h4>
                        <a href="https://www.linkedin.com/in/tommaso-pessina-754960181/">
                          <img border="0" alt="linkedin" src="https://i0.wp.com/www.accademiafelicita.it/wp-content/uploads/2013/10/official_logo_linkedin.png?fit=900%2C900&ssl=1" width="50" height="50">
                        </a>
                        <a href="https://github.com/tommasopessina?tab=repositories">
                          <img border="0" alt="github" src="https://www.pikpng.com/pngl/m/256-2562286_github-logo-png-github-clipart.png" width="50" height="50">
                        </a>
                      </div>
                    <div class="column">
                      <img src="https://media-exp1.licdn.com/dms/image/C4E03AQF6xbn5UjLSGA/profile-displayphoto-shrink_200_200/0?e=1585180800&v=beta&t=-oEjkrC0JvrKIXHe8npijNRYhJq5EyJz8hKDcUustrs" alt="photo" height="120" width="120">
                    </div>
                  </div>
                ')
      
  )
  
)
