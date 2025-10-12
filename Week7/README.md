### Target bigwig converts a bam file to a bw file.
```
make -f fetch_index_align.mk bigwig
``` 
### generates bam file for an RNA seq short read, paired-end data set for ebola virus
input:
```
make -f fetch_index_align.mk all
```
### generates bam file for a pac bio long read data set for ebola virus. R2 must be set to an empty string if the specidied SRR is not a paired read run.
input:
```
make -f fetch_index_align.mk all SRR=SRR1640364 R2=
```
### 3. Visualize the GFF annotations and both wiggle and BAM files in IGV.

### questions:
Briefly describe the differences between the alignment in both files.
Briefly compare the statistics for the two BAM files.
How many primary alignments does each of your BAM files contain?
What coordinate has the largest observed coverage? (hint: samtools depth)
Select a gene of interest. How many alignments on the forward strand cover the gene?
 Back to top
