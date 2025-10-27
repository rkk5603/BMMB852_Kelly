# Using GNU parallel to call a makefile with multiple items in a design.csv
### Make a design.csv file with all SRR runs associated with a bioproject
I used esearch and runinfo to grab all SRR numbers associated with the PRJNA257197 project from the 2014 ebola virus outbreak paper. This command stores the SRR, the project number, and the sample name for each.
```
esearch -db sra -query PRJNA257197 | efetch -format runinfo | cut -d ',' -f 1,22,25 > design.csv
```
```
head -11 design.csv > design.csv
```

### Create a Makefile that can produce multiple BAM alignment files from an SRR named after the sample name
The align.mk Makefile will take an SRR and sample name, align the run to the reference genome, and generate a BAM file.

Included targets:
- fetch: Obtains the genome and displays some summary stats
- fastq: Downloads sequencing reads from SRA
- fastqc: generates qc report
- index: Indexes the ref genome for ease of visualization
- align: Generates a BAM file by aligning reads to the genome
- stats: Displays summary stats on the generated BAM file
- bigwig: Converts the BAM file to a more visually digestible BW file.
- clean: Removes unecessary files
- all: runs all targets
- .phony: runs all targets, no files generated

Command line parameters
- ACC: The reference genome (default = AF086833, Ebola virus)
- NAME: user-friendly genome name (default = ebola)
- SRR: SRR run (default = SRR1972976)
- SAMPLE: sample name from SRR run to name BAM file
   
The Makefile can be called for a single sample.
```
make -f align.mk all SRR=SRR1972976 ACC=AF086833 NAME=ebola SAMPLE=sample1
```

### GNU parallel
The Makefile can also be called with GNU parallel to iterate through a design.csv file for multiple SRRs corresponding to sequencing runs.
```
cat design.csv | parallel --colsep , --header : --lb -j 4 make -f align.mk SRR={Run} SAMPLE={Sample} all
```

The output for each sample is a FASTQ file, a FASTQC report, a BAM and BW file, and some summary statistics for the alignment.


