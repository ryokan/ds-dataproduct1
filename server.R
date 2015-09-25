## Data Product 1
library(shinyapps)
require(shiny)
# require(rmarkdown)

library(datasets)
data(mtcars)
newmpg <- mean(mtcars$mpg)
mtcars2 <- mtcars
datanum <- dim(mtcars)[1]
mtcars2[datanum+1,] <- 0 # for the new data
mtcars2[, "color"] <- 3  # green
mtcars2[datanum+1, "color"] <- 4 # Blue

fit2<- lm(mpg ~ wt + cyl + hp + am, data=mtcars)

shinyServer(
  function(input, output) {
     output$wt <- renderPrint({input$wt})
     output$cyl <- renderPrint({input$cyl})
     output$hp <- renderPrint({input$hp})
     output$am <- renderPrint({ifelse ((input$am == 1), "Manual", "Automatic")})
     
     output$mpg <- renderText({
       mtcars2[datanum+1, c("wt", "cyl", "hp", "am")] <- c(as.numeric({input$wt}),
                                                           as.numeric({input$cyl}),
                                                           as.numeric({input$hp}),
                                                           as.numeric({input$am}))
       predict(fit2, newdata=mtcars2[datanum+1,])})
     
    output$graph1 <- renderPlot({
      mtcars2[datanum+1, c("wt", "cyl", "hp", "am")] <- c(as.numeric({input$wt}),
                                                          as.numeric({input$cyl}),
                                                          as.numeric({input$hp}),
                                                          as.numeric({input$am}))
      mtcars2[datanum+1, "mpg"] <- predict(fit2, newdata=mtcars2[datanum+1,])
      plot(mtcars2$wt, mtcars2$mpg, col = mtcars2$color,
           xlab = "Weight", ylab = "MPG", 
           main = "Relationship between car weight and MPG")
    })
  }
)
