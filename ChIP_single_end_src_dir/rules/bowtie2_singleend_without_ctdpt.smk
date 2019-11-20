rule aligning_bowtie2:
        input:
            "../data/{sample}.fastq.gz"
        output:
            sam= "mapped/mapped_{sample}.sam",
            log= "mapped/mapped_{sample}.bwt2.log"
        params:
            index=bowtie2_index
        shell:
            " bowtie2  --sensitive -x {params.index} -U  {input} -p 4 -S {output.sam} 2> {output.log}"

