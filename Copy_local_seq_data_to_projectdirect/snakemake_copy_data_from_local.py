import os

configfile: "config_local_data.yaml"

def get_fastq_files():
    wc_path = os.path.join(config["fastq_path"], "{dir}", "{name}_R{read}_001.fastq.gz")
    (dirs, names, reads) = glob_wildcards(wc_path)
    files = [wc_path.format(dir=d, name=n, read=r) for (d,n,r) in zip(dirs, names, reads)]
    return {'{}_R{}'.format(n,r):f for (n,r,f) in zip(names, reads, files)}

FASTQ_FILES = get_fastq_files()

rule all:
    input:
        expand("../data/{id}.fastq.gz", id=list(FASTQ_FILES.keys()))

rule copy_data_to_working_dir:
    input: lambda wc: FASTQ_FILES[wc.id]
    output: 
        '../data/{id}.fastq.gz'
    shell:
        "cp {input} {output}"

