# Perform a differential expression analysis on an RNA-Seq count matrix.
This assignment demonstrates the entire RNA-seq analysis workflow; 
- Producing BAM files from alignments performed on FASTQ reads
- Generating a read count matrix from the BAM files
- Visualization of differential gene expression among samples
- Functional enrichment analysis of DEGs

### Obtain reads
RNA seq data from the 2015 Griffith et al. paper is used for this analysis. First, reads from three control samples and three cancer samples were retrieved along with a human reference genome fasta and GTF file. The data used here is a subset of the raw data, focusing on a section of chromosome 22 and reads aligned to it.
```
wget -nc  http://data.biostarhandbook.com/data/uhr-hbr.tar.gz
```
```
tar xzvf uhr-hbr.tar.gz
```

Included in the file are:
- refs/chr22.genome.fa
- refs/chr22.gtf
- reads/HBR_1_R1.fq
- reads/HBR_2_R1.fq
- reads/HBR_3_R1.fq
- reads/UHR_1_R1.fq
- reads/UHR_2_R1.fq
- reads/UHR_3_R1.fq

### Align the reads to the genome and create BAM and BigWig files.
First, generate a design.csv file for the samples and their treatment groups.
```
Sample,Group
HBR_1_R1,HBR
HBR_2_R1,HBR
HBR_3_R1,HBR
UHR_1_R1,UHR
UHR_2_R1,UHR
UHR_3_R1,UHR
```
BAM and BigWig files are generated for each of the six samples using the algin and bigwig targets in the Makefile.

```
cat design.csv | parallel --colsep , --header : --lb -j 4 make PAIRED=false SAMPLE={Sample} REF=refs/chr22.genome.fa R1=reads/{Sample}.fq align
```
```
cat design.csv | parallel --colsep , --header : --lb -j 4 make PAIRED=false SAMPLE={Sample} REF=refs/chr22.genome.fa BAM=bam/{Sample}.bam bigwig
```

### Run a feature counter to create a count matrix for your data. 
From the resulting BAM files, a matrix is produced that summarizes read counts for each dataset.
First, featureCounts will count the number of reads that overlap with each feature.
```
featureCounts -a refs/chr22.gtf -o counts.txt \
  bam/HBR_1_R1.bam \
  bam/HBR_2_R1.bam \
  bam/HBR_3_R1.bam \
  bam/UHR_1_R1.bam \
  bam/UHR_2_R1.bam \
  bam/UHR_3_R1.bam
```
With the counts.txt file, the matrix target performs three functions:
- counts_csv: converts counts.txt to .csv
- tx2gene: obtains informative gene names for the specified model (default homo sapien)
- inform_geneIDs: adds the informative gene names to counts.csv

```
make matrix MAPPING=hsapiens_gene_ensembl
```

### Generate PCA and heatmap visualizations of your data
The pca target in the Makefile calls two R scripts in the src toolkit.
- The edger.r script will process the counts.csv file to produce a differentially expressed genes matrix
- The plot_pca.r script will constuct a PC plot using the generated edger.csv file and design.csv.
```
make pca
```
<img width="832" height="235" alt="image" src="https://github.com/user-attachments/assets/e6a16d0e-9b94-4a75-9c52-a283de483bb7" />

The heatmap target calls the plot_heatmap.r script to generate a heatmap for the differential expressed genes from the edger.csv file.
```
make heatmap
```
<img width="686" height="776" alt="image" src="https://github.com/user-attachments/assets/717a0139-d726-4ba3-875b-09aa2f1b5a67" />

Everything is coming to fruition. This makes me happy.

### Identify a set of differentially expressed genes or transcripts
From the edger.csv file, there are 299 genes that are differentially expressed after accounting for FDR.
```
# Initializing edgeR tibble dplyr tools ... done
# Tool: edgeR
# Design: design.csv
# Counts: counts.csv
# Sample column: sample
# Factor column: group
# Factors: HBR UHR
# Group HBR has 3 samples.
# Group UHR has 3 samples.
# Method: glm
# Input: 1371 rows
# Removed: 993 rows
# Fitted: 378 rows
# Significant PVal:  304 ( 80.40 %)
# Significant FDRs:  299 ( 79.10 %)
# Results: edger.csv
```

The first 299 rows should be genes that are differentially expressed, with FDRs of 0.
```
$ cat edger.csv | cut -f 1,8,10 -d ',' | head
```
```
name,PValue,FDR
ENSG00000211677.2,2.1e-27,0
ENSG00000211679.2,1.4e-23,0
ENSG00000100167.19,6.2e-23,0
ENSG00000100321.14,6.7e-23,0
ENSG00000100095.18,9.3e-22,0
ENSG00000008735.13,1.2e-21,0
ENSG00000128245.14,3.9e-21,0
ENSG00000130540.13,5.2e-21,0
ENSG00000251322.7,5.4e-21,0
```
### Perform functional enrichment analysis on your differentially expressed genes
The enrichment target in the Makefile calls bio gprofiler to generate a gene homology csv using the edger.csv file.
```
make enrichment ORGANISM=hsapiens
```
<img width="1876" height="296" alt="image" src="https://github.com/user-attachments/assets/67a3e4a0-aac2-42b1-b97d-21d5966cb3d3" />


