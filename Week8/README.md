### Identify the sample names that connect the SRR numbers to the samples and create a design.csv file that connects the SRR numbers to the sample names.
I used esearch and runinfo to grab all SRR numbers associated with the PRJNA257197 project from the 2014 ebola virus outbreak paper.
```
esearch -db sra -query PRJNA257197 | efetch -format runinfo | cut -d ',' -f 1,22,25
```
Columns 1, 22, and 25 are the SRR, project number, and sample name respectively. This command creates a design file with all associated samples.

### Create a Makefile that can produce multiple BAM alignment files from an SRR named after the sample name.
The align.mk Makefile will take an SRR and sample name, align the run to the reference genome (ACC=AF086833, Ebola virus, by default), and generate a BAM file.

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

### Using GNU parallel run the Makefile on all (or at least 10) samples.
The command will run all targets for the first 10 samples of the design.csv file.
```
head -11 design.csv | parallel --colsep , --header : --lb -j 4 make -f align.mk SRR={Run} SAMPLE={Sample} all
```

The output for each sample is a FASTQ file, a FASTQC report, a BAM and BW file, and some summary statistics for the alignment.


