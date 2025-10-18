### Identify the sample names that connect the SRR numbers to the samples and create a design.csv file that connects the SRR numbers to the sample names.
I used esearch and runinfo to grab all SRA numbers associated with the PRJNA257197 project from the 2014 ebola virus outbreak paper.
```
esearch -db sra -query PRJNA257197 | efetch -format runinfo | cut -d ',' -f 1,22,25
```
Columns 1, 22, and 25 are the SRA, project number, and sample name respectively. This command creates a design file with all associated samples.

### Create a Makefile that can produce multiple BAM alignment files from an SRR named after the sample name.

### Using GNU parallel run the Makefile on all (or at least 10) samples.

### Create a README.md file that explains how to run the Makefile
The result should be consists of:
a genome named in a user friendly name
FASTQ read data named by the samples
FASTQC reports for each read
Alignments and coverage files in BAM and BW formats.
A statistics alignment report for BAM file
You README.md filr should explain how to run the Makefile on the design.csv file.

