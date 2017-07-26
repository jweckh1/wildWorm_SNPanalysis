### R script to pull candidate SNPs from MMP wild worm dataset based on strain colonization levels (control) and distance from lawn (selectivity) identified by Fan Zhang, PhD
### Jessica Weckhorst, July 2017

library("readr")

#Temporarily commented out for faster coding
#all_mmp_SNPs <- read_delim("~/Documents/R_Projects/WildWorm_SelectivityControl/mmp_wild_isolate_data_Mar13.csv", "\t", escape_double = FALSE, trim_ws = TRUE)

#Creates a column containing gene name and allele
all_mmp_SNPs$gene_allele <- paste(all_mmp_SNPs$CGC, all_mmp_SNPs$allele, collapse = "_")

#Comment the following out as desired (rest of script will need to be edited if including nonsynonymous etc. effects and other regions of the gene:
all_mmp_SNPs_effect<-all_mmp_SNPs[!is.na(all_mmp_SNPs$effect),]
all_mmp_SNPs_effect_coding<-subset(all_mmp_SNPs_effect, all_mmp_SNPs_effect$feature == "coding_exon")

#rarified to 1407 here for order
#comm.data<-cbind(comm.data.read[,c(1:4)],rrarefy(comm.data.read[,-c(1:4)],1407))



#trts<-as.vector((unique((comm.data$rep))))
#trts<-trts[-c(4,5)]


#results<-matrix(nrow=0,ncol=7)
#options(warnings=-1)

#for(a in 1:length(trts)){
	#pull the first element from the vector of treatments
#	trt.temp<-trts[a]
	#subset the dataset for those treatments
#	temp<-subset(comm.data, trt==trt.temp)
	
	#in this case the community data started at column 6, so the loop for co-occurrence has to start at that point
#	for(b in 6:(dim(temp)[2]-1)){
		#every species will be compared to every other species, so there has to be another loop that iterates down the rest of the columns
#		for(c in (b+1):(dim(temp)[2])){
			
			#summing the abundances of species of the columns that will be compared
#			species1.ab<-sum(temp[,b])
#			species2.ab<-sum(temp[,c])
			#if the column is all 0's no co-occurrence will be performed
#			if(species1.ab >1 & species2.ab >1){
#				test<-cor.test(temp[,b],temp[,c],method="spearman",na.action=na.rm)
#				rho<-test$estimate
#				p.value<-test$p.value
#			}
			
#			if(species1.ab <=1 | species2.ab <= 1){
#				rho<-0
#				p.value<-1
#			}	
			
#			new.row<-c(trts[a],names(temp)[b],names(temp)[c],rho,p.value,species1.ab,species2.ab)
#			results<-rbind(results,new.row)			
			
#		}
		
#	}
	
	
#	print(a/length(trts))
	
#}


#head(results)
#results<-data.frame(data.matrix(results))
#names(results)<-c("trt","taxa1","taxa2","rho","p.value","ab1","ab2")

