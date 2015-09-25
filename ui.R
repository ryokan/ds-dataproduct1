## data product 1 
require(rmarkdown)

shinyUI(pageWithSidebar(
  headerPanel("Predicting MPG for an automobile model"),
  sidebarPanel(
    h3("Input parameters"),
    sliderInput('wt', 'Weight (ib/1000)', value = 3, min = 1, max = 5, step = 0.005),
    numericInput('cyl', "Number of cylinders", 4,  min = 4, max = 8, step = 2),
    radioButtons('am', "Transmission", choices = c("Automatic" = 0, "Manual" = 1)),
    textInput('hp', "HousePower (60 ~ 330)", value = "200"),
    h4("Usage Guide"), 
p("This application predicts MPG (Miles/Gallon) for a given automobile model.  
      Please input the parameters above and the predicted MPG will be shown in the right
  panel.  Scatter plot in the right bottom is the relationship between MPG and the weight, 
  shich is the most significant parameter to MPG.  The blue spot among green spots is
  the one you specified.")
  ),
  mainPanel(
    h3("Prediction Result"),
    h4("Input"),
   p("Weight = "), textOutput('wt'),
    p("Number of cylinders = "), textOutput('cyl'),
     p("Horsepower = "), textOutput('hp'),
     p("Transmission:"), textOutput('am'),
     h4("Prediction"),
 p("MPG = "), textOutput("mpg"),
    plotOutput('graph1')
  )
  
))