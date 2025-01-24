# Assembly and Annotation of Arabidopsis thaliana Genome and Transcriptome

## Project Overview

This project is part of the courses **"Genome Assembly" (473637)** and **"Organization and Annotation of Eukaryote Genomes" (SBL.30004)** at the University of Bern and Fribourg.

The goal is to perform a comprehensive assembly and annotation of the Arabidopsis thaliana genome using **NGS data**. The project involves:
- Theoretical understanding of assembly algorithms.
- Application to real-world datasets of both model and non-model organisms.
- Quality assessment of assemblies and annotations.
- Integration of transcriptome assembly data for functional annotation of the genome.

---

## Dataset

The dataset used in this project originates from:
1. **Jiao W.-B., Schneeberger K. (2020)**: *Chromosome-level assemblies of multiple Arabidopsis genomes reveal hotspots of rearrangements with altered evolutionary dynamics* ([DOI:10.1038/s41467-020-14779-y](http://dx.doi.org/10.1038/s41467-020-14779-y)).
2. **Lian Q., et al. (2024)**: *A pan-genome of 69 Arabidopsis thaliana accessions reveals a conserved genome structure throughout the global species range* ([DOI:10.1038/s41588-024-01715-9](https://www.nature.com/articles/s41588-024-01715-9)).

### Specific Dataset:
- **Accession**: Istisu-1
  - **Whole Genome**: PacBio HiFi reads for Istisu-1.
  - **Whole Transcriptome**: Illumina RNA-seq data for the Sha accession (RNAseq_Sha).

---

## Workflow Overview

This project is divided into two major parts: **Assembly** and **Annotation**.

### Assembly

#### Quality Control
- **Tools**: FastQC, fastp.
- **Steps**:
  - Quality control of reads (Illumina and RNA-seq).
  - K-mer counting using **Jellyfish**.

#### Assembly Process
- **Whole Genome Assembly**:
  - Tools: **Flye**, **Hifiasm**, **LJA**.
- **Whole Transcriptome Assembly**:
  - Tool: **Trinity**.

#### Assembly Evaluation
- **Tools**: BUSCO, Quast, Merqury.
- **Steps**:
  - Evaluate assembly quality.
  - Compare genomes using **NUCmer**.
  - Visualize results using **MUMmer**.

---

### Annotation

#### Transposable Element (TE) Annotation
- **Automated Annotation**:
  - Tool: **EDTA** (Efficient de novo TE Annotator).
- **TE Visualization and Classification**:
  - Visualize and refine TE annotations with **TEsorter**.
- **TE Dynamics**:
  - Analyze phylogenetic relationships of TEs using **Clustal Omega** and **FastTree**.

#### Gene Annotation
- **Pipeline**: MAKER.
- **Steps**:
  1. Perform homology-based genome annotation with **MAKER**.
  2. Refine annotations using **InterProScan** for functional domains.
  3. Assess annotation quality using **BUSCO** and the **UniProt** database.

#### Orthology-Based Quality Control
- **Tools**: OMArk, MiniProt.
- **Steps**:
  - Orthology-based gene annotation quality check.

---

### Comparative Genomics
- **Tools**: GENESPACE, OrthoFinder.
- **Steps**:
  - Perform comparative genomics analyses.
  - Generate dot plots and riparian plots to visualize genomic relationships.

---

## Goals and Learning Objectives

1. Understand the theory behind genome and transcriptome assembly algorithms.
2. Gain practical experience with assembly, quality assessment, and annotation tools.
3. Interpret results and critically evaluate the quality of assemblies and annotations.
4. Integrate transcriptome data to annotate genomic features.

---

## Tools and Resources

| **Tool**             | **Purpose**                                  |
|----------------------|----------------------------------------------|
| **FastQC, fastp**    | Quality control of raw sequencing reads.     |
| **Jellyfish**        | K-mer counting for assembly evaluation.      |
| **Flye, Hifiasm, LJA**| Genome assembly.                            |
| **Trinity**          | Transcriptome assembly.                     |
| **BUSCO, Quast, Merqury** | Assembly quality evaluation.             |
| **NUCmer, MUMmer**   | Genome comparisons and visualization.        |
| **EDTA, TEsorter**   | Transposable element annotation.             |
| **MAKER**            | Gene annotation.                            |
| **GENESPACE, OrthoFinder** | Comparative genomics analyses.          |

---

## References
- Jiao W.-B., Schneeberger K., 2020: *Chromosome-level assemblies of multiple Arabidopsis genomes*. Nature Communications. [DOI:10.1038/s41467-020-14779-y](http://dx.doi.org/10.1038/s41467-020-14779-y).
- Lian Q., et al., 2024: *A pan-genome of 69 Arabidopsis thaliana accessions*. Nature Genetics. [DOI:10.1038/s41588-024-01715-9](https://www.nature.com/articles/s41588-024-01715-9).

