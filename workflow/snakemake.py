import glob

#SAMPLE,=glob_wildcards("../resources/Data/pod5/") 

rule all:
    input:
        "../resources/Output/Dorado/calls.bam"

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
        "../resources/Logs/Dorado/dorado.log"
    shell: 
        """
        # load modules
        module load CCEnv 
        module load StdEnv
        module load dorado/0.7.2

        dorado basecaller {params.model} {input} --output {output.dirout} \
            --kit-name  {params.bc_kit} > {output.bam_file}  {log} 2>&1
        """
