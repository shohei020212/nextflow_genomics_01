#!/usr/bin/env nextflow

process TRIMMOMATIC {

    container "community.wave.seqera.io/library/trimmomatic:0.40--d0d39a8c6102506c"
    publishDir "results/trimmomatic", mode: 'symlink'

    input:
    tuple path(read1), path(read2)
    path adapters

    output:
    tuple path("${read1.simpleName}_trimmed.fastq.gz"), path("${read2.simpleName}_trimmed.fastq.gz"), emit: trim_reads

    script:
    """
    trimmomatic PE -threads 2 -phred33 -trimlog log.txt \\
    ${read1} ${read2} \\
    ${read1.simpleName}_trimmed.fastq.gz ${read1.simpleName}_unpaired.fastq.gz \\
    ${read2.simpleName}_trimmed.fastq.gz ${read2.simpleName}_unpaired.fastq.gz \\
    ILLUMINACLIP:${adapters}:2:30:10 \\
    LEADING:20 \\
    TRAILING:20 \\
    SLIDINGWINDOW:4:15 \\
    MINLEN:0
    """
}



