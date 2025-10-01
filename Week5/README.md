### BioProject and SRR accession numbers for the Gire _et al._ 2014 Ebola virus seq data
- Bioproject: PRJNA257197
- ACC: AF086833
- ACC: KM233118
- SRR for a data set: SRR1972976

### 1. Bash script for downloading a data set
The fetch.sh script retrieves the RNA seq data set from the 2014 Ebola virus paper.

### 2. Script for genome length and features
The genome_features.sh script displays the length of the genome (Ebola virus), the different features and their counts from the GFF file, and the longest gene in the genome.

### 3. Download only a subset of the data for 10x genome coverage and provide number of reads, total bases, and average read length
The fetch_reads_quality.sh script fetches only enough reads from the SRR1972976 fastq file for 10x coverage.

- C=(LN)/G or N=(CG)/L
- L: read length
- N: number of reads
- G: genome length
- number of reads for 10x coverage=(10*19000)/200
- =950 reads

### 4. Run FASTQC on the downloaded data to generate a quality report.
The fastqc.sh script generates quality reports for the retrieved reads for SRR1972976.

### 5. Evaluate the FASTQC report and summarize your findings.
<img width="1213" height="788" alt="fastqc_forward_ebola1" src="https://github.com/user-attachments/assets/fd664233-1d80-440a-99a4-f565d5e36000" />
The read quality is not great. The GC content is a bit high, and the median quality is pretty poor meaning uncertain base calls. Also, the reads still have adapter sequences.

### 6. Comparing quality of another dataset for the same genome
- SRR1640364: PacBio long reads instead of NextGen short reads
<img width="1212" height="759" alt="image" src="https://github.com/user-attachments/assets/c3f27871-44ae-41bf-9a0f-62188b9a3c79" />
Woah! Base quality is a bit better than the short reads quality. The GC content and overrepresented sequences still failed, but the adapters have already been removed. Or maybe adapter ligating is different for long reads... I'm not sure how long read library preps work :(

### (optional) Perform quality control steps (e.g., trimming, filtering)
The fasta_read_quality.sh script does it all (steps 3-5, plus qc). This script takes user input and will work for any valid SRR number.
