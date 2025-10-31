# Call variants on a single sample
### The VCF target generates calls variants from a user-provided SRR  

Use your existing BAM file as input
Generate a VCF file for this sample
Visualize the resulting VCF file data alongside the BAM file

In you markdown show how your Makefile should be used to call variants on a single sample.

Run the variant calling workflow for all samples using your design.csv file.

Create a multisample VCF

Merge all individual sample VCF files into a single multisample VCF file (hint: bcftools merge)

Visualize the multisample VCF in the context of the GFF annotation file.

If any samples show poor alignment or no variants, identify and replace them with better samples. Ensure you have sufficient genome coverage across all samples
