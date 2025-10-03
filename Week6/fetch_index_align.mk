#useful default settings
SHELL = bash
.ONESHELL:
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

#-------------------variables------------------

#genome name
NAME=ebola

# SRR number
SRR=SRR1972976
# Reference genome
REF=refs/${NAME}.fa

# Read 1
R1=reads/${SRR}_1.fastq

# Read 2
R2=reads/${SRR}_2.fastq

# BAM file
BAM=bam/${SRR}.bam

# How many reads to download
N=950

# NCBI Genome accession number
ACC=GCF_000848505.1

#---------------------the stuff---------------------------------------

# Obtain the reference genome
fetch:
        #makes ref directory
        mkdir -p $(dir ${REF})

        #gets ebola genome genome
        bio fetch ${ACC} --format fasta > ${REF}

        #displays genome stats
        seqkit stats ${REF}

#Download subset of data for 10x coverage (950 reads)
#Remove -X for all data
fastq:
        # Create the reads directory
        mkdir -p $(dir ${R1})

        # Download the reads
        fastq-dump -X ${N} --outdir reads --split-files ${SRR}

        # Show some information about the reads
        seqkit stats ${R1} ${R2}

# Index the reference genome
index:
        bwa index ${REF}

# Align the reads and convert to BAM. Use 4 threads
# Works for paired-end reads. Modify for single-end reads.
align:
        # Make the BAM directory
        mkdir -p $(dir ${BAM})

        # Align the reads
        bwa mem -t 4 ${REF} ${R1} ${R2} | samtools sort  > ${BAM}

        # Index the BAM file
        samtools index ${BAM}
# Generate alignment statistics
stats:
        samtools flagstat ${BAM}

# Clean up generated files
clean:
        rm -rf ${REF} ${R1} ${R2} ${BAM} ${BAM}.bai

# Create necessary directories
all: fetch fastq index align stats

# Create necessary directories
.PHONY: all fetch fastq index align clean stats
