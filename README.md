# Pipeline_ChIP_and_ATAC

## Walkthrough
It is recommended to start with a *Projectdir/src* directory where all the used snakemake, config, qsub files go (without subdirectories) and a subdriectory called "rules" with the used snakemake rules. The rest of the structure will be build by the snakemake scripts. Of course you can use another structure but then you have to go through all the path definitions and input and output fields of the snakemake rules. 

### Data download
If you need do download published data sets from NCBI with sra number:
* You need to install 
    * sra-tools https://github.com/ncbi/sra-tools
* Use the dir *Download_NCBI_data*
    * Edit the config files as written in the comments 
    * either use the .py file or the cluster script and edit it as written in the comments

If you have the sequencing data in your local network it is recommended to copy the data files to your working directory:
* Use the dir *Copy_local_seq_data_to_projectdirect+
   *  Edit the config files as written in the comments 
   * you can then run *snakemake_copy_data_from_local.py* either within the terminal or as a cluster job
   
* If you did the setup as described and ran the data-scripts you should end up with this file structure:  
   * Projectdirectory:  
         * src
           * rules
           * config_files.yaml
           * snakemake_files.py
           * qsub_files.sh
         * data
           * datafiles
           
### Quality control
* You need to install
   * fastqc https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
   * multiqc https://multiqc.info/
* put *qsub_fastqc_multiqc.sh* to */src* and run it 
* from the multiqc.html figure out if it identified any adapter sequences

### Processing
* choose:
   * *ChIP_single_end_src_dir* for ChIP single-end data
   * *ATAC_paired_end_src_dir* for ATAC, paired-end data
* Edit the config file as written in the comments, you could also use (or copy paste) the config file from the data download and just add the section for "adapters:" and "bigWigs"
* Edit the snakemake file as written in the comments
* Edit the qsub file as written in the comments

