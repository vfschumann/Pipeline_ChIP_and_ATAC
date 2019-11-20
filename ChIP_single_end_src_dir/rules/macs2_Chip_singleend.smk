

rule macs2:
    input:
        data= "samtools/sammark_mapped_{base}_chip_rep{replicate}.bam",
        control= "samtools/sammark_mapped_{base}_input.bam"
    output:
        "macs/{base}_chip_rep{replicate}_peaks.narrowPeak"
    shell:
        "macs2 callpeak -t {input.data} -c {input.control} -g 1.6e+9  -f BAM --keep-dup all --outdir macs -n {wildcards.base}_chip_rep{wildcards.replicate} -B  -q 0.01" 

