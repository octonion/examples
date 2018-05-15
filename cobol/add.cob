       IDENTIFICATION DIVISION.
       PROGRAM-ID. add.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 x PIC S9(9) COMP-5 VALUE 2.
       01 y PIC S9(9) COMP-5 VALUE 2.
       01 z PIC S9(9) COMP-5.
       PROCEDURE DIVISION.
       add x to y giving z.
       display z.
       STOP RUN.
