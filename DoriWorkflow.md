# 4/19

## FASTQC on raw files 
Run FASTQC for CNR0930220_1, CNR0930220_2, CNR0930221_1, CNR0930221_2
```bash
$ mkdir fastqc_out
$ module load fastqc
$ fastqc -o fastqc_out CNR0930220_1.fastq.gz
```
Download and view .html

```bash
# FROM LOCAL COMPUTER 
$ gcloud compute scp m12-controller:/home/dsr84/fastqc_out/CNR0930220_1_fastqc.html ~/Downloads/
```
Raw data files were of exceptional quality. Therefore, there is no need for trimmomatic 

## Bowtie to filter out human reads
downloaded ncbi_dataset from this link: https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001405.40/ 
most updated version of GRCh38, updated from the one this paper used

unzip ncbi_dataset
```bash
$ unzip ncbi_dataset
# find .fna reference file
$ find ncbi_dataset -name "*.fna"
```

preparing bowtie2 dataset to be accessed 
```bash
# in the command line:
$ module purge
$ module load bowtie2/2.5.4
# bowtie build step to set up database 
$ bowtie2-build ncbi_dataset/data/GCF_000001405.40/GCF_000001405.40_GRCh38.p14_genomic.fna human_index
```
# 4/21

## Kraken2 to identify microbes present 
