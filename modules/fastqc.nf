#!/usr/bin/env nextflow

process FASTQC {

    container "community.wave.seqera.io/library/fastqc:0.12.1--df99cb252670875a"
    publishDir "results/fastqc", mode: 'symlink'

    input:
    tuple path(read1), path(read2)

    output:
    path "*_1_fastqc.{zip,html}", emit: fastqc_reports_1
    path "*_2_fastqc.{zip,html}", emit: fastqc_reports_2

    script:
    """
    fastqc ${read1} ${read2}
    """
}
