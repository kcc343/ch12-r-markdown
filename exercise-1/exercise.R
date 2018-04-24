# load relevant libraries
library(httr)
library(jsonlite)

# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!

source("apikey.R")

# Create a variable `movie.name` that is the name of a movie of your choice.

movie_name <- "Frozen"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie.name` variable as the search query!

base_uri <- "https://api.nytimes.com/svc/movies/v2"
resource <- "/reviews/search.json"
uri_full <- paste0(base_uri, resource)
query_params <- list(q = movie_name, apikey = nty_apikey)

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON

response <- GET(uri_full, query = query_params)
body <- content(response, "text")
nyt_movie_reviews <- fromJSON(body)

# What kind of data structure did this produce? A data frame? A list?

class(nyt_movie_reviews)

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
names(nyt_movie_reviews)
names(nyt_movie_reviews$results)

# Flatten the movie reviews content into a data structure called `reviews`

reviews <- flatten(nyt_movie_reviews$results)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables

first_review <- reviews[1, ]
headline <- first_review$headline
summary <- first_review$summary_short
link <- first_review$link.url

# Create a list of the three pieces of information from above. 
# Print out the list.
review <- list(headline = headline, summary = summary, link = link)