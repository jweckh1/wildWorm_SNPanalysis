### R script to pull candidate SNPs from MMP wild worm dataset based on strain colonization levels (control) and distance from lawn (selectivity) identified by Fan Zhang, PhD
### Jessica Weckhorst, July 2017

library("readr")
library("reshape2")
library("proxy")

#Generate dataframe of gene_alleles unshared between lostControl and maintainRelative+lostSelectivity for each phenoGroup

pheno1_maintainControl<-subset(all_mmp_SNPs_effect_coding, all_mmp_SNPs_effect_coding$strain == "CB4854" | all_mmp_SNPs_effect_coding$strain == "ED3042")
pheno1_maintainSelection<-subset(all_mmp_SNPs_effect_coding, all_mmp_SNPs_effect_coding$strain == "CB4854" | all_mmp_SNPs_effect_coding$strain == "JU1088")
pheno1_loseControl<-subset(all_mmp_SNPs_effect_coding, all_mmp_SNPs_effect_coding$strain == "JU1088")
pheno1_loseSelection<-subset(all_mmp_SNPs_effect_coding, all_mmp_SNPs_effect_coding$strain == "ED3042")

pheno1_CandidateSelectionDifferences<-subset(pheno1_maintainControl, !(pheno1_maintainControl$allele %in% pheno1_loseControl$allele))
pheno1_relCtrlDif_geneList<-unique(pheno1_RelativeControlDifferences$CGC)
pheno1_relativeBinary_CGC<-dcast(subset(all_mmp_SNPs_effect_coding, all_mmp_SNPs_effect_coding$CGC %in% pheno1_relCtrlDif_geneList), strain~CGC, fun.aggregate = function(x){as.integer(length(x)>0)})
strainNames<-pheno1_relativeBinary_CGC$strain
addToLegend<-subset(strainGroupings, strainGroupings$strain %in% strainNames)

#Change row ID from arbitrary number to strain name
rownames(pheno1_relativeBinary_CGC) <- pheno1_relativeBinary_CGC[,1]
pheno1_relativeBinary_CGC[,1]<-NULL

pheno1_relativeBinary_CGC<-data.frame(lapply(pheno1_relativeBinary_CGC, function(x) as.numeric(as.character(x))))

heatmap.2(as.matrix(pheno1_relativeBinary_CGC), symm = FALSE, trace = "none", labCol = FALSE, labRow = addToLegend$strain, main = "Genes in relatives CB4854 and ED3042 absent in JU1088 (control lost)", col = brewer.pal(3, "Blues"), RowSideColors = as.character(as.numeric(addToLegend$group)))
legend(legendCoords, xpd = TRUE, legend = unique(strainGroupings$group), col = unique(as.numeric(strainGroupings$group)), lty = 1, lwd = 5, cex = .7)