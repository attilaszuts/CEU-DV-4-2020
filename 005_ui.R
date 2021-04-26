

#https://shiny.rstudio.com/articles/layout-guide.html



library(shiny)
library(jsonlite)
library(data.table)
library(httr)
library(rtsdata)
library(DT)
library(TTR)
library(plotly)
library(shinythemes)
library(shinydashboard)



source('000_functions.R')

# base --------------------------------------------------------------------


ui <- fluidPage(
  uiOutput('my_ticker'),
  dateRangeInput('my_date',label = 'Date', start = '2018-01-01', end = Sys.Date()),
  dataTableOutput('my_data'),
  div(plotlyOutput('data_plot', width = '60%', height='800px'),align="center")
  
)

server <- function(input, output) {
  sp500 <-get_sp500()
  
  output$my_ticker <- renderUI({
    selectInput('ticker', label = 'select a ticker', choices = setNames(sp500$name, sp500$description), multiple = FALSE)
  })
  
  
  my_reactive_df <- reactive({
    df<- get_data_by_ticker_and_date(input$ticker, input$my_date[1], input$my_date[2])
    return(df)
  })
  
  
  # # go to https://rstudio.github.io/DT/shiny.html
  output$my_data <- DT::renderDataTable({
    my_render_df(my_reactive_df())
  })
  
  
  output$data_plot <- renderPlotly({
    get_plot_of_data(my_reactive_df())
  })
  
  
}

shinyApp(ui = ui, server = server)



