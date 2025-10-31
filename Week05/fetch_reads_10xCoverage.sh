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
