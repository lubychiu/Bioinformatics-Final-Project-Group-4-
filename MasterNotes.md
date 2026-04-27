# 4/19

## FASTQC on raw files 
Run FASTQC to assess read quality 
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
Raw data files were of exceptional quality. Therefore, there is no need for additional trimming with trimmomatic 

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
run bowtie2 through bowtie2.sbatch script attached

# 4/21

## Download kraken2 database 

create kraken environment
```bash
$ conda create -n kraken_env -c bioconda -c conda-forge kraken2
$ conda install -c bioconda kraken2
$ conda activate kraken_env
```

load kraken database 
```bash
# make directory for database
$ mkdir /home/dsr84/kraken/kraken2_db
```
load kraken2 database with kraken2_db.sbatch script attached

how to run an interactive compute node
```bash
srun pty --bash
```

# 4/23

## Kraken2 to identify microbes present 

run kraken2 with kraken2.sbatch script attached

The original kraken2 databse was too large, and kraken jobs kept failing. Updated script shows the link to the 8G version of the database. Once that runs, we will proceed with kraken2 analysis on our samples

The output of kraken is a [SAMPLENAME].kraken and a [SAMPLENAME].report file. Both of these files can be left in the output directory as-is to run braken. 

# 4/24
## Braken for taxonomic abundance estimation

run braken with braken.sbatch script attached

Output: [SAMPLENAME].bracken

# 4/26
## Data analysis and figure generation

we aim to convert our bracken abundance data into a heatmap demonstrating which species are enriched in CRC v. Normal fecal samples. 
we have two samples from CRC and two from normal 

download files to local computer to be accessed by RSutdio. Mac can't open .bracken files itself, but RStudio will be able to read them as-is. 
```bash
# FROM LOCAL COMPUTER
gcloud compute scp m12-controller:/home/dsr84/final.data/CNR0930222.bracken ~/Downloads/
```
viewing the bracken file in R, you can see columns:
name, taxonomy_id, taxonomy_lvl (S = Species, G = Genus), kraken_assigned_reads (reads assigned by kraken), added_reads (reads assigned by bracken), new_est_reads (final estimated reads considering kraken and braken), fraction_total_reads

we used fraction_total_reads to compare the relative abundances of taxa between samples
figure generation and statistical analysis were performed according to the R markdown file heatmap.Rmarkdown
no taxa were found to be significantly enriched in the CRC or the control group
for ease of reading, only the 30 most abundant taxa were displayed 
this does limit our conclusions, as the figure is comparing the most abundant, not necessarily the most different. however, statistical testing was completed over all taxa and no difference was found. 
