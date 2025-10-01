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
