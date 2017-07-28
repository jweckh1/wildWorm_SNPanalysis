### R script to pull candidate SNPs from MMP wild worm dataset based on strain colonization levels (control) and distance from lawn (selectivity) identified by Fan Zhang, PhD
### Jessica Weckhorst, July 2017

library("readr")
library("reshape2")

#Temporarily commented out for faster coding
#all_mmp_SNPs <- read_delim("~/Documents/R_Projects/wildElegans_MMP_snpAnalysis/mmp_wild_isolate_data_Mar13.csv", "\t", escape_double = FALSE, trim_ws = TRUE)
#all_mmp_SNPs<-mmp_wild_isolate_data_Mar13
#rm(mmp_wild_isolate_data_Mar13)

#Creates a column containing gene name and allele
all_mmp_SNPs<-within(all_mmp_SNPs, gene_allele <- paste(CGC, allele, sep="_"))

#Comment the following out as desired (rest of script will need to be edited if including nonsynonymous etc. effects and other regions of the gene:
all_mmp_SNPs_effect<-all_mmp_SNPs[!is.na(all_mmp_SNPs$effect),]
all_mmp_SNPs_effect_coding<-subset(all_mmp_SNPs_effect, all_mmp_SNPs_effect$feature == "coding_exon")

#Generate dataframe of gene_alleles unshared between lostControl and maintainRelative+lostSelectivity for each phenoGroup

#phenoGroup1
phenoGroup1_geneAlleles<-subset(all_mmp_SNPs_effect_coding, strain %in% phenoGroup1)
phenoGroup1_geneAlleles<-subset(phenoGroup1_geneAlleles, !duplicated(gene_allele))
phenoGroup1_geneAlleles_list<-phenoGroup1_geneAlleles[ , "gene_allele"]
phenoGroup1_geneAlleles<-subset(all_mmp_SNPs_effect_coding, gene_allele %in% phenoGroup1_geneAlleles_list$gene_allele)


#phenoGroup2
phenoGroup2_geneAlleles<-subset(all_mmp_SNPs_effect_coding, strain %in% phenoGroup2)
phenoGroup2_geneAlleles<-subset(phenoGroup2_geneAlleles, !duplicated(gene_allele))
phenoGroup2_geneAlleles_list<-phenoGroup2_geneAlleles[ , "gene_allele"]
phenoGroup2_geneAlleles<-subset(all_mmp_SNPs_effect_coding, gene_allele %in% phenoGroup2_geneAlleles_list$gene_allele)

#phenoGroup3
phenoGroup3_geneAlleles<-subset(all_mmp_SNPs_effect_coding, strain %in% phenoGroup3)
phenoGroup3_geneAlleles<-subset(phenoGroup3_geneAlleles, !duplicated(gene_allele))
phenoGroup3_geneAlleles_list<-phenoGroup3_geneAlleles[ , "gene_allele"]
phenoGroup3_geneAlleles<-subset(all_mmp_SNPs_effect_coding, gene_allele %in% phenoGroup3_geneAlleles_list$gene_allele)

#phenoGroup4
phenoGroup4_geneAlleles<-subset(all_mmp_SNPs_effect_coding, strain %in% phenoGroup4)
phenoGroup4_geneAlleles<-subset(phenoGroup4_geneAlleles, !duplicated(gene_allele))
phenoGroup4_geneAlleles_list<-phenoGroup4_geneAlleles[ , "gene_allele"]
phenoGroup4_geneAlleles<-subset(all_mmp_SNPs_effect_coding, gene_allele %in% phenoGroup4_geneAlleles_list$gene_allele)

#Generate binary presence/absence tables for gene alleles selected by phenoGroups
phenoGroup1_binary <- dcast(phenoGroup1_geneAlleles, gene_allele~strain, fun.aggregate = function(x){as.integer(length(x)>0)})
phenoGroup2_binary <- dcast(phenoGroup2_geneAlleles, gene_allele~strain, fun.aggregate = function(x){as.integer(length(x)>0)})
phenoGroup3_binary <- dcast(phenoGroup3_geneAlleles, gene_allele~strain, fun.aggregate = function(x){as.integer(length(x)>0)})
phenoGroup4_binary <- dcast(phenoGroup4_geneAlleles, gene_allele~strain, fun.aggregate = function(x){as.integer(length(x)>0)})