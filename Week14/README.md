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
BAM and BigWig files are generated for each of the six samples using the algin and bigwig targets in the Makefile.

```
make align NAME=chr22.genome R1=reads/HBR_1_R1.fq
```
```
make align NAME=chr22.genome R1=reads/HBR_2_R1.fq
```
```
make align NAME=chr22.genome R1=reads/HBR_3_R1.fq
```
```
make align NAME=chr22.genome R1=reads/UHR_1_R1.fq
```
```
make align NAME=chr22.genome R1=reads/UHR_2_R1.fq
```
```
make align NAME=chr22.genome R1=reads/UHR_3_R1.fq
```

```
make bigwig NAME=chr22.genome SAMPLE=HBR_1_R1
```
```
make bigwig NAME=chr22.genome SAMPLE=HBR_2_R1
```
```
make bigwig NAME=chr22.genome SAMPLE=HBR_3_R1
```
```
make bigwig NAME=chr22.genome SAMPLE=UHR_1_R1
```
```
make bigwig NAME=chr22.genome SAMPLE=UHR_2_R1
```
```
make bigwig NAME=chr22.genome SAMPLE=UHR_3_R1
```

<img width="1892" height="557" alt="image" src="https://github.com/user-attachments/assets/a2a3757a-4408-49e6-94c3-3bcb7a641af5" />

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
### Identify a set of differentially expressed genes or transcripts
### Perform functional enrichment analysis on your differentially expressed genes
