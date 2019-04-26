#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(UsingR)
library(plotly)


shinyServer(function(input, output) {
    iris_subset <- reactive({
        df <- subset(iris, (iris$Sepal.Length > input$slider[1]) & 
                        (iris$Sepal.Length < input$slider[2]))
        return(df)
    })
    
    output$iris_plot <- renderPlotly({
        
        validate(
            need(nrow(iris_subset())>0, 
                 paste("The chosen range of Sepal Length does not contain any",
                       "datapoints.",
                       "Please select a larger range of Sepal Length"))
        )
        
        # Calculate the line:
        fv <- iris_subset() %>% 
            lm(iris_subset()$Petal.Length ~ iris_subset()$Sepal.Length,.) %>% 
            fitted.values()
        
        # Make the base 
        plot <- plot_ly(x = ~iris_subset()$Sepal.Length, 
                        y = ~iris_subset()$Petal.Length, mode = "markers") %>%
            
            
            layout(title = "Scatterplot of Sepal Length and Petal Length",
                      xaxis = list(title = "Sepal Length"),
                      yaxis = list(title = "Petal Length", 
                                   range= c(0.5, 8))) %>%
            layout(showlegend = T)
        
        # Add color if show_species is true (1):
        if(input$showspecies == TRUE){
            plot <- add_markers(plot, 
                                marker = list(color= factor(
                                    iris_subset()$Species, 
                                    labels = c("red","purple", "blue"))), 
                                split = ~iris_subset()$Species)
        }
        else{
            plot <- add_markers(plot, y = ~iris_subset()$Petal.Length, 
                                name='All species')
        }
        
            
        # Add the line if the checkbox for showline is checked:
        if(input$showline == TRUE){
            plot <- add_trace(plot, x = ~iris_subset()$Sepal.Length, y = fv, 
                              mode = "lines", color='green',
                              marker = list(color = 'red', opacity=0), 
                              name = 'Regression line')}
        plot
    })
    
    output$documentation <- renderText({
        paste("Supporting documentation:\nHow to get started using this",
        "application.\nIn the plot tab, you will find the scatterplot with",
        "on the x axes the Sepal length and on the Y axes the Petal length",
        "of several flower species. Start exploring the relationship between",
        "Sepal Length and Petal length by chosing different ranges of the",
        "Sepal Length and see the interactive graph changing based on your",
        "input. In addition, you can choose to show the species in the",
        "interactive graph with different colors by clicking the checkbox",
        "'Show species'. Click the checkbox 'show regression line' to see",
        "the regression line plotted in the interactive graph.",
        "\n\nThe data:\nThis famous (Fisher's or Anderson's) iris data set gives",
        "the measurements in centimeters of the variables sepal length and",
        "width and petal length and width, respectively, for 50 flowers from",
        "each of 3 species of iris. The species are Iris setosa, versicolor,",
        "and virginica.")
    })
    
})
