### Target bigwig converts a bam file to a bw file.
```
make -f align.mk bigwig
``` 
### The makefile generates bam file for an RNA seq short read, paired-end data set for ebola virus
input:
```
make -f align.mk all
```
### The makefile can generate a bam file for a specified SRR (pac bio long read data set for ebola virus). R2 must be set to an empty string if the specidied SRR is not a paired read run.
input:
```
make -f align.mk all SRR=SRR1640364 R2=
```
### Visualize the GFF annotations and both wiggle and BAM files in IGV.
<img width="1900" height="994" alt="bam_bw" src="https://github.com/user-attachments/assets/eded7ea1-241e-47c8-b2b9-c1a8343f18da" />

### Briefly describe the differences between the alignment in both files.
The bw files are visually easier to analyze tha the bam files. The bw alignment only shows simple peaks while bam shows more information.

### Briefly compare the statistics for the two BAM files.
input:

```
samtools flagstat bam/SRR1972976.bam
samtools flagstat bam/SRR1972976.bam
```
The short-read run mapped abut 0.1% of the reads to the genome, while the pac bio run mapped about 95% of the reads to the reference genome.

### How many primary alignments does each of your BAM files contain?
Input:
```
samtools view -c -F 4 bam/SRR1972976.bam
```
Only 13 reads align to the genome, while 199988 do not

Input:
```
samtools view -c -F 4 bam/SRR1640364.bam
```
The pac bio run has more primary alignments. 51775 reads align with the reference genome and only 244 do not align.

### What coordinate has the largest observed coverage? (hint: samtools depth)
58 different coordinates have the largest coverage (2x) in SRR1972976.

### Select a gene of interest. How many alignments on the forward strand cover the gene?
<img width="1726" height="648" alt="L gene coverage" src="https://github.com/user-attachments/assets/1a3c19c2-0e74-4efb-9a7a-c3e4d6dbc060" />
The L gene spans about 11700 to 18900. SRR1972976 has three reads on the forward strand that align to the L gene. I am still at a loss with this alignment. This is very poor coverage.
