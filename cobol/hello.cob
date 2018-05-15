       IDENTIFICATION DIVISION.
       PROGRAM-ID. hello.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 hello PIC X(7) VALUE "Hello, ".
       01 world PIC X(6) VALUE "world!".
       PROCEDURE DIVISION.
       CALL "say" USING hello world.
       STOP RUN.
