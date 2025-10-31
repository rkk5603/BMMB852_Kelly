### The fetch_index_align.mk makefile has several targets.
- fetch: Obtains the genome and displays some summary stats
- fastq: Downloads sequencing reads from SRA
- index: Indexes the ref genome for ease of visualization
- align: Generates a BAM file by aligning reads to the genome
- stats: Displays summary stats on the generated BAM file
- clean: Removes unecessary files
- all: runs all targets
- .phony: runs all targets, no files generated
### Alignment statistics for the BAM file.
Boy howdy am I at a loss here
- Percentage of reads aligned to the genome: 0.01% :(
- Expected average coverage: 100x
- Observed average coverage: C = LN/G = (200*13)/19000 = 0.14x :(
- ```
  samtools coverage bam/SRR1972976.bam | cut -f 6
  ```
- How much does the coverage vary across the genome? (Provide a visual estimate.)
<img width="1383" height="488" alt="SRR1972976_coverage2" src="https://github.com/user-attachments/assets/d772ebcf-a7bd-4409-843e-efe595fa0946" />
Most regions have zero coverage, while a couple have 2 or 3x
