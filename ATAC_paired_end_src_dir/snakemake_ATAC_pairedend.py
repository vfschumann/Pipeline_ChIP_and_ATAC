
configfile: '../src/config_ATAC_pairedend_data.yaml'

#######
# change this part the data dir of the projectdir

path_to_data = "/path/user/0_Projects/dataset/data/"

#change this to the path of the indexed reference genome (example below)

bowtie2_index = "/path/danRer11/noAlt_danRer11"

#######
    
FILE_NAME  = config["samples"]

merged_sample_names = []
for samplename in FILE_NAME:
    if 'wt' in samplename:
        if 'rep1' in samplename:
            merged_sample_names.append(samplename[:-5])
    

rule all:
    input:
#cutadpt
        expand("trimmed/ctadpt_{sample}_{read}.fastq.gz", sample=list(FILE_NAME.keys()), read=config["reads"]), 
#bowtie2
        expand("mapped/mapped_{sample}.sam", sample=list(FILE_NAME.keys())),
        expand("mapped/mapped_{sample}.bwt2.log", sample=list(FILE_NAME.keys())),
#samtools
        expand("samtools/sammark_mapped_{sample}.bam", sample=list(FILE_NAME.keys())),
        expand("samtools/sammark_mapped_{sample}.bam.bai", sample=list(FILE_NAME.keys())),
#macs
        expand("macs/{sample}_peaks.narrowPeak", sample=list(FILE_NAME.keys()))
#bigWigs
        expand("bigWigs/{sample}_treat_pileup_sort.bigWig", sample=config["bigWigs"]),
        expand("bigWigs/{sample}_control_lambda_sort.bigWig", sample=config["bigWigs"]),
        expand("bigWigs/{sample}_subtract_sort.bigWig", sample=config["bigWigs"])
    

include: "rules/trimming_cutadapt_pairedend.smk"  #include if sequencing adapters where identified with fastqc
include: "rules/aligning_bowtie2_pairedend_with_trimm.smk" #inlcude IF trimming_cutadapt.smk is used
include: "rules/aligning_bowtie2_pairedend_without_trimm.smk" #inlcude IF NOT trimming_cutadapt.smk is used
include: "rules/samtools_pairedend.smk"
include: "rules/macs2_ATAC_pairedend.smk"
include: "rules/generatingBigWig.smk"

