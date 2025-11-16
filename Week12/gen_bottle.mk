# analyzing cancer variants from Genome in a Bottle paper

#default settings
SHELL = bash
.ONESHELL:
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules


# reference genome
REF_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/references/GRCh38/GRCh38_GIABv3_no_alt_analysis_set_maskedGRC_decoys_MAP2K3_KMT2C_KCNJ18.fasta.gz

# Download the reference genome
REF=refs/GRCh38.fasta.gz

# The chromosome of interest.
CHR=chr12

# A subset of the reference genome for the region of interest.
REF=refs/${CHR}.fasta

# Set the region of interest.
REGION=chr12:25,205,246-25,250,936

# parameters for reference samples (URL of the BAM file, BAM file name, VCF file name)
BAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data_somatic/HG008/Liss_lab/Element-AVITI-20241216/HG008-N-D_Element-StdInsert_77x_GRCh38-GIABv3.bam
BAM=bam/KRAS-N-P.bam
VCF=vcf/KRAS-N-P.vcf.gz

# ------------- targets -------------------

usage:
	echo '# parameters for reference samples'
	echo '#'
	echo "# BAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data_somatic/HG008/Liss_lab/Element-AVITI-20241216/HG008-N-D_Element-StdInsert_77x_GRCh38-GIABv3.bam"
	echo '#'
	echo '# BAM=bam/KRAS-N-P.bam'
	echo '#'
	echo '# VCF=vcf/KRAS-N-P.vcf.gz'
	echo '#'
	echo '# parameters for tumor samples'
	echo '#'
	echo "# BAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data_somatic/HG008/Liss_lab/Element-AVITI-20241216/HG008-T_Element-StdInsert_111x_GRCh38-GIABv3.bam"
	echo '#'
	echo '# BAM=bam/KRAS-T.bam'
	echo '#'
	echo '# VCF=vcf/KRAS-T.vcf.gz'

# Get the reference genome
get_ref:
	# Create the reference directory
	mkdir -p refs

	# Download the reference genome
	curl -L ${REF_URL} > ${REF}

	# Index the reference genome for use with samtools.
	samtools faidx ${REF}

# Get a subset of alignments from region of interest
reads:
	# Create the BAM directory
	mkdir -p bam

	# Extract the reads for the region of interest.
	samtools view -b ${BAM_URL} ${REGION} > ${BAM}

	# Index the BAM file.
	samtools index ${BAM}

	# Get statistics on the BAM file.
	samtools flagstat ${BAM}

# Call variants for the region of interest.
variants:
	make -f bcf.mk \
        REF=${REF} \
        BAM=${BAM} \
        VCF=${VCF} \
        bcf

# Run all without downloading reference again
run: reads variants
