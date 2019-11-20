
rule macs2:
    input:
        "samtools/sammark_mapped_{sample}.bam"
    output:
        "macs/{sample}_peaks.narrowPeak"
    params:
        samplename = list(FILE_NAME.keys())
    shell:
        "macs2 callpeak -t {input} -g 1.6e+9  -f BAMPE --keep-dup all         --nomodel --shift -100 --extsize 200         --outdir macs -n {wildcards.sample} -B  -q 0.01" 

