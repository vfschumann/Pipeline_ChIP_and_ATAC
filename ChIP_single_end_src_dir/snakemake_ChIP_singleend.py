
configfile: '../src/config_ChIP_single_end_data.yaml' # path when path given in the qsub file is "projectdir/results" and if "src" is also a subdir of "projectdir"

FILE_NAME  = config["samples"]

#For macs2 
sample_names = config['samples']
sample_names = sample_names.keys()

list_of_base = []
for sample in list(sample_names):
    base = (sample.split('_')[0])
    if base not in list_of_base:
        list_of_base.append(base)
        
merged_sample_names = []
for samplename in FILE_NAME:
    if 'wt' in samplename:
        if 'rep1' in samplename:
            merged_sample_names.append(samplename[:-5])
    


rule all:
    input:
##bowtie2
        expand("mapped/mapped_{sample}.sam", sample=list(FILE_NAME.keys())),
        expand("mapped/mapped_{sample}.bwt2.log", sample=list(FILE_NAME.keys())),
#samtools
        expand("samtools/sammark_mapped_{sample}.bam", sample=list(FILE_NAME.keys())),
        expand("samtools/sammark_mapped_{sample}.bam.bai", sample=list(FILE_NAME.keys())),
#macs
        expand("macs/{base}_chip_rep{replicate}_peaks.narrowPeak", base=list_of_base, replicate=config['replicas']),
#bigWigs
        expand("bigWigs/{sample}_treat_pileup_sort.bigWig", sample=config["bigWigs"]),
        expand("bigWigs/{sample}_control_lambda_sort.bigWig", sample=config["bigWigs"]),
        expand("bigWigs/{sample}_subtract_sort.bigWig", sample=config["bigWigs"])
        
inlcude: "rules/trimming_cutadapt_singleend.smk" # include if sequencing adapters where identified with fastqc
inlcude: "rules/bowtie2_chip_with_ctdpt.smk" #inlcude IF trimming_cutadapt.smk is used
include: "rules/bowtie2_chip_without_ctdpt.smk" #inlcude IF NOT trimming_cutadapt.smk is used
include: "rules/samtools_singleend.smk"
include: "rules/macs2_Chip_singleend.smk"
include: "rules/generatingBigWig.smk"

