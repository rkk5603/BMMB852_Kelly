# HW 11 Evaluating cancer variants
## Produce and evaluate variant calls
Generate variant calls from the Cancer Genome in a Bottle data and evaluate their quality.

### Call variants for normal and tumor samples in a region of interest
First, retrieve the reference genome. This analysis focuses on a region of chromosome 12 by default.
```
make -f gen_bottle.mk get_ref
```

Next, retrieve a subset of reads from the region of interest for both tumor and non tumor cell samples. The 'usage' target displays the three parameters to change to perform this for both cell types. 
```
# parameters for reference samples
#
# BAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data_somatic/HG008/Liss_lab/Element-AVITI-20241216/HG008-N-D_Element-StdInsert_77x_GRCh38-GIABv3.bam
#
# BAM=bam/KRAS-N-P.bam
#
# VCF=vcf/KRAS-N-P.vcf.gz
#
# parameters for tumor samples
#
# BAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data_somatic/HG008/Liss_lab/Element-AVITI-20241216/HG008-T_Element-StdInsert_111x_GRCh38-GIABv3.bam
#
# BAM=bam/KRAS-T.bam
#
# VCF=vcf/KRAS-T.vcf.gz
```

The 'run' target with no specified parameters calls variants for the non-tumor cells of the study.
```
make -f gen_bottle.mk run
```

Next, call variants again from the same region in the tumor cell samples. 
```
make -f  gen_bottle.mk run \
  BAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data_somatic/HG008/Liss_lab/Element-AVITI-20241216/HG008-T_Element-StdInsert_111x_GRCh38-GIABv3.bam \
  BAM=bam/KRAS-T.bam \
  VCF=vcf/KRAS-T.vcf.gz
```

### Compare variant calls between samples and identify tumor-specific variants
### Compare your results to the gold standard DeepVariant calls (if available)
## Deliverable: Report with variant counts, tumor-specific variants, and comparison to gold standard.
