#Makefile for aligning short reads with BWA

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

# ref genome gff
GFF=refs/${NAME}.gff

# Read 1
R1=reads/${SRR}_1.fastq

# Read 2
R2=reads/${SRR}_2.fastq

#reports directory
REPORTS=reports

#Sample name is SRR by defualt unless specified
SAMPLE=${SRR}

# BAM file
BAM=bam/${SAMPLE}.bam

# How many reads to download
N=10000

# NCBI Genome accession number
ACC=NC_002549.1

# for bigwig file
# The temporary bedgraph file
BG=bam/${SAMPLE}.bedgraph

# The BW wiggle file
BW=bam/${SAMPLE}.bw

# The variant file.
VCF=vcf/${SAMPLE}.vcf.gz

# Flags for the mpileup command
F1=-d 100 --annotate 'INFO/AD,FORMAT/DP,FORMAT/AD,FORMAT/ADF,FORMAT/ADR,FORMAT/SP'

# Flags for the call command
F2=--ploidy 1 --annotate 'FORMAT/GQ' 

#---------------------the stuff---------------------------------------


# Obtain the reference genome
fetch:

	#makes ref directory
	mkdir -p $(dir ${REF})

	#gets genome genome from accession number
	bio fetch ${ACC} --format fasta > ${REF}

	#gets gff file
	bio fetch ${ACC} --format gff > ${GFF}

	#displays genome stats
	seqkit stats ${REF}
# Index the reference genome
index:
	bwa index ${REF}

#Download subset of data for 100x coverage (10000 reads)
#Remove -X for all data
fastq:
        # Create the reads directory
	mkdir -p $(dir ${R1})

        # Download the reads
	fastq-dump -X ${N} --outdir reads --split-files ${SRR}
        # Show some information about the reads
	seqkit stats ${R1} ${R2}

fastqc:
	mkdir -p ${REPORTS}
	fastqc -o ${REPORTS} ${R1} ${R2}


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

# Generates a BW version of the BAM file
bigwig:

	chmod 777 ${REF}

        # Index the reference genome
	samtools faidx ${REF}

        # Generate the temporary bedgraph file.
	LC_ALL=C; bedtools genomecov -ibam ${BAM} -split -bg | \
	sort -k1,1 -k2,2n > ${BG}

        # Convert the bedgraph file to bigwig.
	bedGraphToBigWig ${BG} ${REF}.fai ${BW}

# calls variants from BAM file
bcf:
	mkdir -p vcf
	# mpileup takes BAM file and reference genome as input and calculates coverage and genotype liklihoods
	bcftools mpileup ${F1} -O u -f ${REF} ${BAM} | \
	# and pipes output into call to call variants
	bcftools call ${F2} -mv -O u | \
	# and pipe them into norm to normalize the variants (left-align indels, split multiallelic sites, check reference alleles)
	bcftools norm -f ${REF} -d all -O u | \
	# and pipes into sort to sort variants by chromosome position > saved as vcf file
	bcftools sort -O z > ${VCF}
	#index vcf file for merging
	bcftools index ${VCF}

# generates a multisample VCF file
merge:
	bcftools merge vcf/*.vcf.gz -o vcf/merged.vcf.gz

# Clean up generated files
clean:
	rm -rf ${REF} ${R1} ${R2} ${BAM} ${BAM}.bai bam/${SAMPLE}.bedgraph


# Create necessary directories
all: fastq align stats bigwig

# Create necessary directories
.PHONY: all fetch fastq index align clean stats

