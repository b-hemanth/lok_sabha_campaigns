# gov_1005_final_project
__Final Project for Gov 1005: Analysis of the 2019 Indian Lok Sabha Elections Campaigns__
## A Note on the Data
The csv file: https://drive.google.com/file/d/1cSUnWV-dQK0XgBfJGkhHJNX_6uc1JDgK/view?usp=sharing

### What is the data?
A mixed sample of the most popular and most recent **one hundred and eight thousand tweets** in English from the last three days (as of 20 March, 2019, 10:07 pm EST) on the Bharatiya Janata Party's #MainBhiChowkidar campaign.

This is one of the largest social media campaigns and was announced just 3-4 days before I scraped the data so the data captures much of the initial response


### Data Source
I scraped it myself wit the package `rtweet`. I used the following code:
 
`tweets <- search_tweets(`

 ` "Chowkidar OR #MainBhiChowkidar OR #Chowkidar", n = 100000, type = "mixed", retryonratelimit = TRUE, lang = "en")`

`x_tweets <- as_tibble(tweets)`

`x <- x_tweets %>%`

`clean_names()`

`write_as_csv(tweets, "twitter_data.csv")`

`x <- read_csv("twitter_data.csv", col_names = TRUE)`

