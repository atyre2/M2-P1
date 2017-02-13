library(shiny)
library(markdown)

source("tabPanels.R", local=TRUE)

shinyUI(
    navbarPage("Nebraska's Pheasants",
    tabPanel("Introduction",
             withMathJax(),
             includeMarkdown("introduction.md"),
             value = "tP0"),
    tabPanel("Exponential Model", tP1, value = "tP1"), # end tabPanel "tp1"
    tabPanel("Logistic Model", tP2, value = "tP2"), # end tabPanel "tp2"    id = "panels",
    footer = div(br(),
                 img(src="R-UN_L4c_tag_4c.png"),
                 tags$a(href="http://snr.unl.edu/","Brought to you by the School of Natural Resources")
                 )
  ) # end navbarPage
) # end shinyUI

