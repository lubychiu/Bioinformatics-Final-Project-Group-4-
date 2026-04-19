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
$ gcloud compute scp m12-controller/home/dsr84/fastqc_out/CNR0930220_1_fastqc.html ~/Downloads/
```
