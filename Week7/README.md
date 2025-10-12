### 1.Add additional code to your Makefile to also create bigWig coverage tracks. See the WIGGLE: Genome coverage page for code.

### 2. In your README.md, demonstrate the use of your Makefile to generate a BAM file for both the original data and the second sequencing data obtained with a different instrument.
input:
```
make -f fetch_index_align.mk all
```
output: generates a bam file for for SRR1972976, and RNA seq data set for ebola virus

input:
```
make -f fetch_index_align.mk all SRR=SRR1640364
```
output: bam file for a pac bio long read data set for ebola virus
### 3. Visualize the GFF annotations and both wiggle and BAM files in IGV.

### questions:
Briefly describe the differences between the alignment in both files.
Briefly compare the statistics for the two BAM files.
How many primary alignments does each of your BAM files contain?
What coordinate has the largest observed coverage? (hint: samtools depth)
Select a gene of interest. How many alignments on the forward strand cover the gene?
 Back to top
