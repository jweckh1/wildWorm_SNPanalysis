### R script to pull candidate SNPs from MMP wild worm dataset based on strain colonization levels (control) and distance from lawn (selectivity) identified by Fan Zhang, PhD
### Jessica Weckhorst, July 2017

library("readr")

#Temporarily commented out for faster coding
#all_mmp_SNPs <- read_delim("~/Documents/R_Projects/wildElegans_MMP_snpAnalysis/mmp_wild_isolate_data_Mar13.csv", "\t", escape_double = FALSE, trim_ws = TRUE)

all_mmp_SNPs<-mmp_wild_isolate_data_Mar13
rm(mmp_wild_isolate_data_Mar13)

#Creates a column containing gene name and allele
all_mmp_SNPs<-within(all_mmp_SNPs, gene_allele <- paste(CGC, allele, sep="_"))

#Comment the following out as desired (rest of script will need to be edited if including nonsynonymous etc. effects and other regions of the gene:
all_mmp_SNPs_effect<-all_mmp_SNPs[!is.na(all_mmp_SNPs$effect),]
all_mmp_SNPs_effect_coding<-subset(all_mmp_SNPs_effect, all_mmp_SNPs_effect$feature == "coding_exon")
