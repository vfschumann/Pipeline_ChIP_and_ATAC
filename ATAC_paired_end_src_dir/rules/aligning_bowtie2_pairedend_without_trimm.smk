#possibly there is a more elegant way to do this than to define the dir/files in the config file

FILES = config["bowtie2path"]
bowtie2_index = "/fast/AG_Ohler/Scott/danRer11/noAlt_danRer11"

rule align_bowtie2:
    input:
        fastq_1= lambda wc: config["fastq_path"]+"/"+FILES[wc.filename]+"_R1_001.fastq.gz",
        fastq_2= lambda wc: config["fastq_path"]+"/"+FILES[wc.filename]+"_R2_001.fastq.gz"
    params: 
        index=bowtie2_index
    output:
        sam= "mapped/mapped_{filename}.sam",
        log= "mapped/mapped_{filename}.bwt2.log"
    shell:
        "bowtie2 -p 4 -X 1500 --no-discordant --no-mixed -x {params.index} -1 {input.fastq_1} -2 {input.fastq_2} -S {output.sam} 2> {output.log}"

