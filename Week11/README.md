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
