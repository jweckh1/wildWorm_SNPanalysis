### R script to pull candidate SNPs from MMP wild worm dataset based on strain colonization levels (control) and distance from lawn (selectivity) identified by Fan Zhang, PhD
### Jessica Weckhorst, July 2017

library("readr")
library("reshape2")
library("proxy")
library("gplots")
library("RColorBrewer")

#Generate dataframe of gene_alleles unshared between lostControl and maintainRelative+lostSelectivity for each phenoGroup

pheno1_maintainControl<-subset(all_mmp_SNPs_effect_coding, all_mmp_SNPs_effect_coding$strain == "CB4854" | all_mmp_SNPs_effect_coding$strain == "ED3042")
pheno1_maintainSelection<-subset(all_mmp_SNPs_effect_coding, all_mmp_SNPs_effect_coding$strain == "CB4854" | all_mmp_SNPs_effect_coding$strain == "JU1088")

pheno1_CB4854<-subset(all_mmp_SNPs_effect_coding, all_mmp_SNPs_effect_coding$strain == "CB4854")
pheno1_ED3042<-subset(all_mmp_SNPs_effect_coding, all_mmp_SNPs_effect_coding$strain == "ED3042")
pheno1_maintainControlANDLIST<-intersect(pheno1_CB4854$allele, pheno1_ED3042$allele)
pheno1_maintainControlAND<-subset(pheno1_maintainControl, pheno1_maintainControl$allele %in% pheno1_maintainControlANDLIST)

pheno1_loseControl<-subset(all_mmp_SNPs_effect_coding, all_mmp_SNPs_effect_coding$strain == "JU1088")
pheno1_loseSelection<-subset(all_mmp_SNPs_effect_coding, all_mmp_SNPs_effect_coding$strain == "ED3042")

pheno1_candidateDifferences<-subset(pheno1_loseControl, !(pheno1_loseControl$allele %in% pheno1_maintainControlAND$allele))
pheno1_ctrlDif_geneList<-unique(pheno1_candidateDifferences$CGC)
pheno1_candidateBinary_CGC<-dcast(subset(all_mmp_SNPs_effect_coding, all_mmp_SNPs_effect_coding$CGC %in% pheno1_ctrlDif_geneList), strain~CGC, fun.aggregate = function(x){as.integer(length(x)>0)})
strainNames<-pheno1_candidateBinary_CGC$strain
addToLegend<-subset(strainGroupings, strainGroupings$strain %in% strainNames)
addToLegend<-addToLegend[match(strainNames, addToLegend$strain),]

#Change row ID from arbitrary number to strain name
rownames(pheno1_candidateBinary_CGC) <- pheno1_candidateBinary_CGC[,1]
pheno1_candidateBinary_CGC[,1]<-NULL

pheno1_candidateBinary_CGC<-data.frame(lapply(pheno1_candidateBinary_CGC, function(x) as.numeric(as.character(x))))

heatmap.2(as.matrix(pheno1_candidateBinary_CGC), symm = FALSE, trace = "none", labCol = FALSE, labRow = strainNames, main = "Clustering by gene variants in JU1088 (control lost) \n absent in relatives CB4854 and ED3042", col = brewer.pal(3, "Blues"), RowSideColors = brewer.pal(4, "Purples")[factor(as.character(addToLegend$colonizationLevel))])
legend(legendCoords, xpd = TRUE, legend = unique(factor(strainGroupings$colonizationLevel)), col = brewer.pal(4, "Purples")[factor(unique(strainGroupings$colonizationLevel))], lty = 1, lwd = 5, cex = .7)
