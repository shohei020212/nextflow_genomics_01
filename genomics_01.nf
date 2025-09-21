#!/usr/bin/env nextflow

// Module INCLUDE statements
include { FASTQC } from './modules/fastqc.nf'
include { TRIMMOMATIC } from './modules/trimmomatic.nf'

// Primary input
params.input_csv = "data/testdata/paired-end.csv"
params.adapters = "data/testdata/adapter.fa"

workflow {

    // Create input channel from the contents of a CSV file
    reads_ch = Channel.fromPath(params.input_csv)
        .splitCsv(header:true)
        .map { row -> [file(row.fastq_1), file(row.fastq_2)] }

    // temporary diagnostics
    reads_ch.view()

    /// Initial quality control
    FASTQC(reads_ch)

    /// Trimming reads
    adapters = Channel.fromPath(params.adapters)
    TRIMMOMATIC(reads_ch, adapters) 
}
