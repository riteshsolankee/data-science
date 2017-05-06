## how to use text data to build word clouds in R
## We will use a dataset containing around 200k Jeopardy questions
## We will require three packages for this: tm, SnowballC, and wordcloud

library(tm) ## Text Mining Packages
## An R interface to the C libstemmer library that implements Porter's word stemming algorithm for 
## collapsing words to a common root to aid comparison of vocabulary. Currently supported languages 
## are Danish, Dutch, English, Finnish, French, German, Hungarian, Italian,
## Norwegian, Portuguese, Romanian, Russian, Spanish, Swedish and Turkish
library(SnowballC) ## Snowball stemmers based on the C libstemmer UTF-8 library 
library(wordcloud)
setwd("/Users/ritesh/pad-datascience/R/")
questions = read.csv("dataVisualization/data/JEOPARDY_10.csv", stringsAsFactors = FALSE)

library(dplyr)
questions %>%
  group_by(Category) %>%
  tally() %>% 
  arrange(desc(n))


View(questions)
## The main structure for managing documents in tm is a so-called Corpus, representing a collection of text
## documents. A corpus is an abstract concept, and there can exist several implementations in parallel. The
## default implementation is the so-called VCorpus (short for Volatile Corpus) which realizes a semantics as known
## from most R objects: corpora are R objects held fully in memory.
## Another implementation is the PCorpus which implements a Permanent Corpus
## semantics, i.e., the documents are physically stored outside of R (e.g., in a database), corresponding R objects
## are basically only pointers to external structures, and changes to the underlying corpus are reected to all R
## objects associated with it.
## 'tm' provides aset of predefined sources, e.g., DirSource, VectorSource, or DataframeSource, which handle a directory, a vector
## interpreting each component as document, or data frame like structures (like CSV files), respectively.
## First we need to create a Corpus. "Corpus" is a collection of text documents. 
## A vector source interprets each element of the vector x as a document.
## getSources()- lists available sources
question_corpus = Corpus(VectorSource(questions$Question))

## details are displayed with inspect()
inspect(question_corpus[[997]])
meta(question_corpus[[997]])
## A character representation of a document is available via as.character() which is also used when inspecting a document:
lapply(question_corpus[1:2], as.character)

############### - Transformations - #############
## Once we have a corpus we typically want to modify the documents in it, e.g., stemming, stopword removal, et cetera.
## Transformations are done via the tm_map() function which applies (maps) a function to all elements of the corpus.
## Convert corpus to lower case
question_corpus = tm_map(question_corpus, content_transformer(tolower))

## Remove Punctuation
question_corpus = tm_map(question_corpus, removePunctuation)

## Convert to Plain Text Format
question_corpus = tm_map(question_corpus, PlainTextDocument)

## To resolve the error 'simple_triplet_matrix 'i, j, v' different lengths'
question_corpus <- Corpus(VectorSource(question_corpus))

## Remove Stopwords
question_corpus = tm_map(question_corpus, removeWords, stopwords('english'))

## we will perform stemming. This means that all the words are converted 
## to their stem (Ex: learning -> learn, walked -> walk, etc.). This will 
## ensure that different forms of the word are converted to the same form 
## and plotted only once in the wordcloud.
question_corpus = tm_map(question_corpus, stemDocument)

## If you want to remove the words ‘the’ and ‘this’, you can include them 
## in the removeWords function as follows:
question_corpus <- tm_map(question_corpus, removeWords, c('the', 'this', stopwords('english')))

## scale: This is used to indicate the range of sizes of the words.
## max.words and min.freq:  These parameters are used to limit the number of words plotted. 
##                          - max.words will plot the specified number of words and discard 
##                            least frequent terms, whereas, 
##                          - min.freq will discard all terms 
##                            whose frequency is below the specified value.
## random.order:  By setting this to FALSE, we make it so that the words with the highest 
##                frequency are plotted first. If we don’t set this, it will plot the words 
##                in a random order, and the highest frequency words may not necessarily appear in the center.
## rot.per: This value determines the fraction of words that are plotted vertically.
## colors:  The default value is black. If you want to use different colors based on 
##          frequency, you can specify a vector of colors, or use one of the pre-defined color palettes. 


## Create Word Cloud
wordcloud(question_corpus, max.words = 100, random.order = F, colors=palette(rainbow(6)))

## First we need to create a Corpus 
category_corpus = Corpus(VectorSource(questions$Category))

## Convert corpus to lower case
category_corpus = tm_map(category_corpus, content_transformer(tolower))

## Remove Punctuation
category_corpus = tm_map(category_corpus, removePunctuation)

## Convert to Plain Text Format
category_corpus = tm_map(category_corpus, PlainTextDocument)

## To resolve the error 'simple_triplet_matrix 'i, j, v' different lengths'
category_corpus <- Corpus(VectorSource(category_corpus))

## Remove Stopwords
category_corpus = tm_map(category_corpus, removeWords, stopwords('english'))

## Create Word Cloud
wordcloud(category_corpus, max.words = 400, random.order = F)



