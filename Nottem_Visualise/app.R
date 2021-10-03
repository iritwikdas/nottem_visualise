library(shiny)
library(xts)
library(randomcoloR)



ui <- fluidPage(
  fluidRow(wellPanel("Visualising Nottem data points with action button")),
  actionButton("goButton", "Plot the next point"),
  plotOutput("myPlot")
)

server <- function(input, output, session) {
  
  counter <- reactiveValues(countervalue = 1)
  observeEvent(input$goButton, {
    counter$countervalue <- counter$countervalue+1
  })
  
  output$myPlot <- renderPlot({
    
    data("nottem")
    nott_xts <- as.xts(nottem)
    
    #Creating an empty plot, on which we will later render our points
    plot.new()
    plot(1, type="n", xlab="", ylab="", xlim=c(1920,1940), ylim=c(30, 70))
    
    points(x = 1920 + counter$countervalue/12,
           y = nott_xts[counter$countervalue],
           pch = 21,
           bg = randomColor(),
           cex = 3)
  })
}

shinyApp(ui, server)
