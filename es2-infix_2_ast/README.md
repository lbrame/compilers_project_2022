# Infix calculator to AST

## Specification

The parser needs to recognize a typical input line to an infix calculator (through a provided context-free grammar) and then convert it to Abstract Sytax Tree notation and either print it in a custom format with properly intented lines according to depth level or plain JSON / XML.

### Source CF grammar

```
E -> E+T | E-T
  | T
T -> T*F | T|F | T%F
  | F
F -> num
  | -F|+F
  | (E)
```

## How to use

* **Compile**: `make`
* **Clean binaries**: `make clean`
* **Run**: `./run.sh`
* **Run quick test**: `./test.sh`

Please note that `run.sh` and `test.sh` might need to be made excutable:

```bash
chmod +x run.sh test.sh
```

## Sources of inspiration

* The CF grammar in use is exactly the one provided in the specification PDF.
* Inspiration was taken from the `AST_EXAMPLE` folder on Moodle for the AST. While of course it's not a verbatim copy, it replicates its structure closely.
* [This StackOverflow reply](https://stackoverflow.com/questions/9181146/freeing-memory-of-a-binary-tree-c) for the recursive tree-cleaning algorithm. Thank you, kind soul! Manual memory management is hard. It works well! While we still get some memory leaks from yylex(), yyparse() and strndup() in ast.l, `valgrind` does not seem to report memory leaks related to our SAT :)
