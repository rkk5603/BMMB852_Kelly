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

# The file for called variants. Also the input VCF file for effect prediction with snpEff

VCF=vcf/${SAMPLE}.vcf.gz

# Flags for the mpileup command
F1=-d 100 --annotate 'INFO/AD,FORMAT/DP,FORMAT/AD,FORMAT/ADF,FORMAT/ADR,FORMAT/SP'

# Flags for the call command
F2=--ploidy 1 --annotate 'FORMAT/GQ' 

# Annotated VCF file from snpEff
ANN=annotated_variants.vcf

# Database for snpEFF to predict variant effects
SNPEFFDB=ebola_zaire

#---------------------the stuff---------------------------------------

usage:
	echo "# Primary variables: NAME SRR REPORTS N ACC F1 F2 ANN SNPEFFDB"
        echo "#"
        echo "# Variables generated from primary variables: REF GFF R1 R2 SAMPLE BG WG VCF "
        echo "#"
        echo "# fetch: retrieves genome"
        echo "#"
        echo "# index: indexes genome"
        echo "#"
        echo "# fastq: retrieves sequencing reads from a provided SRR"
        echo "#"
        echo "# fastqc: performs QC and generates multiQC report"
        echo "#"
        echo "# align: performs an alignment to the reference genome and generates a BAM file"
        echo "#"
        echo "# stats: displays stats on the results of the alignment"
        echo "#"
        echo "# bigwig: converts BAM file to bigwig file for visualization"
        echo "#"
        echo "# bcf: calls vaariants with bcftools"
        echo "#"
        echo "# effect_db: retrieves prebuilt database for use with snpEff"
        echo "#"
        echo "# effect: predicts variant effects with snpEff"
        echo "#"
        echo "# clean: removes files"
        @echo "#"
        @echo "# Input parameters."
        @echo "#"

# Obtain the reference genome
fetch:

	# makes ref directory
	mkdir -p $(dir ${REF})

	# gets genome genome from accession number
	bio fetch ${ACC} --format fasta > ${REF}

	# gets gff file
	bio fetch ${ACC} --format gff > ${GFF}

	# alternative retrieval if bio fetch is being a weenie
	# datasets download genome accession $ACC --include gff3,gtf,genome
	# unzip -n ncbi_datasets.zip
	# displays genome stats

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

# Predicts variant effects with snpEff
effect_db:
	snpEff download ${SNPEFFDB}
effect:
	snpEff -v ${SNPEFFDB} ${VCF} > ${ANN}

# Clean up generated files
clean:
	rm -rf ${REF} ${R1} ${R2} ${BAM} ${BAM}.bai bam/${SAMPLE}.bedgraph


# Create necessary directories
all: align bigwig

# Create necessary directories
.PHONY: all fetch fastq index align clean stats

