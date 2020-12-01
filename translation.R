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


