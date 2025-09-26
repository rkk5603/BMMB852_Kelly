### BioProject and SRR accession numbers for the Gire _et al._ 2014 Ebola virus seq data
- Bioproject: PRJNA257197
- ACC: AF086833
- ACC: KM233118
- SRR for a data set: SRR1972976

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

### Download only a subset of the data for 10x genome coverage and provide number of reads, total bases, and average read length
- C=(LN)/G or N=(CG)/L
- L: read length
- N: number of reads
- G: genome length
- number of reads for 10x coverage=(10*19000)/200
- =950 reads
- 
```
#!/bin/bash

#set -xue pipefail

#SRR=SRR1972976

#---------no changes below line--------------

echo "Enter SRR number: (try SRR1972976)"
read SRR

#stats for SRR number of reads
bio search $SRR

#identify read length
echo "Read length found here:"
esearch -db sra -query $SRR | efetch -format runinfo | cut -d ',' -f 1,7

echo "What is the average read length?"
read read_length

echo "What coverage would you like (10, 100, 100)?"
read coverage

echo "how big that genome (kb)"
read gen_size

if [[ "$gen_size" -lt "1000000" ]]; then
        echo "Wow that's pretty small"
fi

sleep 1
num_reads=$((coverage*gen_size/read_length))
echo "Number of reads for requested coverage is" $num_reads

#fetch only enough reads for 10x coverage
fastq-dump -X $num_reads -F --outdir reads --split-files $SRR

#basic stats for downloaded reads
seqkit stats reads/$SRR*_1.fastq

```

### Quality assessment: Generate basic statistics on the downloaded reads (e.g., number of reads, total bases, average read length).

### Run FASTQC on the downloaded data to generate a quality report.
### Evaluate the FASTQC report and summarize your findings.
### (optional) Perform any necessary quality control steps (e.g., trimming, filtering) and briefly describe your process (optional)
### Search the SRA for another dataset for the same genome, but generated using a different sequencing platform (e.g., if original data was Illumina select PacBio or Oxford Nanopore).
### Briefly compare the quality or characteristics of the datasets from the two platforms.
