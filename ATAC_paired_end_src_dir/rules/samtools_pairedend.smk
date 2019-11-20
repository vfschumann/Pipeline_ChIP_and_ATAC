rule samtools_paired_end:
    input:
         "mapped/mapped_{sample}.sam"
    output:
        "samtools/sammark_mapped_{sample}.bam"
    shell:
         "samtools view -@ {threads} -q 30 -SbF 4 {input} | samtools sort -l 0 -n - | \
          samtools fixmate -rm - - | samtools sort -l 0 - | samtools markdup -r -s - - | \
              samtools sort -l 0 - > {output}"
            
rule indexing_samtools:
        input:
              "samtools/sammark_mapped_{sample}.bam"
        output:
             "samtools/sammark_mapped_{sample}.bam.bai" 
        shell:
             "samtools index {input} {output}"   

