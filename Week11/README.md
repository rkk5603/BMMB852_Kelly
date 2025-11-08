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

This command runs with an error: ERROR_CHROMOSOME_NOT_FOUND 495
If, for some reason, you can't make any of the variant effect prediction software work, you may use visual inspection via IGV to describe the effect of variants relative to a reference genome and an annotation file.

### Identify variants with different effects.
