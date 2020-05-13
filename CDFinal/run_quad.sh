#!/bin/bash

lex icg.l
yacc icg.y
gcc y.tab.c -ll -ly -w
./a.out < test3 > icgout.txt
python transfer.py
python opt.py > optout.txt
python3 newtargetcode.py
