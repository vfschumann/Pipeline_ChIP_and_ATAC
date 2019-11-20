rule trimming_cutadapt: 
        input:
            "../data/{sample}.fastq.gz"
        output:
            "trimmed/ctadpt_{sample}.fastq.gz"
        params:
             "-a {}".format(config["adapters"])
        shell:
            "cutadapt {params} -o {output} {input}"