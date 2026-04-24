# check for libraries and download if needed
lapply(c('stylo', 'ggplot2', 'dplyr', 'dendextend', 'scales'), 
       function(x) if(!is.element(x, installed.packages())) install.packages(x, dependencies = T))

#load libraries
library(stylo)
library(ggplot2)
library(dplyr)
library(dendextend)
library(scales)


# This produces the test featured in the paper, figure 2, with stylo's default plot
results_figure_2 = stylo(
  gui = FALSE, 
  corpus.dir = "data/lemmatized_data", 
  mfw.min=200, 
  mfw.max=200, 
  # start.at = 2, 
  corpus.lang = "Latin.corr", 
  analysis.type="CA", 
  culling = FALSE, 
  sampling = "normal.sampling", 
  sample.size = 3000
)

# If you want to experiment with different parameters, run stylo(corpus.dir = "data/lemmatized_data") and use the GUI.


# extract relevant distances for customized plot
distances <- results_figure_2$distance.table
clustered <- hclust(as.dist(distances), method = "ward.D")

raw_dendrogram <- as.dendrogram(clustered, hang = 0)

# assign labels
labels_vec <- labels(raw_dendrogram)

groups <- ifelse(
  grepl("^Hugo", labels_vec), "Hugo",
  ifelse(grepl("^Cantor", labels_vec), "Cantor", "Lotharius")
)

# define colouring
default_colors <- c(
  "Cantor" = "#F8766D",
  "Hugo" = "#00BA38",
  "Lotharius" = "#619CFF"
)

leaf_colors <- default_colors[groups]

raw_dendrogram <- raw_dendrogram %>%
  set("labels_col", leaf_colors) %>%
  set("labels_cex", 1)

# save customized plot
png("figures/fig_2_dendrogram.png", width = 3000, height = 3000, res = 300)
plot(raw_dendrogram, horiz = TRUE)
dev.off()
