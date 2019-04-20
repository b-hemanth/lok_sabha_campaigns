#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(readr)
library(ggthemes)
library(ggplot2)
# temp <- read_csv("twitter_data.csv") %>% 
#   select(created_at, text, favourites_count, retweet_count) %>% 
#   # Convert text to lower text
#   mutate(text = tolower(text))
# temp2 <- temp %>% 
#   arrange(desc(favourites_count)) %>% 
#   top_n(50)
# write_csv(temp2, "data.csv")

data <- read_csv(
  "data.csv",
  cols(
    created_at = col_datetime(format = ""),
    text = col_character(),
    favourites_count = col_double(),
    retweet_count = col_double()
  ),
  col_names = TRUE
  )

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Lok Sabha Campaigns Analysis"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         radioButtons("time",
                     "Time Posted:", unique(data$created_at))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          tabPanel("Retweets", 
                   plotOutput("rtPlot")),
          tabPanel("Favourites",
                   plotOutput("favtPlot"))
        )
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$rtPlot <- renderPlot({
     region_subset <- data %>% filter(!is.na(created_at), created_at == input$created_at)
     ggplot(region_subset, aes(x = created_at, y = retweet_count)) +
       geom_col() +
       geom_point() +
       theme_wsj() + 
       scale_color_wsj() +
       labs(
         title = "When the BJP IT Cells Strike Twitter* —
         Retweet Count for Selected Time",
         subtitle = "The Indian elections see bot tweeting as a tool to 
         make messages popular: when in the day were these bots deadliest?",
         source = "Data scraped from Twitter; 
         *represents a particular sample, 
         details @https://github.com/b-hemanth/lok_sabha_campaigns",
         x = "Time and Day",
         y = "Retweets"
       )
   })
   
   output$favtPlot <- renderPlot({
     region_subset <- data %>% filter(!is.na(created_at), created_at == input$created_at)
     ggplot(region_subset, aes(x = created_at, y = favourites_count)) +
       geom_col() +
       geom_point() +
       theme_wsj() + 
       scale_color_wsj() +
       labs(
         title = "When the BJP IT Cells Strike Twitter* —
         Favourites Count for Selected Time",
         subtitle = "The Indian elections see bot tweeting as a tool to 
         make messages popular: when in the day were these bots deadliest?",
         source = "Data scraped from Twitter; 
         *represents a particular sample, 
         details @https://github.com/b-hemanth/lok_sabha_campaigns",
         x = "Time and Day",
         y = "Favourites"
       )
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

