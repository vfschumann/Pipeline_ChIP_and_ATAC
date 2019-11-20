rule samtools_singleend:
    input:
        "mapped/mapped_{sample}.sam"
    output:
        "samtools/sammark_mapped_{sample}.bam"
    threads: 4
    shell:
        " samtools view -@ {threads} -q 30 -uSbF 4 {input}| samtools sort -l 0 - |         samtools markdup -r -s - - |  samtools sort -l 0 - > {output}"
        
rule indexing_samtools:
        input:
              "samtools/sammark_mapped_{sample}.bam"
        output:
             "samtools/sammark_mapped_{sample}.bam.bai" 
        shell:
             "samtools index {input} {output}"

