import glob

#SAMPLE,=glob_wildcards("../resources/Data/pod5/") 

rule all:
    input:
        "../resources/Data/pod5/",
        "../resources/Output/Dorado/calls.bam",
        "../resources/Output/Barcodes/"

#############################
#### De-compressed files ####
#############################
rule decompress:
    input:
        tar_file="../resources/Data/pod5.tar.gz"

    output:
        dir("../resources/Data/pod5/")
    log:
        "../resources/Logs/decompress.log"
    shell:
        """
        tar -xvzf {input.tar_file} -C {output} > {log} 2>&1
        """

rule dorado_run:
    input:
       "../resources/Data/pod5/"
    output: 
        dirout="../resources/Output/Dorado/", 
        bam_file="../resources/Output/Dorado/calls.bam"
    params: 
        bc_kit="SQK-RBK114-24", 
        model="dna_r10.4.1_e8.2_400bps_hac@v5.0.0"
    log: 
        "../resources/Logs/dorado.log"
    shell: 
        """
        # load modules
        module load CCEnv 
        module load StdEnv/2023
        module load dorado/0.8.0

        dorado basecaller {params.model} {input} --output {output.dirout} \
            --kit-name  {params.bc_kit} > {output.bam_file} >  {log} 2>&1
        """

rule demux:
    input: 
        bamfile="../resources/Output/Dorado/calls.bam"
    output:
        dirout="../resources/Output/Barcodes"
    log:
        "../resources/Logs/demux/demux.log"
    shell:
        """
        dorado demux --output-dir {output.dirout} \
                    --no-classify {input.bamfile} > {log} 2>&1
        """
