#!/bin/bash

set -xue -o pipefail

echo "Enter SRR number:"
read SRR

#run fastqc on recently dowloaded reads
fastqc reads/$SRR*_1.fastq
fastqc reads/$SRR*_2.fastq
