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

# Obtains the reference genome
fetch:
        #makes ref directory
        mkdir -p $(dir ${REF})

        #gets ebola genome genome
        bio fetch ${ACC} --format fasta > ${REF}

        #displays genome stats
        seqkit stats ${REF}

#Downloads subset of data for 10x coverage (950 reads)
#Remove -X for all data
fastq:
        # Create the reads directory
        mkdir -p $(dir ${R1})

        # Downloads reads
        fastq-dump -X ${N} --outdir reads --split-files ${SRR}

        # Summary stats for reads
        seqkit stats ${R1} ${R2}

# Index the reference genome
index:
        bwa index ${REF}

# Align the reads and convert to BAM (only for paired-end reads)
# specifies use of 4 threads
align:
        # Make the BAM directory
        mkdir -p $(dir ${BAM})

        # Align the reads
        bwa mem -t 4 ${REF} ${R1} ${R2} | samtools sort  > ${BAM}

        # Indexes the BAM file
        samtools index ${BAM}
# Generates alignment statistics
stats:
        samtools flagstat ${BAM}

# Removes unecessary files
clean:
        rm -rf ${REF} ${R1} ${R2} ${BAM} ${BAM}.bai

# Runs all targets
all: fetch fastq index align stats

# always runs .phony files
.PHONY: all fetch fastq index align clean stats
