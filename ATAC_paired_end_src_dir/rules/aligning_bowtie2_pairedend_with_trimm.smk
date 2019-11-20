rule aligning_bowtie2:
        input:
            fastq_1 = "trimmed/ctadpt_{sample}_R1_001.fastq.gz",
            fastq_2 = "trimmed/ctadpt_{sample}_R2_001.fastq.gz"
        output:
            sam= "mapped/mapped_{sample}.sam",
            log= "mapped/mapped_{sample}.bwt2.log"
        params:
            index=bowtie2_index
        shell:
            "bowtie2 -p 4 -X 1500 --no-discordant --no-mixed -x {params.index} -1 {input.fastq_1} -2 {input.fastq_2} -S {output.sam} 2> {output.log}"
