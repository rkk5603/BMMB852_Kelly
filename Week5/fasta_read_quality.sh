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
