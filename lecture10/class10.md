# Class10 - Structural Bioinformatics
Mitchell Sullivan (PID: A18595276)

- [The PDB database](#the-pdb-database)
- [PDB Statistics](#pdb-statistics)
- [Using Molstar](#using-molstar)
- [The Bio3D package for structural
  bioinformatics](#the-bio3d-package-for-structural-bioinformatics)
  - [Quick viewing of PDBs](#quick-viewing-of-pdbs)
  - [Prediction of Protein
    Flexibility](#prediction-of-protein-flexibility)
- [Comparative protein structural analysis with
  PCA](#comparative-protein-structural-analysis-with-pca)

## The PDB database

The [Protein Data Bank (PDB)](http://www.rcsb.org/) is the main
repository of biomolecular structure data. Let’s see what is in it:

## PDB Statistics

``` r
stats <- read.csv("pdb_stats.csv", row.names = 1)
```

``` r
stats
```

                             X.ray    EM   NMR Integrative Multiple.methods Neutron
    Protein (only)          178795 21825 12773         343              226      84
    Protein/Oligosaccharide  10363  3564    34           8               11       1
    Protein/NA                9106  6335   287          24                7       0
    Nucleic acid (only)       3132   221  1566           3               15       3
    Other                      175    25    33           4                0       0
    Oligosaccharide (only)      11     0     6           0                1       0
                            Other  Total
    Protein (only)             32 214078
    Protein/Oligosaccharide     0  13981
    Protein/NA                  0  15759
    Nucleic acid (only)         1   4941
    Other                       0    237
    Oligosaccharide (only)      4     22

> Q1: What percentage of structures in the PDB are solved by X-Ray and
> Electron Microscopy.

``` r
# 100 * (sum(stats$X.ray) / sum(stats$Total))

# OR

n.sums <- colSums(stats)
round(n.sums / n.sums["Total"], digits = 4)
```

               X.ray               EM              NMR      Integrative 
              0.8095           0.1284           0.0590           0.0015 
    Multiple.methods          Neutron            Other            Total 
              0.0010           0.0004           0.0001           1.0000 

80.95%

> Q. What is the total number of entries in the PDB?

``` r
n.sums["Total"]
```

     Total 
    249018 

A little below 250,000

> Q2: What proportion of structures in the PDB are protein?

``` r
100 * stats[1, 8] / sum(stats$Total)
```

    [1] 85.96889

85.97%

> Q3: Type HIV in the PDB website search box on the home page and
> determine how many HIV-1 protease structures are in the current PDB?

4,940 structures.

## Using Molstar

We can use the main [Molstar viewer
online](https://molstar.org/viewer/):

![First view of HIV-Pr homodimer with bound inhibitor](1HSG_1.png)

> Q. Generate and insert an image of the HIV-Pr cartoon colored by
> secondary structure showing the inhibitor (ligand) in ball and stick.

![](1HSG_2.png)

> Q. One final image showing catalytic APS 25 as ball and stick and the
> all-important active site water molecule as spacefill.

![](1HSG_3.png)

## The Bio3D package for structural bioinformatics

``` r
library(bio3d)
```

``` r
hiv <- read.pdb("1hsg")
```

      Note: Accessing on-line PDB file

``` r
hiv
```


     Call:  read.pdb(file = "1hsg")

       Total Models#: 1
         Total Atoms#: 1686,  XYZs#: 5058  Chains#: 2  (values: A B)

         Protein Atoms#: 1514  (residues/Calpha atoms#: 198)
         Nucleic acid Atoms#: 0  (residues/phosphate atoms#: 0)

         Non-protein/nucleic Atoms#: 172  (residues: 128)
         Non-protein/nucleic resid values: [ HOH (127), MK1 (1) ]

       Protein sequence:
          PQITLWQRPLVTIKIGGQLKEALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYD
          QILIEICGHKAIGTVLVGPTPVNIIGRNLLTQIGCTLNFPQITLWQRPLVTIKIGGQLKE
          ALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYDQILIEICGHKAIGTVLVGPTP
          VNIIGRNLLTQIGCTLNF

    + attr: atom, xyz, seqres, helix, sheet,
            calpha, remark, call

``` r
head(hiv$atom)
```

      type eleno elety  alt resid chain resno insert      x      y     z o     b
    1 ATOM     1     N <NA>   PRO     A     1   <NA> 29.361 39.686 5.862 1 38.10
    2 ATOM     2    CA <NA>   PRO     A     1   <NA> 30.307 38.663 5.319 1 40.62
    3 ATOM     3     C <NA>   PRO     A     1   <NA> 29.760 38.071 4.022 1 42.64
    4 ATOM     4     O <NA>   PRO     A     1   <NA> 28.600 38.302 3.676 1 43.40
    5 ATOM     5    CB <NA>   PRO     A     1   <NA> 30.508 37.541 6.342 1 37.87
    6 ATOM     6    CG <NA>   PRO     A     1   <NA> 29.296 37.591 7.162 1 38.40
      segid elesy charge
    1  <NA>     N   <NA>
    2  <NA>     C   <NA>
    3  <NA>     C   <NA>
    4  <NA>     O   <NA>
    5  <NA>     C   <NA>
    6  <NA>     C   <NA>

``` r
pdbseq(hiv)
```

      1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20 
    "P" "Q" "I" "T" "L" "W" "Q" "R" "P" "L" "V" "T" "I" "K" "I" "G" "G" "Q" "L" "K" 
     21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40 
    "E" "A" "L" "L" "D" "T" "G" "A" "D" "D" "T" "V" "L" "E" "E" "M" "S" "L" "P" "G" 
     41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60 
    "R" "W" "K" "P" "K" "M" "I" "G" "G" "I" "G" "G" "F" "I" "K" "V" "R" "Q" "Y" "D" 
     61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80 
    "Q" "I" "L" "I" "E" "I" "C" "G" "H" "K" "A" "I" "G" "T" "V" "L" "V" "G" "P" "T" 
     81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99   1 
    "P" "V" "N" "I" "I" "G" "R" "N" "L" "L" "T" "Q" "I" "G" "C" "T" "L" "N" "F" "P" 
      2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21 
    "Q" "I" "T" "L" "W" "Q" "R" "P" "L" "V" "T" "I" "K" "I" "G" "G" "Q" "L" "K" "E" 
     22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41 
    "A" "L" "L" "D" "T" "G" "A" "D" "D" "T" "V" "L" "E" "E" "M" "S" "L" "P" "G" "R" 
     42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61 
    "W" "K" "P" "K" "M" "I" "G" "G" "I" "G" "G" "F" "I" "K" "V" "R" "Q" "Y" "D" "Q" 
     62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81 
    "I" "L" "I" "E" "I" "C" "G" "H" "K" "A" "I" "G" "T" "V" "L" "V" "G" "P" "T" "P" 
     82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99 
    "V" "N" "I" "I" "G" "R" "N" "L" "L" "T" "Q" "I" "G" "C" "T" "L" "N" "F" 

### Quick viewing of PDBs

``` r
# library(bio3dview)
# library(NGLVieweR)
# 
# view.pdb(hiv, backgroundColor = "pink") |>
#   setSpin()
```

``` r
# # Select the important ASP 25 residue
# sele <- atom.select(hiv, resno=25)
# 
# # and highlight them in spacefill representation
# view.pdb(hiv, cols=c("navy","teal"), 
#          highlight = sele,
#          highlight.style = "spacefill") |>
#   setRock()
```

### Prediction of Protein Flexibility

``` r
adk <- read.pdb("6s36")
```

      Note: Accessing on-line PDB file
       PDB has ALT records, taking A only, rm.alt=TRUE

``` r
m <- nma(adk)
```

     Building Hessian...        Done in 0.012 seconds.
     Diagonalizing Hessian...   Done in 0.258 seconds.

``` r
plot(m)
```

![](class10_files/figure-commonmark/unnamed-chunk-12-1.png)

Write out our results as a wee trajectory movie:

``` r
#mktrj(m, file = "adk_m7.pdb")
```

``` r
#view.nma(m)
```

## Comparative protein structural analysis with PCA

We start with a database id “1AKE”

``` r
library(bio3d)

id <- "1ake_A"
aa <- get.seq(id)
```

    Warning in get.seq(id): Removing existing file: seqs.fasta

    Fetching... Please wait. Done.

``` r
#blast <- blast.pdb(aa)
#saveRDS(blast, file = "blast.rds")
```

Have a wee peak:

``` r
#blast <- readRDS("blast.rds")

#head(blast$hit.tbl)
```

``` r
#hits <- plot(blast)
```

Peak at our “top hits”:

``` r
#head(hits$pdb.id)
```

Now we can download these “top hits”. These will all be ADK structures
in the PDB database.

``` r
#hits <- NULL
#hits$pdb.id <- c('1AKE_A','6S36_A','6RZE_A','3HPR_A','1E4V_A','5EJE_A','1E4Y_A','3X2S_A','6HAP_A','6HAM_A','4K46_A','3GMT_A','4PZL_A')
```

``` r
#files <- get.pdb(hits$pdb.id, path = "pdbs", split = T, gzip = T)
```

We need one package from BioConductor. To set this up, we need to first
install a package called **“BiocManager”** from CRAN

Now we can use the `install()` function from this package like this:
`BiocManager::install("msa")`

``` r
#pdbs <- pdbaln(files, fit = T, exefile = "msa")
```

``` r
#ids <- basename.pdb(pdbs$id)

#anno <- pdb.annotate(ids)
#unique(anno$source)
```

Let’s have a wee peak at our structures after “fitting”, or superposing

``` r
#library(bio3dview)
```

``` r
#view.pdbs(pdbs, colorScheme = "residue")
```

We can run functions like `rmsd()`, `rmsf()`, and the best, `pca()`

``` r
#pc.xray <- pca(pdbs)

#plot(pc.xray)
```

``` r
#plot(pc.xray, 1:2)
```

``` r
# Calculate RMSD
#rd <- rmsd(pdbs)

# Structure-based clustering
#hc.rd <- hclust(dist(rd))
#grps.rd <- cutree(hc.rd, k=3)

#plot(pc.xray, 1:2, col="grey50", bg=grps.rd, pch=21, cex=1)
```

Finally, let’s make a wee movie of the major “motion” or structural
difference in the dataset - we call this a “trajectory”

``` r
#mktrj(pc.xray, file = "results.pdb")
```

``` r
#library(ggplot2)
#library(ggrepel)

#df <- data.frame(PC1=pc.xray$z[,1], 
#                 PC2=pc.xray$z[,2], 
#                 col=as.factor(grps.rd),
#                 ids=ids)

#p <- ggplot(df) + 
#  aes(PC1, PC2, col=col, label=ids) +
#  geom_point(size=2) +
#  geom_text_repel(max.overlaps = 20) +
#  theme_minimal() +
#  theme(legend.position = "none")
#p
```

``` r
#modes <- nma(pdbs)

#plot(modes, pdbs, col=grps.rd)
```
