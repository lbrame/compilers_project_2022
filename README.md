# Compilers project 2022

This is the project for the Compilers course in the Computer Science undergraduate degree at Univeristy of Verona for academic year 2021-2022.

The specification can be read on in `CompilersProject_2022.pdf`. This file is property of Università di Verona and I do not own the rights and license for it.

## Getting it up and running

This project has been worked on inside of a `ubuntu:20.04`-based container rather than on my Fedora 37 host because, for some reasons I did not investigate, with the repo-installed `flex` and `bison` packages, several of the example exercises given in class failed to compile; and Ubuntu Focal is what the univeristy uses in its labs, so it will work there.

To pull in required dependencies run:

```bash
sudo apt install build-essential flex bison
```

## `-Wno-yacc`

These files were built with the `-Wno-yacc` compile flag that was not documented during class that would get rid of compile errors I was getting related to `%define parse.error verbose` being invalid in POSIX yacc.
