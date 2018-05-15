       identification division.
       program-id. add.
       environment division.
       data division.
       working-storage section.
       01 x pic s9(9) comp-5 value 2.
       01 y pic s9(9) comp-5 value 2.
       01 z pic s9(9) comp-5.
       procedure division.
       add x to y giving z.
       display z.
       stop run.
