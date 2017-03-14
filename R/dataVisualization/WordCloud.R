
library(tm)
library(SnowballC)
library(wordcloud)

questions = read.csv("JEOPARDY_101.csv")

## First we need to create a Corpus 
question_corpus = Corpus(VectorSource(questions$Question))

## Convert corpus to lower case
question_corpus = tm_map(question_corpus, content_transformer(tolower))

## Remove Punctuation
question_corpus = tm_map(question_corpus, removePunctuation)

## Convert to Plain Text Format
question_corpus = tm_map(question_corpus, PlainTextDocument)

## Remove Stopwords
question_corpus = tm_map(question_corpus, removeWords, stopwords('english'))

## Create Word Cloud
wordcloud(question_corpus, max.words = 100, random.order = F)


## First we need to create a Corpus 
category_corpus = Corpus(VectorSource(questions$Category))

## Convert corpus to lower case
category_corpus = tm_map(category_corpus, content_transformer(tolower))

## Remove Punctuation
category_corpus = tm_map(category_corpus, removePunctuation)

## Convert to Plain Text Format
category_corpus = tm_map(category_corpus, PlainTextDocument)

## Remove Stopwords
category_corpus = tm_map(category_corpus, removeWords, stopwords('english'))

## Create Word Cloud
wordcloud(category_corpus, max.words = 400, random.order = F)
