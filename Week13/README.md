# Generate a genome-based RNA seq count matrix
- You will need a genome reference and a GTF/GFF annotation file.
- Select at least 6 SRR datasets from the same project, 3 for control and 3 for treatment.

First, reads were retrieved 
### 1. Align the reads to the genome and create BAM and BigWig files.

### 2. Run a feature counter to create a count matrix for your data. 
- The result of your code should be a matrix that summarizes read counts for each dataset.

### 3. Include IGV screenshots that demonstrate your data is RNA-Seq data.

### 4. Discuss a few lines of the resulting count matrix. 
- Visually identify rows where the counts show consistent gene expression levels.
- Try to visually verify that the counts in the count matrix are consistent with the numbers you can observe in the alignment tracks.
