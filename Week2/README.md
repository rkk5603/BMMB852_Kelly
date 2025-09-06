### HW2. Exploring gff file use
### 1. About the organism
Peromyscus maniculatis bairdii, the eastern deer mouse. <br>
Hella cute.
![peromyscus_maniculatis](https://github.com/user-attachments/assets/344fb58d-56cf-453f-acc9-58ab7f943253)
### grabbing gff file 
`wget https://ftp.ensembl.org/pub/current_gff3/peromyscus_maniculatus_bairdii/Peromyscus_maniculatus_bairdii.HU_Pman_2.1.115.chr.gff3.gz | gunzip`
### 2. How many sequence regions (chromosomes) does the file contain? Expected 24 pairs (23 autosomal)
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
`cat data.gff | cut -f 3 | sort | uniq -c | sort -r | head -50`
### output:
`276147 exon` <br>
`270173 CDS`
  64852 biological_region
  27437 mRNA
  21112 gene
   2894 ncRNA_gene
   1182 snRNA
    677 pseudogenic_transcript
    677 pseudogene
    542 transcript
    529 snoRNA
    402 rRNA
    172 miRNA
     45 scRNA
     27 V_gene_segment
     24 region
     22 lnc_RNA
     13 five_prime_UTR
     12 three_prime_UTR
      3 J_gene_segment
      2 C_gene_segment
`
### 7. Having analyzed this GFF file, does it seem like a complete and well-annotated organism?
### 8. Share any other insights you might note.
