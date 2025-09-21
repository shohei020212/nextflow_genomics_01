#!/bin/bash -ue
trimmomatic PE -threads 2 -phred33 -trimlog log.txt \
ENCSR000COQ2_1.fastq.gz ENCSR000COQ2_2.fastq.gz \
ENCSR000COQ2_1_trimmed.fastq.gz ENCSR000COQ2_1_unpaired.fastq.gz \
ENCSR000COQ2_2_trimmed.fastq.gz ENCSR000COQ2_2_unpaired.fastq.gz \
ILLUMINACLIP:adapter.fa:2:30:10 \
LEADING:20 \
TRAILING:20 \
SLIDINGWINDOW:4:15 \
MINLEN:0
