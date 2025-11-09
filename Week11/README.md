### Evaluate the effects of the variants in a VCF file
The effect target in the Makefile runs snpEff to predict the effects of variants previously called with bcf. First, a genome-specific database needs to be downloaded with effect_db. The ebola_zaire database is retrieved by default, but a database can be specified with SNPEFFDB=[database name]
```
make effect_db
```

Now, effect can be called with a VCf file for a single sample and the appropirate database.
```
make effect SAMPLE=SRS803841
```

Or with a previously merged VCF file with multiple samples.
```
make effect SAMPLE=merged
```

Originally, I performed all alignments and variant calling with accession number NC_002549.1. The only prebuilt ebola database uses accession number KJ660346.1. Consequently, this command runs with an error: ERROR_CHROMOSOME_NOT_FOUND 495, since the chromosome names do not match. Boy howdy was this a nightmare. Because I couldn't be bothered to try a different variant predictor like VEP, I tried three different ways to attempt to swap out the chromosome name in my VCF file. This didn't work. After rerunning my alignment with the KJ660346.1 accession, I can run snpEff without the error. However, the summary is not successful.
<img width="681" height="917" alt="image" src="https://github.com/user-attachments/assets/d3a91bac-0df1-4860-bdbb-8e783f443b05" />

### Identify variants with different effects.
Success! After clearing all reference files (fasta, gff, and anything indexed), I retrieved fasta and gff files for KJ660346.1. Bio fetch did not work for fasta format for this particular accession number, so this worked:
```
esearch -db Nucleotide -query KJ660346.1 | efetch -format fasta > reffs/ebola.fa
```

That command did not work for gff format, but this worked:
```
bio fetch KJ660346.1 -f gff > refs/ebola.gff
```

After rerunning the essential bits:
1. Indexing the reference genome
```
make index
```

2. Rerunning the alignment on the design.csv file
```
cat design.csv | parallel --colsep , --header : --lb -j 2 make SRR={Run} SAMPLE={Sample} align
```

3. Calling variants for those samples
```
cat design.csv | parallel --colsep , --header : --lb -j 2 make SRR={Run} SAMPLE={Sample} bcf
```

I was able to run snpEff on one of the samples
```
make effect SAMPLE=SRS803820
```

<img width="796" height="842" alt="image" src="https://github.com/user-attachments/assets/b3fccd27-f310-4f57-a95c-e2e9cca8572d" />

And the merged VCF file
```
make effect SAMPLE=merged
```

<img width="755" height="939" alt="image" src="https://github.com/user-attachments/assets/3f3fff30-c9b3-40fb-9d67-d9c0302a2830" />

The merged VCF exhibits mostly SNPs and one indel! Most of the variants are upstream or down stream of the coding and intronic regions.

