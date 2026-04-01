# Sync tool for M3E Gleam/Lustre wrappers

## Overview

Over time, as features are added and fixes are applied to **matraic's** [M3E Expressive Components](https://github.io/matraic/m3e) 
project, inevitably the Gleam/Lustre wrappers in this library will drift out of sync.

**m3esync** is a program to generate a report on differences between the component attributes in **M3E Expressive Components** and the 
Gleam functions in this library.

## Building this program

Assuming Go (built with 1.26 but it is a pretty simple program so a recent Go version will most likely work too) is installed on your system:

```bash
cd /tmp
mkdir **
cd gleam
git clone https://github.com/bruceesmith/m3e.git
cd m3e/m3esync
go build .
```
This produces the `m3esync` binary in the `/tmp/gleam/m3e/m3esync/` folder.

## Running this program

Assuming **M3E Expressive Components** has been locally cloned into `/tmp/m3e/`, and this library has been locally cloned as above then:

```bash
/tmp/gleam/m3e/m3esync/m3esync --gleam tmp/gleam/m3e/ --ts /tmp/m3e/ --descriptions
```

This execution will generate a report which reveals:
1. Components in **M3E Expressive Components** which appear to have no wrapper in this repository
2. Fields in any **M3E Expressive Components** component which do not appear in the corresponding Gleam type in this repository
3. Fields in any **M3E Expressive Components** component whose description in this repository appears to vary from that in 
**M3E Expressive Components**
