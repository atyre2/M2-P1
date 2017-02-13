library(shiny)
library(ggplot2)

pheasants <- read.csv("data/NE_pheasant_1951-2004.csv")

#testing
# input <- list(tp1b0 = 0.2, tp1d0 = 0.25, tp1N0 = 15,
#               tp2b0 = 0.2, tp2d0 = 0.25, tp2b1 = -0.05, tp2d1 = 0, tp2N0 = 15)

shinyServer(function(input, output, session) {
  basePopTime <- ggplot(pheasants,aes(x=Year,y=Statewide)) + 
    geom_point()
  
  expModel <- reactive({
    b0 <- input$tp1b0
    d0 <- input$tp1d0
    r <- b0 - d0
    t <- 1950:2004 - 1950
    data.frame(Year = 1950:2004,
               N = input$tp1N0*exp(r*t))
  })
  
  logisticModel <- reactive({
    b0 <- input$tp2b0
    d0 <- input$tp2d0
    b1 <- input$tp2b1
    d1 <- input$tp2d1
    r <- b0 - d0
    K <- r/(d1-b1)
    N0 <- input$tp2N0
    t <- 1950:2004 - 1950
    data.frame(Year = 1950:2004,
               N = N0*K/(N0 + (K-N0)*exp(-r*t)))
  })

  output$tp1popByTime <- renderPlot(
    basePopTime + 
      geom_line(data=expModel(), 
                mapping = aes(x = Year, y = N))
  )
  
  output$tp1ratesByPop <- renderPlot({
    rates_df <- data.frame(rate = c("Birth", "Death"),
                           intercepts = c(input$tp1b0, input$tp1d0),
                           slopes = 0,
                           N = c(0,20))
    ggplot(rates_df, aes(x = N, y=intercepts)) +
      geom_abline(aes(intercept = intercepts, slope = slopes, linetype = rate)) + 
      ylim(0,0.5) + xlim(0,20) +
      ylab("per capita rates") +
      xlab("Population density")
  })
  
  output$tp2popByTime <- renderPlot(
    basePopTime + 
      geom_line(data=logisticModel(), 
                mapping = aes(x = Year, y = N))
  )
  output$tp2ratesByPop <- renderPlot({
    rates_df <- data.frame(rate = c("Birth", "Death"),
                           intercepts = c(input$tp2b0, input$tp2d0),
                           slopes = c(input$tp2b1, input$tp2d1),
                           N = c(0,20))
    ggplot(rates_df, aes(x = N, y=intercepts)) +
#      geom_point() + 
      geom_abline(aes(intercept = intercepts, slope = slopes, linetype = rate)) + 
      ylim(0,0.5) + xlim(0,20) +
      ylab("per capita rates") +
      xlab("Population density")
    
  })
  
})
