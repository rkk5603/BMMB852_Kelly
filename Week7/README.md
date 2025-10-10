
In the assignment for week 6 you were asked to write a Makefile that can align reads to a reference and creates a BAM alignment file. 
In the assignment for week 5 you were asked to identify a different sequencing run for the same organism.
Reuse your previous Makefile and accession numbers, but ensure that your Makefile is generic enough that no code changes are necessary to perform the various tasks. 
Your Makefile should be customizable via parameters for example:


# Get the fastq files from SRA
make fastq SRR=SRR1972739 
### 1.Add additional code to your Makefile to also create bigWig coverage tracks. See the WIGGLE: Genome coverage page for code.

### 2. In your README.md, demonstrate the use of your Makefile to generate a BAM file for both the original data and the second sequencing data obtained with a different instrument.

### 3. Visualize the GFF annotations and both wiggle and BAM files in IGV.

### questions:
Briefly describe the differences between the alignment in both files.
Briefly compare the statistics for the two BAM files.
How many primary alignments does each of your BAM files contain?
What coordinate has the largest observed coverage? (hint: samtools depth)
Select a gene of interest. How many alignments on the forward strand cover the gene?
 Back to top
