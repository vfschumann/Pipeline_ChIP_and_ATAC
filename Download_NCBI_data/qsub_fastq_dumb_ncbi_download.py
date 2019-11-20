#!/usr/bin/python

#$ -N <name>    # name of the job
#$ -m ea                   # send an email when end or job aborted 
#$ -M email@adress.com 
#$ -j y                        # combine error with stdout
#$ -o log_sradownload.stdlog      # default filename for stdout and error file 
#$ -l h_vmem=20G    # limit memory request
#$ -l h_stack=128M    # often not needed, but a few programs require it
#$ -pe smp 5            # smp parallel environment

# I have this in every qsub file, so that I know what the job was, what node it was on if there are problems, and the resources I requested

############
# !!!!change to your working src directory here!!!! Example below
############

#$ -wd   /home/vfschumann/0_Projects/DataSet1/src    # working dir

##############

# BODY: run the program of interest 

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

    subprocess.call(['/home/vschuma/.guix-profile/bin/fastq-dump --gzip --split-files  --outdir ../data/ {}'.format(number)], 
shell=True)
    
######
# choose depending on whether you're going to download paired or single end data (comment the other option out)

    #for single-end
    subprocess.call(['mv {}_1.fastq.gz {}.fastq.gz'.format(number,name)], shell=True)
    # for paired-end
    subprocess.call(['mv {}_1.fastq.gz {}_1.fastq.gz'.format(number,name)], shell=True)
    subprocess.call(['mv {}_2.fastq.gz {}_2.fastq.gz'.format(number,name)], shell=True)