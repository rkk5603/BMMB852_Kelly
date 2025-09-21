### 1. Identify the accession numbers for the genome and write the commands to download the data. Make your commands reusable and reproducible.
input:
```
efetch -db nuccore -format fasta -id AF086833 > ebola.fa
```
Accession numbers: AF086833 reference fasta, GCF_000848505.1 genbank gff assembly
### 2. Now use IGV to visualize the genome and the annotations relative to the genome. How big is the genomehow many features of each type does the GFF file contain? What is the longest gene? What is its name and function? Look at other gene names. Pick another gene and describe its name and function.
### genome size
input:
```
wc -l AF086833.fa
```
output:
```
272
```
input:
```
tail -271  AF086833.fa > ebola.fa | wc -c
```
output:
```
19230
```
### feature types in gff
input:
```
cat ebola1.gff | grep -v '#' | cut -f 3 | sort | uniq -c
```
output:
```
11 CDS
      7 exon
      1 five_prime_UTR
      7 gene
      7 mRNA
     17 region
      4 sequence_feature
      1 three_prime_UTR
```
### longest gene
input:
```
# grabs 'gene' entries, calculates length by difference in end and start position, sorts descending, and prints gene name

grep -P "\tgene\t" ebola1.gff | awk '{print $5 - $4, $0}' | sort -rnk1 | head -1 | cut -f 9
```
output:
```
ID=gene-L;Name=L;gbkey=Gene;gene=L;gene_biotype=protein_coding
```
This is the L gene. L gene is about 6.8kb long and encodes RNA polymerase. This is an essential gene to have, particularly if your genome limited to 7. This is an RNA-dependent RNA polymerase, which is needed to transcribe the viral RNA genome.

### GP gene
GP encodes glycoprotein. This is a membrane surface protein that aids in attachment to host cells
<img width="1124" height="518" alt="image" src="https://github.com/user-attachments/assets/6cae080e-b65e-470d-9190-9eed71f293b1" />

Visual inspection is consistent with metrics from command line. The genome is about 19kb long. L gene and its transcript are visually longer than the other features.

### 3. Look at the genomic features, are these closely packed, is there a lot of intragenomic space? Using IGV estimate how much of the genome is covered by coding sequences.
There does not appear to be much intragenomic space in the ebola virus genome.
```
VP24 ~1.5kb
VP30 ~1.5kb
VP35 ~1.5kb
VP40 ~1.5kb
GP ~2.5kb
NP ~3kb
L ~6.5kb
```
Coding sequences account for about 18kb of 19kb, about 95% of the genome.
### 4. Find alternative genome builds that could be used to perhaps answer a different question (find their accession numbers). Considering the focus of the paper, think about what other questions you could answer if you used a different genome build.
Other accession numbers: KJ660346.2, KR105345, KM233043. There are many assemblies within KJ*******, KR*******, and KM*******. This 2014 study compared viral genomes from individuals from 2004 to 2014 in Sierra Leone. There is an even older assembly from a sample from the 1976 outbreak in the Democatic republic of the Congo (GCF_000848505.1).  which could be used Comparison with this assembly could provide geographic and temporal information about the progression of ebola variants. 
