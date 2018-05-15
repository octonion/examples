       IDENTIFICATION DIVISION.
       PROGRAM-ID. addition.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 x PIC S9(9) COMP-5 VALUE 2.
       01 y PIC S9(9) COMP-5 VALUE 2.
       01 z PIC S9(9) COMP-5.
       PROCEDURE DIVISION.
       display function add (x,y).
       STOP RUN.
