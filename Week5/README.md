### BioProject and SRR accession numbers for the Gire _et al._ 2014 Ebola virus seq data
- Bioproject: PRJNA257197
- ACC: AF086833
- ACC: KM233118
- SRR for a data set: SRR1972976

### 1. Bash script for downloading a data set

```
#!/bin/bash

#make script behave
set -xue -o pipefail

ACC=GCF_000848505.1

#---------No changes below line-----------------

#download genome zip, grab gff
datasets download genome accession $ACC --include gff3,gtf,genome
unzip -n ncbi_datasets.zip

```
### 2. Script for genome length and features

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
echo "The longest gene:"
grep -P "\tgene\t" $gff | awk '{print $5 - $4, $0}' | sort -rnk1 | head -1 | cut -f 9

```

### 3. Download only a subset of the data for 10x genome coverage and provide number of reads, total bases, and average read length
- C=(LN)/G or N=(CG)/L
- L: read length
- N: number of reads
- G: genome length
- number of reads for 10x coverage=(10*19000)/200
- =950 reads
```
#!/bin/bash

set -xue pipefaile

SRR=SRR1972976
num_reads=950

#---------no changes below line--------------

#stats for SRR number of reads
bio search $SRR

#identify read length (~202)
echo "Read length found here:"
esearch -db sra -query $SRR | efetch -format runinfo | cut -d ',' -f 1,7

#fetch only enough reads for 10x coverage (~950)
fastq-dump -X $num_reads -F --outdir reads --split-files $SRR

#basic stats for downloaded reads
seqkit stats reads/$SRR*_1.fastq
seqkit stats reads/$SRR*_2.fastq

```
### 4. Run FASTQC on the downloaded data to generate a quality report.
```
#!/bin/bash

set -xue -o pipefail

echo "Enter SRR number:"
read SRR

#run fastqc on recently dowloaded reads
fastqc reads/$SRR*_1.fastq
fastqc reads/$SRR*_2.fastq
```
### 5. Evaluate the FASTQC report and summarize your findings.
<img width="1213" height="788" alt="fastqc_forward_ebola1" src="https://github.com/user-attachments/assets/fd664233-1d80-440a-99a4-f565d5e36000" />
The read quality is not great. The GC content is a bit high, and the median quality is pretty poor meaning uncertain base calls. Also, the reads still have adapter sequences.

### 6. Comparing quality of another dataset for the same genome
- SRR1640364: PacBio long reads instead of NextGen short reads
<img width="1212" height="759" alt="image" src="https://github.com/user-attachments/assets/c3f27871-44ae-41bf-9a0f-62188b9a3c79" />
Woah! Base quality is a bit better than the short reads quality. The GC content and overrepresented sequences still failed, but the adapters have already been removed. Or maybe adapter ligating is different for long reads... I'm not sure how long read library preps work :(

### (optional) Perform quality control steps (e.g., trimming, filtering)
- This script does it all (steps 3-5, plus qc). 

```
#!/bin/bash

#reads directory
READS=reads

#reports directory
REPORTS=reports

#common adapter sequences
ADAPTER=AGATCGGAAGAGCACACGTCTGAACTCCAGTCA

mkdir -p $REPORTS $READS

#---------no changes below line--------------

echo "Enter SRR number: (try SRR1972976)"
read SRR

#stats for SRR number of reads
echo "Loading SRR summary"
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
#determines number of reads to fetch for requested coverage
num_reads=$((coverage*gen_size/read_length))
echo "Number of reads for requested coverage is" $num_reads
echo "Fetching" $num_reads "reads"

#fetch only enough reads for 10x coverage
fastq-dump -X $num_reads -F --outdir reads --split-files -O $READS $SRR

#basic stats for downloaded reads
seqkit stats reads/$SRR*_1.fastq
seqkit stats reads/$SRR*_2.fastq


R1=reads/${SRR}_1.fastq
R2=reads/${SRR}_2.fastq

# Trimmed read names
T1=reads/${SRR}_1.trimmed.fastq
T2=reads/${SRR}_2.trimmed.fastq

echo "Would you like a quality analysis?"
read FASTQC
if [[ "$FASTQC" == "y" || "$FASTQC" == "yes" ]]; then

        echo "Running fastqc"
        #run fastqc on recently dowloaded reads
        fastqc -o $REPORTS $R1 $R2

elif [[ "$FASTQC" == "n" || "$FASTQC" == "no" ]]; then
        echo "Sure thing fam"
        exit
fi


echo "Would you like to perform quality control on reads?"
read QC

if [[ "$QC" == "y" || "$QC" == "yes" ]]; then

        echo "Running fastp"
        #trims low quality reads and adapter sequences. Generates new fastqc
        fastp --adapter_sequence=${ADAPTER} \
        --cut_tail \
        -i ${R1} -I ${R2} -o ${T1} -O ${T2}

elif [[ "$QC" == "n" || "$QC" == "no" ]]; then
        echo "Oh. okay."
        exit
fi
```
