#assignment 3, visualizing genomic data

Version.

#Use IGV to visualize your genome and the annotations relative to the genome.
### 1. How big is the genome, and how many features of each type does the GFF file contain?

```
#grab gff file, unzip, rename
wget https://ftp.ensemblgenomes.ebi.ac.uk/pub/metazoa/release-62/gff3/apis_mellifera/Apis_mellifera.Amel_HAv3.1.62.gff3.gz

gunzip Apis_mellifera.Amel_HAv3.1.62.gff3.gz

mv Apis_mellifera.Amel_HAv3.1.62.gff3.gz amel.gff

#fasta file
wget https://ftp.ensemblgenomes.ebi.ac.uk/pub/metazoa/release-62/fasta/apis_mellifera/dna/Apis_mellifera.Amel_HAv3.1.dna.toplevel.fa.gz

gunzip Apis_mellifera.Amel_HAv3.1.dna.toplevel.fa.gz

mv Apis_mellifera.Amel_HAv3.1.dna.toplevel.fa.gz fasta_amel.fa 

#genome size, ~225 million base pairs
seqkit stats fasta_amel.fa
file           format  type  num_seqs      sum_len  min_len      avg_len     max_len
fasta_amel.fa  FASTA   DNA        177  225,250,884    2,302  1,272,603.9  27,754,200

#number of features in amel.gff
 cat amel.gff | cut -f 3 | grep -v '#' | sort | uniq -c | sort
      1 guide_RNA
     14 snoRNA
     26 snRNA
     42 pseudogene
     42 pseudogenic_transcript
     57 rRNA
    177 region
    218 tRNA
    238 pre_miRNA
    248 miRNA
   2412 ncRNA_gene
   3146 lnc_RNA
   9944 gene
  24184 three_prime_UTR
  24420 mRNA
  37242 five_prime_UTR
 226454 CDS
 267978 exon

```
### 2. From your GFF file, separate the intervals of type "gene" or "transcript" into a different file. Show the commands you used to do this.

```
# use awk function to search 3rd column for exact string "gene" and send the entire line to a new file
awk '$3 == "gene"' amel.gff > amel_lite.gff

# same function for transcripts (non-protein coding full RNA transcript features), append to file, not overwrite. Tedious.
awk '$3 == "snoRNA"' amel.gff > amel_lite.gff
awk '$3 == "guide_RNA"' amel.gff >> amel_lite.gff
awk '$3 == "snRNA"' amel.gff >> amel_lite.gff
awk '$3 == "rRNA"' amel.gff >> amel_lite.gff
awk '$3 == "tRNA"' amel.gff >> amel_lite.gff
awk '$3 == "miRNA"' amel.gff >> amel_lite.gff
awk '$3 == "ncRNA_gene"' amel.gff >> amel_lite.gff
awk '$3 == "lnc_RNA"' amel.gff >> amel_lite.gff

```

### 3. Visualize the simplified GFF in IGV as a separate track. Compare the visualization of the original GFF with the simplified GFF.
<img width="1918" height="489" alt="hw3_mutliplegff" src="https://github.com/user-attachments/assets/7a070976-5004-4cd1-8918-3cf76b04648d" />

- The peaks present in the original GFF are still present in the simplified GFF. The peaks of the simplified GFF appear to be greater now though. I suspect the intensity is relative to all features in the file, so the removal of other entries makes the exisitng peaks greater.

### 4. Zoom in to see the sequences, expand the view to show the translation table in IGV. Note how the translation table needs to be displayed in the correct orientation for it to make sense.
<img width="1901" height="460" alt="IGV_aaSeq" src="https://github.com/user-attachments/assets/a5e3a996-8c98-4b21-a75d-97f4bf45783f" />

### 5. Visually verify that the first coding sequence of a gene starts with a start codon and that the last coding sequence of a gene ends with a stop codon.
Gene LOC102655904. The first open reading frame has a sequence with start codon towards the start of the gene and a sequence downstream with a stop codon.
<img width="1513" height="386" alt="image" src="https://github.com/user-attachments/assets/e2a10c05-744e-4a2e-8b58-607f76df8d1d" />
<img width="1180" height="441" alt="image" src="https://github.com/user-attachments/assets/7bbccf64-ae29-4f56-8ec3-375e818d8055" />

