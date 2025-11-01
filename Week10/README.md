# Call variants on a single sample
### The VCF target generates calls variants from a user-provided SRR  

The bcf target uses bcftools to call variants in four steps
1. mpileup uses the BAM file from the upstream Makefile output and the reference genome to calculate genotype liklihood at each base
2. call calls variants
3. norm normalizes variants (left-aligns indels, splits multiallelic sites, and checks reference alleles)
4. sort aligns variants in VCF file by chromosome position

The Makefile can be called for a single sample
```
make bcf SRR=SRR1972976 SAMPLE=ebola
```
<img width="1408" height="482" alt="SRR1972976vcf" src="https://github.com/user-attachments/assets/295c8bd3-7eaa-4258-a9da-9065d8a1c390" />

The Makefile can be called for multiple samples in a design.csv file
```
cat design.csv | parallel --colsep , --header : --lb -j 2 make SRR={Run} SAMPLE={Sample} bcf
```
### Merge all individual sample VCF files into a single multisample VCF file (hint: bcftools merge)
### Visualize the multisample VCF in the context of the GFF annotation file.
### If any samples show poor alignment or no variants, identify and replace them with better samples. Ensure you have sufficient genome coverage across all samples
