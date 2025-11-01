# Call variants from BAM files
### The bcf target calls variants from a user-provided SRR  

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
The merge target combines all .vcf.gz files into one .vcf.gz file.
```
make merge
```
<img width="1913" height="623" alt="multivcf" src="https://github.com/user-attachments/assets/0bd90f8a-de5c-4da3-b1b9-bd13a7ba7e98" />

Several samples exhibit poor variant calling.
- SRS908478* SRS908484* SRS803915*
<img width="1920" height="560" alt="multivcf" src="https://github.com/user-attachments/assets/55ec6d37-11b9-494f-8dd1-a87e2057eeb0" />

