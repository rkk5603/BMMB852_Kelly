### The fetch_index_align.mk makefile has several targets.
- fetch: Obtains the genome and displays some summary stats
- fastq: Downloads sequencing reads from SRA
- index: Indexes the ref genome for ease of visualization
- align: Generates a BAM file by aligning reads to the genome
- stats: Displays summary stats on the generated BAM file
- clean: Removes unecessary files
- all: runs all targets
- .phony: runs all targets, no files generated
### Visualize the resulting BAM files for both simulated reads and reads downloaded from SRA.

### Alignment statistics for the BAM file.
- Percentage of reads aligned to the genome: 0.01% :(
- Expected average coverage: 100x
- Observed average coverage: 4.69% :(
- ```
  samtools coverage bam/SRR1972976.bam | cut -f 6
  ```
- How much does the coverage vary across the genome? (Provide a visual estimate.)
