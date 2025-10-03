1. Transform the script into a Makefile that includes rules for:
Obtaining the genome
Downloading sequencing reads from SRA

2. Your README.md should explain the use of the Makefile in your project.

3. Add the following targets to the Makefile:

index: Index the genome
align: Generate a sorted and indexed BAM file by aligning reads to the genome

4. Visualize the resulting BAM files for both simulated reads and reads downloaded from SRA.

5. Generate alignment statistics for the BAM file.

What percentage of reads aligned to the genome?
What was the expected average coverage?
What is the observed average coverage?
How much does the coverage vary across the genome? (Provide a visual estimate.)
