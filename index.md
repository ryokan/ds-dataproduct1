---
title       : Creating Data Product Sample
subtitle    : predicting MPG for a given automobile model
author      : Yoshihiro Ueda
job         : student
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Overview

### Given Task

Create a Shiny application, such that
* has some form of input (widget: textbox, radio button, checkbox, …) 
* has ome operation on the ui input in sever.R 
* has some reactive output displayed as a result of server calculations
* includes enough documentation so that a novice user could use the application

### The Answer

Deleveloped an application which predict MPG (miles / gallon) from the given parameters. 
Parameter input uses several kinds of widget and the parameters are given to the model 
created by a machine learning algorithm. 
The prediction is shown in a text form and by a graphical form. 


--- .class #id 

## Method used: Linear Regression Model

First model to predict MPG uses the most parameter other than MPG and qsec (1/4 mile time), 
which is also a result paramter.  The best fit model can be derived using step.


```r
fit1 <- lm(mpg ~ .-qsec , data=mtcars)
best.fit <- step(fit1)
```

The best fit model uses the following three paaramters
* wt (Weight)
* cyl (number of cylinders)
* hp (Horsepower)

The model adopted here adds am (automatic transmission or manual transmission) 
to show a radio button wiget.

```r
fit2 <- lm(mpg ~ wt + cyl + hp + am, data=mtcars)
```

--- .class #id 

## Wiget used for input

Here the following four input mehods are used.

* Silder for wt (weight)
* Numeirc for cyl (numer of cylinders): 4 to 8 by step 2 resulting 4, 6 and 8.
* Radio Button for am (automatic/manual transmission)
* Text for hp (horsepower)


```r
    sliderInput('wt', 'Weight (ib/1000)', value = 3, min = 1, max = 5, step = 0.005)
    numericInput('cyl', "Number of cylinders", 4,  min = 4, max = 8, step = 2)
    radioButtons('am', "Transmission", choices = c("Automatic" = 0, "Manual" = 1))
    textInput('hp', "HousePower (60 ~ 330)", value = "200")
```

--- .class #id 

## Processing and output

The model fit2 is used for prediction (mpg) by a new set of parameters gathered from input.

```r
       newmpg <- predict(fit2, newdata=new)
```
Also the result is shown on the graph. The blue spot is the predicted one.

<img src="https://raw.githubusercontent.com/ryokan/ds-dataproduct1/master/screenshot.png" alt="screenshot" width = "400px">

