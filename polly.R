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



