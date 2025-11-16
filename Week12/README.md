# HW 11 Evaluating cancer variants
## Produce and evaluate variant calls
Here we will generate variant calls from the Cancer Genome in a Bottle data and evaluate their quality. The gen_bottle.mk Makefile retrieves the reference genome, retrieves a subset of reads from a BAM for a specified region, and then identifes variants.
### Makefile targets
- get_ref: Retireves and indexes the reference genome. This only needs to be run once.
- reads: Retrieves and indexes a portion of a BAM file from this study.
- variants: Calls a separate bcf.mk makefile (aka Makefile detailed from previous assignments) to identify variants.
- run: Runs reads and variants (no need to run get_ref again)
The 'run' target is called twice; we will identify variants from normal cell samples and then again from tumor cell samples to compare.

### Call variants for normal and tumor samples in a region of interest
1. First, retrieve the reference genome. This analysis focuses on a region of chromosome 12 by default.
```
make -f gen_bottle.mk get_ref
```

2. Next, retrieve a subset of reads from the region of interest for both tumor and non tumor cell samples. 
- The 'run' target with no specified parameters calls variants for the non-tumor cells of the study. The 'usage' target displays the three parameters to change to perform this for tumor cell samples.
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
- Normal cell sample variants:
```
make -f gen_bottle.mk run
```
- Tumor cell samples variants: 
```
make -f  gen_bottle.mk run \
  BAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data_somatic/HG008/Liss_lab/Element-AVITI-20241216/HG008-T_Element-StdInsert_111x_GRCh38-GIABv3.bam \
  BAM=bam/KRAS-T.bam \
  VCF=vcf/KRAS-T.vcf.gz
```

### Compare variant calls between samples and identify tumor-specific variants
Now call a separate snpeval.mk Makefile (modified from the src toolkit) to compare variant calls between samples. The 'run' target executes two targets:
- intersect: Identifies variants that are unique to the tumor cells.
- filter: Removes false positives from the tumor sample
 
```
make -f snpeval.mk run
```

### Compare your results to the gold standard DeepVariant calls (if available)
Upon visualization with IGV, it appears there is a single variant unique to the tumor cell sample (within the region of interest, the Kras gene on chr 12).

<img width="194" height="554" alt="image" src="https://github.com/user-attachments/assets/852d3c7c-3d78-41ea-af48-a5306f5906cd" />

However, after screening for false positives, this variant is removed lol.
<img width="1899" height="452" alt="uniqvariants" src="https://github.com/user-attachments/assets/fa8e7a09-c971-44ee-aeec-b3d524f77911" />

Interestingly, the gold standard also identifed a single unique cancer variant in this region. It is, of course, not the same one I identified. 
<img width="199" height="612" alt="image" src="https://github.com/user-attachments/assets/919d4ee7-d2f4-4e85-b58e-0fd875df175b" />

