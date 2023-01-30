# Taxyway

## Specification

The specification dictates to create a syntax analyzer for a small language to recognize movement statements into a Cartesian plane. It needs to be able to recognize one or many commands formatted like `DIRECTION NUMBER_OF_STEPS`.

The program needs to check whether the input path is valid from moving from a starting point to a destination point. In case the inserted path is not valid, the program will notify the user the provided path is incorrect and it will suggest a pair of moves that will take the player to the correct destination from the reached point to stdout. Appending those suggested directions to the same input in a successive run of the program will, in fact, yield a successful run.

## Configure

The starting point and ending point coordinates are stored into two pairs of defines:

* Starting point coordinates
    * `XSTART` (defaults to `0`)
    * `YSTART` (defaults to `0`)
* Destination point coordinates
    * `XEND` (defaults to `5`)
    * `YEND` (defaults to `6`)

## How to use

* **Compile**: `make`
* **Clean binaries**: `make clean`
* **Run**: `./taxyway`. Then, write input to `stdin`.
