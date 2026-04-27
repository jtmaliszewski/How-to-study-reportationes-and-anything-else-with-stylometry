## Data Description

This repository contains reproduction data and scripts for the plots presented in Maliszewski, "How to study reportationes (and anything else) with stylometry", currently in review.

For Figure 1, refer to r_scripts / plots_PCA_cluster_analysis.R

For Figure 2, refer to r_scripts / plot_dendr.R

Note that you can run both scripts with relevant data loading the entire R project: How_to_study_reportationes.Rproj

The textual data (data/raw_data) is derived from:
- Hugh, De sacramentis: plain text extracted from Ph. Roelli's TEI-XML encoding of Migne's edition (available from Corpus Corporum: https://mlat.uzh.ch/browser/38/2230/6042/11082). 
- Chanter, Summa de sacramentis: manually corrected OCR from J.-A. Dugauquier's 1954 edition (vol. I, p. 13-182).
- Lotarius, De mysteriis missae: plain text extracted from source files (.doc) of O. Hanne's 2022 edition, kindly shared for this purpose by the editor.   

All files were lemmatised using UDPipe, with records stored in processing/full_lemmatization_records.

## Funding Statement

This work was supported by the National Science Centre, Poland, project 2022/45/N/HS1/03747.
