# Week 1 assignment. Using simple bash commands to navigate directories, and formatting in github.


### 5. What version is your samtools command in the bioinfo environment? Version 1.20
### input:
```micromamba activate bioinfo```<br>
```samtools```
### output:
```Program: samtools (Tools for alignments in the SAM format)
  Version: 1.20 (using htslib 1.20)

  Usage:   samtools <command> [options]

  Commands:
  
    -- Indexing
       dict           create a sequence dictionary file
       faidx          index/extract FASTA
       fqidx          index/extract FASTQ
       index          index alignment

    -- Editing
       calmd          recalculate MD/NM tags and '=' bases
       fixmate        fix mate information
       reheader       replace BAM header
       targetcut      cut fosmid regions (for fosmid pool only)
       addreplacerg   adds or replaces RG tags
       markdup        mark duplicates
       ampliconclip   clip oligos from the end of reads

    -- File operations
       collate        shuffle and group alignments by name
       cat            concatenate BAMs
       consensus      produce a consensus Pileup/FASTA/FASTQ
       merge          merge sorted alignments
       mpileup        multi-way pileup
       sort           sort alignment file
       split          splits a file by read group
       quickcheck     quickly check if SAM/BAM/CRAM file appears intact
       fastq          converts a BAM to a FASTQ
       fasta          converts a BAM to a FASTA
       import         Converts FASTA or FASTQ files to SAM/BAM/CRAM
       reference      Generates a reference from aligned data
       reset          Reverts aligner changes in reads

    -- Statistics
       bedcov         read depth per BED region
       coverage       alignment depth and percent coverage
       depth          compute the depth
       flagstat       simple stats
       idxstats       BAM index stats
       cram-size      list CRAM Content-ID and Data-Series sizes
       phase          phase heterozygotes
       stats          generate stats (former bamcheck)
       ampliconstats  generate amplicon specific stats

    -- Viewing
       flags          explain BAM flags
       head           header viewer
       tview          text alignment viewer
       view           SAM<->BAM<->CRAM conversion
       depad          convert padded BAM to unpadded BAM
       samples        list the samples in a set of SAM/BAM/CRAM files

    -- Misc
       help [cmd]     display this help message or help for [cmd]
       version        detailed version information
  
  (bioinfo)
```

### 6. commands for nested directory structure
### input:
```mkdir -p DIR1/DIR2/DIR3```
  
### 7. commands for files in different directories
### input:
```touch DIR1/bees.txt```<br>
```touch DIR1/DIR2/knees.py```
### 8. access file with relative and absolute paths
### absolute, input:
```view /home/biouser/work/dir1/bees.txt```
### relative, input:
```view ../work/dir1/dir2/knees.py```

### 9. commit and push changes to repository
### input:
```git commit -am "added file for assignment 1"``` <br>
```git push```


