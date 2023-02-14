## ---------------------------
## Script name: nonpareil_parse.R
## Author: McKenna Farmer
## Date Created: 2023-02-13
## ---------------------------
## Notes:
##   Parsing nonpareil outputs
##
## ---------------------------

library(Nonpareil)

pareil_path <- "./gaohan/local-working/nonpareil/"

filenames <- list.files(path=pareil_path, full.names=TRUE, pattern="*.npo")

nps <- Nonpareil.set(filenames)

summary(nps)
summary(nps)[,"LRstar"]/1e9






