## Create tabpanel objects here
## they should be named tP<i> where <i> is the
## index of the order they are created.
tP1 <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("tp1N0", "Initial population size", min  = 0, max = 20, step = 0.5, value = 15),
      sliderInput("tp1b0", "Per capita birth rate", min = 0, max = 1, step = 0.01, value = 0.2),
      sliderInput("tp1d0", "Per capita death rate", min = 0, max = 1, step = 0.01, value = 0.25)
    ),
    mainPanel(
      fluidRow(
        column(6,plotOutput("tp1popByTime")),
        column(6,plotOutput("tp1ratesByPop"))
      )
    )
  )
) # end fluidpage

tP2 <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("tp2N0", "Initial population size", min  = 0, max = 20, step = 0.5, value = 15),
      sliderInput("tp2b0", "Per capita birth rate when N=0", min = 0, max = 1, step = 0.01, value = 0.33),
      sliderInput("tp2b1", "Decline in b", min = -0.1, max = 0, step = 0.001, value = -0.06),
      sliderInput("tp2d0", "Per capita death rate when N=0", min = 0, max = 1, step = 0.01, value = 0.25),
      sliderInput("tp2d1", "Decline in d", min = 0, max = 0.1, step = 0.001, value = 0)
    ),
    mainPanel(
      fluidRow(
        column(6,plotOutput("tp2popByTime")),
        column(6,plotOutput("tp2ratesByPop"))
      )
    )
  )
) # end fluidpage
