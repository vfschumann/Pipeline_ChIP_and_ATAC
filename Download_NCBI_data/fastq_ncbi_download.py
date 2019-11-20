import yaml
import subprocess
# download "sra-tools" https://github.com/ncbi/sra-tools

print("let's start downloading")

###########
# change config file

with open("config_ncbi_data_set.yaml", "r") as config_file:
        config = yaml.safe_load(config_file)
##########
        
sra_files = config['samples'] 

for name, number in sra_files.items():
    print("Downloading", number)
########
# change path for fastq-dump

    subprocess.call(['/home/user/.guix-profile/bin/fastq-dump --gzip --split-files  --outdir ../data/ {}'.format(number)], 
shell=True)
    
######
# choose depending on whether you're going to download paired or single end data (comment the other option out)

    #for single-end
    subprocess.call(['mv {}_1.fastq.gz {}.fastq.gz'.format(number,name)], shell=True)
    # for paired-end
    subprocess.call(['mv {}_1.fastq.gz {}_1.fastq.gz'.format(number,name)], shell=True)
    subprocess.call(['mv {}_2.fastq.gz {}_2.fastq.gz'.format(number,name)], shell=True)