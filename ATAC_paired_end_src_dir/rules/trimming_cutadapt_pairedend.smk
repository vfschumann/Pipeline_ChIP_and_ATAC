import os

adapter_per_read = config['adapters_per_read']
sample_name = config['samples']

rule trimming_paired_end:
        input:
            read1 = lambda wc: os.path.join(path_to_data, sample_name[wc.real_file_name])+"_1.fastq.gz",
            read2 = lambda wc: os.path.join(path_to_data, sample_name[wc.real_file_name])+"_2.fastq.gz"
        output:
            read1 = "trimmed/ctadpt_{real_file_name}_1.fastq.gz",
            read2 = "trimmed/ctadpt_{real_file_name}_2.fastq.gz"
        params:
             read1 = "-a {}".format(config["adapters"][0]),
             read2 ="-A {}".format(config["adapters"][1])
        shell:
            "cutadapt {params.read1} {params.read2} -o {output.read1} -p {output.read2} {input.read1} {input.read2}"    


