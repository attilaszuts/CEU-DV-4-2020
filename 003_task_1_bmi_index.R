

library(shiny)

source('000_functions.R')

ui <- fluidPage(
  
  # Application title
  titlePanel("BMI calculator"),
  sliderInput('weight', label = 'Your weight(kg)', min = 0, max = 130,step = 1, value = 65),
  sliderInput('height', label = 'Your height(cm)', min = 100, max = 250, value = 150),
  br(),
  verbatimTextOutput('bmi_number_text'),
  h2('Based on your BMI You are:'),
  textOutput('bmi_text'),
  actionButton('btn', 'calculate')
  
  #
  
)
# there are different solutions for the server side below

# basic -------------------------------------------------------------------

server <- function(input, output) {

  output$bmi_number_text <- renderPrint({
    return(paste0('Your BMI is: ', as.character(   round(input$weight / ( ((input$height)/100)^2)  ,2)   )  ))
  })

  output$bmi_text <- renderText({
    get_bmi_by_index_number(round(input$weight / ( ((input$height)/100)^2)  ,2))
  })

}


# with reactive value -----------------------------------------------------

# server <- function(input, output) {
#   bmi_index <- reactive({
#     round( (input$weight / (input$height/100*input$height/100)), 2) 
#   })
#   
#   
#   output$bmi_number_text <- renderPrint({
#     return(paste0('Your BMI is: ', bmi_index()  ))
#   })
#   
#   output$bmi_text <- renderText({
#     get_bmi_by_index_number(bmi_index() )
#   })
#   
# }


# with button -------------------------------------------------------------
#
# server <- function(input, output) {
#   
#   bmi_index <- reactive({
#     round( (input$weight / (input$height/100*input$height/100)), 2) 
#   })
#   
#   observeEvent(input$btn,{
#     bmi_index <- round( (input$weight / (input$height/100*input$height/100)), 2) 
#     
#     output$bmi_number_text <- renderPrint({
#       return(paste('Your BMI index is: ',   bmi_index    ) )
#     })
#     
#     output$bmi_text <- renderText({
#       get_bmi_by_index_number( bmi_index  )
#     })
#   })
#   
# }
  


# Run the application 
shinyApp(ui = ui, server = server)

