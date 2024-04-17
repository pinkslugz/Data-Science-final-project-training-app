wages=read.csv("wages_by_education.csv")
library(shiny)
library(ggplot2)
library(tidyr)
library(tidyverse)
ui <-fluidPage(
  column(12,checkboxGroupInput("variable", "Variables to show:",
    colnames(wages))),
  column(12,plotOutput("plot1", click="plot_click")),
  #column(12,verbatimTextOutput("info"))
)
server <-function(input, output, session) {
  output$plot1<- renderPlot({
    df <- wages %>%
      select(input$variable) %>%
      gather(key="variable", value="value", -year)
    ggplot(df, aes(x=year, y=value)) +
      geom_line(aes(color=variable, linetype = variable))
  #output$info <-renderText({
    #paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
  #})
  })
}
shinyApp(ui, server)
