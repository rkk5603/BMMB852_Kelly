### The fetch_index_align.mk makefile has several targets.
- fetch: Obtains the genome and displays some summary stats
- fastq: Downloads sequencing reads from SRA
- index: Indexes the ref genome for ease of visualization
- align: Generates a BAM file by aligning reads to the genome
- stats: Displays summary stats on the generated BAM file
- clean: Removes unecessary files
- all: runs all targets
- .phony: runs sll targets, not files generated
### Visualize the resulting BAM files for both simulated reads and reads downloaded from SRA.

### Alignment statistics for the BAM file.
- What percentage of reads aligned to the genome?
- What was the expected average coverage?
  - 10x
- What is the observed average coverage?
- How much does the coverage vary across the genome? (Provide a visual estimate.)
