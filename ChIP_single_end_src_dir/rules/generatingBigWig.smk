rule bdgSort:
    input:
        "macs/{sample}_treat_pileup.bdg"
    output:
        "bigWigs/{sample}_treat_pileup_sort.bedGraph"
    shell:
        "bedtools sort -i {input} > {output}"
rule bdg2bigWig:
    input:
        "bigWigs/{sample}_treat_pileup_sort.bedGraph"
    params:
        "https://hgdownload-test.gi.ucsc.edu/goldenPath/currentGenomes/Danio_rerio/bigZips/danRer11.chrom.sizes"
    output:
        "bigWigs/{sample}_treat_pileup_sort.bigWig"
    shell:
        "/home/vschuma/bin/bedGraphToBigWig {input} {params} {output}"
        
# control bigWig
rule bdgSortCtl:
    input:
        "macs/{sample}_control_lambda.bdg"
    output:
        "bigWigs/{sample}_control_lambda_sort.bedGraph"
    shell:
        "bedtools sort -i {input} > {output}"
rule bdg2bigWigCtl:
    input:
        "bigWigs/{sample}_control_lambda_sort.bedGraph"
    params:
        "https://hgdownload-test.gi.ucsc.edu/goldenPath/currentGenomes/Danio_rerio/bigZips/danRer11.chrom.sizes"
    output:
        "bigWigs/{sample}_control_lambda_sort.bigWig"
    shell:
        "/home/vschuma/bin/bedGraphToBigWig {input} {params} {output}"
# subtract control from treatment
rule bdgcomp:
    input:
        treatment="bigWigs/{sample}_treat_pileup_sort.bedGraph",
        control="bigWigs/{sample}_control_lambda_sort.bedGraph"
    output:
        "bigWigs/{sample}_subtract.bedGraph"
    shell:
        "macs2 bdgcmp -t {input.treatment} -c {input.control} -m subtract -o {output}"
rule subSort:
    input:
        "bigWigs/{sample}_subtract.bedGraph"
    output:
        "bigWigs/{sample}_subtract_sort.bedGraph"
    shell:
        "bedtools sort -i {input} > {output}"
rule sub2bigWig:
    input:
        "bigWigs/{sample}_subtract_sort.bedGraph"
    params:
        "https://hgdownload-test.gi.ucsc.edu/goldenPath/currentGenomes/Danio_rerio/bigZips/danRer11.chrom.sizes"
    output:
        "bigWigs/{sample}_subtract_sort.bigWig"
    shell:
        "/home/vschuma/bin/bedGraphToBigWig {input} {params} {output}"