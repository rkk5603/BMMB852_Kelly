### HW2. Exploring gff file use
### 1. About the organism
- Peromyscus maniculatis bairdii, prairie deer mouse. <br>
Hella cute.

![peromyscus_maniculatis_bairdii](https://github.com/user-attachments/assets/ee22feec-3827-475e-b87e-66cdc8eca401)
- Mossman2023, INaturalist 2023

### 2. How many sequence regions (chromosomes) does the file contain? Expected 24 pairs (23 autosomal)
- grab gff file
### input:
`wget https://ftp.ensembl.org/pub/current_gff3/peromyscus_maniculatus_bairdii/Peromyscus_maniculatus_bairdii.HU_Pman_2.1.115.chr.gff3.gz | gunzip`
- filter for sequence region features
### input:
`GFF=Peromyscus_maniculatus_bairdii.HU_Pman_2.1.115.chr.gff3.gz` <br>
`cat $GFF| grep sequence-region | wc -l`
### output:
`24`
### 3. How many features does the file contain?
- remove comments (#). Each remaining line is a feature
### input:
`cat $GFF | grep -v '#' > data.gff`
`cat data.gff | cut -f 3| wc -l`
### output:
`666944`
### 4. How many genes are listed for this organism? Expected ~ 22,000 protein-coding genes
- remove ncRNA and pseudogene features
### input:
`cat data.gff | cut -f 3 | grep gene | grep -v ncRNA_gene | grep -v pseudogene | wc -l'`
### output:
`21144`
### 5. Is there a feature type that you may have not heard about before? What is the feature and how is it defined? (If there is no such feature, pick a common feature.)
- Other features: mRNA, exon, CDS, biological region
- I had not seen "biological_region". After some digging, it looks like this is a feature for a broader region.
  These features could include other features (exon, CDS, ncRNA, etc) within them
### 6. What are the top-ten most annotated feature types (column 3) across the genome?
### input:
`cat data.gff | cut -f 3 | sort | uniq -c | sort -r | head -10`
### output:


     276147 exon
     270173 CDS
      64852 biological_region
      27437 mRNA
      21112 gene
       2894 ncRNA_gene
       1182 snRNA
        677 pseudogenic_transcript
        677 pseudogene
        542 transcript
     
### 7. Having analyzed this GFF file, does it seem like a complete and well-annotated organism?
- This annotation appears to have the right amount of protein-coding genes (21112 out of ~22,000 expected)
- There should be about 36,000 genes total, however, and including all gene features here only totals about 27,000. 

### 8. Share any other insights you might note.
- This screening was likely not as concerend with non-coding elements.
