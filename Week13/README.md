# Generate a genome-based RNA seq count matrix
RNA seq data from the 2015 Griffith et al. paper is used for this analysis. First, reads from three controls and three cancer samples were retrieved along with a human reference genome fasta and GTF file. The data used here is a subset of the raw data, focusing on a section of chromosome 22 and reads aligned to it.
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

### 1. Align the reads to the genome and create BAM and BigWig files.
BAM and BigWig files are generated for each of the six samples using the algin and bigwig targets in the Makefile.
```

```
### 2. Run a feature counter to create a count matrix for your data. 
- The result of your code should be a matrix that summarizes read counts for each dataset.

### 3. Include IGV screenshots that demonstrate your data is RNA-Seq data.

### 4. Discuss a few lines of the resulting count matrix. 
- Visually identify rows where the counts show consistent gene expression levels.
- Try to visually verify that the counts in the count matrix are consistent with the numbers you can observe in the alignment tracks.
