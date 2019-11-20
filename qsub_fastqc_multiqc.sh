#!/bin/bash
#######
# change mail-adress, working directory, m_mem_free, h_rt
####
##
#
#$ -N fastqc_multiqc    # name of the job
#$ -m ea                   # send an email when end or job aborted 
#$ -M <mail.adress> 
#$ -wd   /path/user/0_Projects/dataset/src    # working dir
#$ -j y                        # combine error with stdout
#$ -o log_sradownload.stdlog      # default filename for stdout and error file 
#$ -l m_mem_free=20G    # limit memory request
#$ -l h_stack=128M    # often not needed, but a few programs require it
#$ -l h_rt=05:00:00
#$ -pe smp 1            # smp parallel environment



# I have this in every qsub file, so that I know what the job was, what node it was on if there are problems, and the resources I requested

echo "==================="
date
echo "job: "
echo "jobID: "
echo "node: "max162.mdc-berlin.net
/opt/uge/bin/lx-amd64/qstat -f -j  | grep
"job_number\|usage\|resource_list\|job_args\|stdout_path_list"
echo "==================="



# BODY: run the program of interest 

# download fastqc https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
# download multiqc https://github.com/ewels/MultiQC

######
# change path to guix repo here

source /home/user/.guix-profile/etc/profile # source your guix profile to have access to all your tools

#####

fastqc -o ../results/fastqc ../data/*fastq.gz 
 
multiqc . ../results/fastqc/ #multiqc sums up all the fastqc reports and makes them comparable and analysable all at once


# at the bottom of every qsub file I have the below so that I know the resources that were used for that particular job. I do get this in the final email, but sometimes it's nicer to have it searchable in the log file.

/opt/uge/bin/lx-amd64/qstat -f -j  | grep "usage\|resource_list"
