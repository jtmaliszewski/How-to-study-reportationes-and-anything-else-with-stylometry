# check for libraries and download if needed
lapply(c("stylo", "ggplot2", "dplyr", "ggrepel"), 
       function(x) if(!is.element(x, installed.packages())) install.packages(x, dependencies = T))

#load libraries
library(stylo)
library(ggplot2)
library(dplyr)
library(ggrepel)


# This produces the test featured in the paper, figure 1, with stylo's default plot
results_figure_1 = stylo(
  gui = FALSE, 
  corpus.dir = "data/lemmatized_data", 
  mfw.min=200, 
  mfw.max=200, 
  # start.at = 2, 
  corpus.lang = "Latin.corr", 
  analysis.type="PCR", 
  text.id.on.graphs="points", 
  culling = FALSE, 
  sampling = "normal.sampling", 
  sample.size = 3000
)

# If you want to experiment with different parameters, run stylo(corpus.dir = "data/lemmatized_data") and use the GUI.



# export the frequencies table for custom plot and run PCA
frequencies_table = results_figure_1$table.with.all.freqs[,1:200]# note that [,1:200] in this line should be adjusted to fit the number of MFW used.
pca.results = prcomp(frequencies_table, scale=TRUE)

# Add labels to frequencies, relevant for class coloring
sample_names <- rownames(frequencies_table)
text_labels <- sub("_.+$", "", sample_names) # grabs file's name preceding first "_"

# transform input for ggplot
datapoints <- as.data.frame(pca.results$x)
datapoints$labels <- text_labels


datapoints <- datapoints %>%
  group_by(labels) %>%
  mutate(unique_name = paste0(substr(labels, 1, 1), "", row_number())) %>%
  ungroup()

# save captured variance, rounded to 2 decimal places
variance_by_PC <- round(summary(pca.results)$importance[2,1:2] * 100,2)

# function: pastes relevant variance in axis labels
full_axis_label <- function(x){
  paste("PC", as.character(x)," (", variance_by_PC[x], "%)", sep="")
}

# define custom theme for the plot
custom_theme <- function() { 
  theme(
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    axis.title = element_text(size = 14, color="grey30"), 
    axis.text = element_text(size = 10),
    legend.position = "none",
    axis.title.x = element_text(hjust=0.0), 
    axis.title.y = element_text(hjust=0.0) 
  ) 
}

# plot the PCA, applying custom theme and plotting axis through (0,0)
PCA_plot <- ggplot(datapoints, aes(x=PC1, y=PC2, color = labels))+
  geom_point(size = 2.5)+
  geom_text(aes(label = unique_name), vjust = -0.9, size = 3, fontface = 'bold', ) +
  xlab(full_axis_label(1))+
  ylab(full_axis_label(2))+
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey") +  
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey") + 
  custom_theme()

ggsave("figures/fig_1_PCA.png", plot = PCA_plot, width = 7, height = 5, dpi = 300)
