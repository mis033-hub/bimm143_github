# Class 06: R Functions
Mitchell Sullivan (PID: A18595276)

- [Background](#background)
- [A first function](#a-first-function)
- [A second function](#a-second-function)
- [A new cool function](#a-new-cool-function)

## Background

Functions are at the heart of using R. Everything we do involves calling
and using functions (from data input and analysis to outputs and
results).

All functions in R have at least three things:

1.  A **name** (the thing we use to call the function)
2.  One or more input **arguments** that are comma separated
3.  The **body** (lines of code between curly brackets { } that does the
    work of the function)

## A first function

Let’s write a silly wee function to add some numbers:

``` r
add1 <- function(x) {
  x + 1
}
```

Let’s try it out:

``` r
add1(100)
```

    [1] 101

``` r
#Will this work?
add1(c(100, 200, 300))
```

    [1] 101 201 301

Yes!

Modify it to be more useful and add more than just 1

``` r
add <- function(x, y) {
  x + y
}
```

``` r
#Will this work?
add(100, 10)
```

    [1] 110

Yes!

``` r
#Will this work?
add(100)
```

    Error in `add()`:
    ! argument "y" is missing, with no default

No!

Let’s fix that error so that it will automatically add 1 when no second
argument is passed

``` r
add <- function(x, y = 1) {
  x + y
}
add(100)
```

    [1] 101

> **N.B.** Input arguments can be either **required** or **optional**.
> The latter have a fall-back default that is specified in the function
> code with an equals sign.

> Will this work? `add(100, 200, 300)`

``` r
add(100, 200, 300)
```

    Error in `add()`:
    ! unused argument (300)

No!

This can be fixed with an ellipses (`...`) in the arguments when writing
a function.

## A second function

All functions in R look like this

    name <- function(arg) {
      body
    }

The `sample()` function in R samples `size = n` values randomly from a
vector `x`

``` r
sample(1:10, 4)
```

    [1] 10  4  6  5

> Q. Return 12 numbers picked randomly from the input 1:10

``` r
sample(1:10, 12, replace = T)
```

     [1] 10  6  4 10  2  9  9  3  3  6  3  1

> Q. Write the code to generate a random 12 nucleotide long DNA sequence

``` r
bases <- c("A", "T", "C", "G")
sample(bases, 12, replace = T)
```

     [1] "A" "T" "C" "G" "T" "C" "C" "T" "T" "C" "G" "T"

> Q. Write a first version function called `generate_dna()` that
> generates a user specified length `n` random DNA sequence

Version 1

``` r
generate_dna <- function(n) {
  bases <- c("A", "T", "C", "G")
  sample(bases, size = n, replace = T)
}
```

> Q. Modify your function to return a FASTA-like sequence, so rather
> than \[1\] “G” “C” “A” “A” “T”, we want “GCAAT”

Version 3 (FASTA format only)

``` r
generate_dna_fasta <- function(n) {
  bases <- c("A", "T", "C", "G")
  dna <- sample(bases, size = n, replace = T)
  paste(dna, collapse = "")
}
```

> Q. Give the user an option to return FASTA format output sequence or
> standard multi-element vector format

Version 4 (FASTA format option)

``` r
generate_dna <- function(n, fasta = T) {
  bases <- c("A", "T", "C", "G")
  dna <- sample(bases, size = n, replace = T)
  if (fasta) {
    dna <- paste(dna, collapse = "")
  }
  return(dna)
}
```

``` r
generate_dna(35)
```

    [1] "CGGACCCCGATGTACCCATACGCAGCCCAAGATGC"

``` r
generate_dna(35, fasta = F)
```

     [1] "C" "G" "G" "T" "C" "A" "A" "C" "T" "G" "A" "A" "G" "T" "G" "A" "T" "G" "A"
    [20] "A" "C" "T" "G" "A" "A" "C" "C" "G" "T" "T" "C" "C" "G" "T" "A"

## A new cool function

> Q. Write a function called `generate_protein()` that generates a user
> specified length protein sequence in FASTA-like format?

``` r
generate_protein <- function(n, fasta = T) {
  aa_vec <- c(
  "A", "R", "N", "D",
  "C", "Q", "E", "G",
  "H", "I", "L", "K",
  "M", "F", "P", "S",
  "T", "W", "Y", "V"
  )
  protein <- sample(x = aa_vec, size = n, replace = T)
  if (fasta) {
    protein <- paste(protein, collapse = "")
  }
  return(protein)
}
```

``` r
generate_protein(70)
```

    [1] "YTAFNLWHRTLTNMDFTPETDKQVYRFNGQILPCTNKKVDNEWTSPQQSKAQCRDEPVNSLCVYKRVSEG"

> Q. Use your new `generate_protein()` function to generate all
> sequences between length 6 and 12 amino-acids in length and check if
> any of these are unique in nature (i.e. found in the NR database at
> NCBI)

``` r
library(rentrez)
seqs <- sapply(6:12, generate_protein)
```

``` r
for (i in 6:12) {
  cat(">", i, sep = "", "\n")
  cat(seqs[i - 5], "\n")
}
```

    >6
    THASGP 
    >7
    PNKVEGT 
    >8
    INNIEDNQ 
    >9
    YGNFDLCDH 
    >10
    RCFGGPYPQK 
    >11
    EKYLCLAVQCL 
    >12
    KQESVYKGFELC 

Copy and paste this into BLASTp
