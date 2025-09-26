### BioProject and SRR accession numbers for the Gire _et al._ 2014 Ebola virus seq data
- Bioproject: PRJNA257197
- ACC: AF086833
- ACC: KM233118

### Download a data set

```
#!/bin/bash

#make script behave
set -xue pipefail

ACC=GCF_000848505.1

#---------No changes below line-----------------

#download genome zip, grab gff
datasets download genome accession $ACC --include gff3,gtf,genomic
unzip -n ncbi_datasets.zip

```
### summary of genome length and features

```
#!/bin/bash

set -xeu pipefail
gff=~/work/BMMB852_Kelly/Week5/ncbi_dataset/data/GCF_000848505.1/genomic.gff
fa=~/work/BMMB852_Kelly/Week5/ncbi_dataset/data/GCF_000848505.1/GCF_000848505.1_ViralProj14703_genomic.fna
#----------------no changes below line---------------

#for genome length
echo "genome length is here somewhere:"
seqkit stats $fa
sleep 2

#for gff feature information
echo "gff features, cute and organized:"
cat $gff | grep -v '#' | cut -f 3 | sort | uniq -c
sleep 2

#for longest gene
echo "it aint much, but it's the longest gene:"
grep -P "\tgene\t" $gff | awk '{print $5 - $4, $0}' | sort -rnk1 | head -1 | cut -f 9

```

### Download only a subset of the data that would provide approximately 10x genome coverage. Briefly explain how you estimated the amount of data needed for 10x coverage.
### Quality assessment: Generate basic statistics on the downloaded reads (e.g., number of reads, total bases, average read length).
### Run FASTQC on the downloaded data to generate a quality report.
### Evaluate the FASTQC report and summarize your findings.
### (optional) Perform any necessary quality control steps (e.g., trimming, filtering) and briefly describe your process (optional)
### Search the SRA for another dataset for the same genome, but generated using a different sequencing platform (e.g., if original data was Illumina select PacBio or Oxford Nanopore).
### Briefly compare the quality or characteristics of the datasets from the two platforms.
