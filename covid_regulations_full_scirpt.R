



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

## Loading the Access Key
# Now you will load the Access Key you created into R
keyTable <- read.csv("accessKeys.csv", header = T) # accessKeys.csv == the CSV downloaded from AWS containing your Acces & Secret keys
AWS_ACCESS_KEY_ID <- as.character(keyTable$Access.key.ID)
AWS_SECRET_ACCESS_KEY <- as.character(keyTable$Secret.access.key)

# Activate
Sys.setenv("AWS_ACCESS_KEY_ID" = AWS_ACCESS_KEY_ID,
           "AWS_SECRET_ACCESS_KEY" = AWS_SECRET_ACCESS_KEY,
           "AWS_DEFAULT_REGION" = "eu-west-1")


## Doing the translation
# First we load the library
# AWS Translate
#install.packages("aws.translate", repos = c(getOption("repos"), "http://cloudyr.github.io/drat"))
library("aws.translate")

# Checking the length of each string
nchar(covid_regulations_hu)

# Since all of them together will be too long, I will create multiple elements that
# do not exceed the character limit of 5000 characters.
# I am using a special character ($) to collapse to be able to split it again later.

covid_regulations_to_translate_1 <- paste0(covid_regulations_hu[1:10], collapse = " $ ")
nchar(covid_regulations_to_translate_1)

covid_regulations_to_translate_2 <- paste0(covid_regulations_hu[11:23], collapse = " $ ")
nchar(covid_regulations_to_translate_2)

covid_regulations_to_translate_3 <- paste0(covid_regulations_hu[24:33], collapse = " $ ")
nchar(covid_regulations_to_translate_3)

# Now that I have strings that can be translated I will do so

covid_regulations_en_1 <- translate(covid_regulations_to_translate_1, from = 'hu', to = 'en')
covid_regulations_en_2 <- translate(covid_regulations_to_translate_2, from = 'hu', to = 'en')
covid_regulations_en_3 <- translate(covid_regulations_to_translate_3, from = 'hu', to = 'en')

# Now that we have all the regulations translated, we need to put them into one document

covid_regulations_en_complete <- paste0(c(covid_regulations_en_1,covid_regulations_en_2,covid_regulations_en_3), collapse = " $ ")
print(covid_regulations_en_complete)

# Now we need to split it into the different regulations.
# For this we will use the special character ($) that we have preset.

covid_regulations_en_final <- unlist(strsplit(covid_regulations_en_complete, split = ' $ ', fixed = TRUE))

print(covid_regulations_en_final)

write(covid_regulations_en_final, file = "/Users/Terez/OneDrive - Central European University/Data_Engeniering_03/Serverless_Rmds/Codes for Covid scrape/covid_regulations_en.txt")


## Trying to create the Polly
# AWS Polly
#install.packages("aws.polly", repos = c(getOption("repos"), "http://cloudyr.github.io/drat"))
#install.packages("tuneR") 
library("aws.polly")

# list available voices, to see the options
list_voices()

# Let us try a male and a female voice
# I am only using the first string so that the test is not too long
# Female
vec_1 <- synthesize(text = covid_regulations_en_final[1], voice = "Salli")
# Male
vec_2 <- synthesize(text = covid_regulations_en_final[1], voice = "Joey")

# Let's hear the tests
library("tuneR")
setWavPlayer("afplay") <- #execute this on a Mac
  play(vec_1)
play(vec_2)

# I decided to go with Joey for the final version
covid_regulations_verbalised_1 <- synthesize(text = covid_regulations_en_complete, voice = "Joey")
# Unfortunately Polly only allows for 1500 characters when verbalizing.
# Therefore this last code will not run.