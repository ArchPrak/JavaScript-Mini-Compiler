#!/bin/bash

lex icg.l
yacc icg.y
gcc y.tab.c -ll -ly -w
./a.out < test1 > icgout.txt
python transfer.py
python opt.py
