#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shiny)
library(UsingR)
library(plotly)



# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Exploring the Iris dataset"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
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
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        tabsetPanel(
            tabPanel("Plot", plotlyOutput("iris_plot")),
        tabPanel("Documentation", verbatimTextOutput("documentation"))
        ))
        
        
  )
))



