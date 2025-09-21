### 1. Identify the accession numbers for the genome and write the commands to download the data. Make your commands reusable and reproducible.
input:
```
efetch -db nuccore -format fasta -id AF086833 > ebola.fa
```
other accession numbers: KJ660346.2, KR105345, KM233043
### 2. Now use IGV to visualize the genome and the annotations relative to the genome. How big is the genome, and how many features of each type does the GFF file contain? What is the longest gene? What is its name and function? Look at other gene names. Pick another gene and describe its name and function.

### 3. Look at the genomic features, are these closely packed, is there a lot of intragenomic space? Using IGV estimate how much of the genome is covered by coding sequences.

### 4. Find alternative genome builds that could be used to perhaps answer a different question (find their accession numbers). Considering the focus of the paper, think about what other questions you could answer if you used a different genome build.
