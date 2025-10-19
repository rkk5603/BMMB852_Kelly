### Make a design.csv file with all SRR runs associated with a bioproject
I used esearch and runinfo to grab all SRR numbers associated with the PRJNA257197 project from the 2014 ebola virus outbreak paper. This command stores the SRR, the project number, and the sample name for each.
```
esearch -db sra -query PRJNA257197 | efetch -format runinfo | cut -d ',' -f 1,22,25
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

### GNU parallel
From the command line, parameters can be specified.

The reference genome (default = AF086833, Ebola virus):
```
ACC=[genome_accession#]
````

A user-friendly genome name (default = ebola):
```
NAME=[user_friendly_name]
```

The SRR (default = SRR1972976):
```
SRR=[SRR#]
```

The Makefile can be called with GNU parallel to iterate through a design.csv file for multiple SRRs corresponding to sequencing runs.
```
cat design.csv | parallel --colsep , --header : --lb -j 4 make -f align.mk SRR={Run} SAMPLE={Sample} test
```

### Using GNU parallel to run the Makefile on the design.csv file
This command will run all targets for the first 10 samples of the design.csv file.
```
head -11 design.csv | parallel --colsep , --header : --lb -j 4 make -f align.mk SRR={Run} SAMPLE={Sample} all
```

The output for each sample is a FASTQ file, a FASTQC report, a BAM and BW file, and some summary statistics for the alignment.


