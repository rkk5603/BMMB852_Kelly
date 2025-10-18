****You may reuse the Makefile created in previous assignments. Take the paper you were assigned to reproduce and create a design.csv file that connects the SRR numbers to the sample names.

Identify the sample names that connect the SRR numbers to the samples.
Create a design.csv file that connects the SRR numbers to the sample names.
Create a Makefile that can produce multiple BAM alignment files (you can reuse the one from the previous assignment) where from an SRR you can produce a BAM alignment file named after the sample name.
Using GNU parallel run the Makefile on all (or at least 10) samples.
Create a README.md file that explains how to run the Makefile
The result should be consists of:

a genome named in a user friendly name
FASTQ read data named by the samples
FASTQC reports for each read
Alignments and coverage files in BAM and BW formats.
A statistics alignment report for BAM file
You README.md filr should explain how to run the Makefile on the design.csv file.

Hints. You may be able to use the SRA website to get sample names connected to SRR numbers. Alternatively, you can use the bio tool to get the metadata.


# Get metadata for a BioProject
bio search PRJNA257197 -H --csv > metadata.csv
or

# Get metadata for an SRR number
bio search SRR1972976 -H --csv > metadata.csv
