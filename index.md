---
title       : A Shiny Application
subtitle    : Part of the Course Project Shiny Application and Reproducible Pitch
author      : idejong
job         : 
font-family : 'Arial'
css         : custom.css
framework   : flowtime   # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
output      : ioslides_presentation
---



<section style="text-align:center;">
# A Shiny Application
### Part of the Course Project Shiny Application and Reproducible Pitch
##### Author: idejong

---
## Introduction 
As part of the course project of the Developing Data Products course at Coursera, a Shiny Application was developed in R.

- This shiny application aims to eneable the user to explore the iris dataset, more particularly the relationship between Sepal Length and Petal Length. 
- The Shiny Application can be accessed with the link:  https://idejong.shinyapps.io/cp3_shinyapp/
- This presentation was developed using the package slidify in R and can be accessed at Github using the link:

---
## The data
This famous (Fisher's or Anderson's) iris data set gives the measurements in centimeters of the variables sepal length and width and petal length and width, respectively, for 50 flowers from each of 3 species of iris. The species are Iris setosa, versicolor and virginica.


```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```




---
## Exploring the Iris dataset with a Shiny Application
The shiny application aims to eneable the user to explore the iris dataset, more particularly the relationship between Sepal Length and Petal Length. The user can opt to show the species as well as the regression line, and play around with different ranges of the Sepal Length. 

An example of the interactive graph in the application is shown below.



<iframe width="800" height="400" src="plot.html"></iframe>

---
## How the application works
The application presents an interactive graph. The user is able to provide input that is used as an input for the parameters of the graph. The user input is collected in the ui.r script and used in the server.r script as a boolean variable indicating whether the user opted to show the species and whether the user opted to show the regression line.

The code in the User Interface (ui.R) responsible for this collecting this input is as follows: 

```r
sidebarPanel(
        sliderInput("slider", 
                    label = h4("Choose the range of variable Sepal Length"), 
                    min = min(iris$Sepal.Length), 
                    max = max(iris$Sepal.Length), 
                    value = c(min(iris$Sepal.Length), max(iris$Sepal.Length))),
        
        checkboxInput(inputId='showspecies', label="Show species", 
                      value = FALSE),

        checkboxInput(inputId='showline', label="Show regression line", 
                      value = FALSE)
    )
```
