#!/bin/bash

#make script behave
set -xue -o pipefail

ACC=GCF_000848505.1

#---------No changes below line-----------------

#download genome zip, grab gff
datasets download genome accession $ACC --include gff3,gtf,genome
unzip -n ncbi_datasets.zip
