## Scrape the website
# Specifying the URL 
url <- 'https://koronavirus.gov.hu/aktualis'

# Reading the HTML code from the website
# You will need this for the scraping
webpage <- read_html(url)

# Using CSS selectors to scrape the rankings section
covid_regulations_hu_hdml <- html_nodes(webpage,'li')

# Converting the ranking data to text
covid_regulations_hu <- html_text(covid_regulations_hu_hdml)

print(covid_regulations_hu)O