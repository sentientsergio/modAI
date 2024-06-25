      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

      **** A United States Employer Identification Number (EIN) is
      **** also known as a Federal Tax Identification Number, and is
      **** used to identify a business entity.
       
      **** EINs follow a format of a two digit prefix followed by a
      **** hyphen and a seven digit sequence: ##-######.
      
      **** See 'https://www.irs.gov/businesses/...
      **** small-businesses-self-employed/employer-id-numbers'.
       
       01  FORMAT-EIN.
           05  FORMAT-EIN-PREFIX   PIC 9(2).
           05  FORMAT-EIN-SEQUENCE PIC 9(7).
       
       01  FORMAT-EIN-HYPHEN.
           05  FORMAT-EIN-HYPHEN-PREFIX
                                   PIC 9(2).
           05  FILLER              PIC X           VALUE '-'.
           05  FORMAT-EIN-HYPHEN-SEQUENCE
                                   PIC 9(7).
       
      **** Only certain EIN Prefix values are assigned:
      **** 'https://www.irs.gov/businesses/...
      **** small-businesses-self-employed/...
      **** how-eins-are-assigned-and-valid-ein-prefixes'.
       
       01  EIN-PREFIXES.
           05  EIN-PREFIX-CNT      PIC S9(4)       COMP VALUE 83.
           05  EIN-PREFIX-OCCS.
               10  FILLER          PIC 9(2)        VALUE 01.
               10  FILLER          PIC 9(2)        VALUE 02.
               10  FILLER          PIC 9(2)        VALUE 03.
               10  FILLER          PIC 9(2)        VALUE 04.
               10  FILLER          PIC 9(2)        VALUE 05.
               10  FILLER          PIC 9(2)        VALUE 06.
               10  FILLER          PIC 9(2)        VALUE 10.
               10  FILLER          PIC 9(2)        VALUE 11.
               10  FILLER          PIC 9(2)        VALUE 12.
               10  FILLER          PIC 9(2)        VALUE 13.
               10  FILLER          PIC 9(2)        VALUE 14.
               10  FILLER          PIC 9(2)        VALUE 15.
               10  FILLER          PIC 9(2)        VALUE 16.
               10  FILLER          PIC 9(2)        VALUE 20.
               10  FILLER          PIC 9(2)        VALUE 21.
               10  FILLER          PIC 9(2)        VALUE 22.
               10  FILLER          PIC 9(2)        VALUE 23.
               10  FILLER          PIC 9(2)        VALUE 24.
               10  FILLER          PIC 9(2)        VALUE 25.
               10  FILLER          PIC 9(2)        VALUE 26.
               10  FILLER          PIC 9(2)        VALUE 27.
               10  FILLER          PIC 9(2)        VALUE 30.
               10  FILLER          PIC 9(2)        VALUE 31.
               10  FILLER          PIC 9(2)        VALUE 32.
               10  FILLER          PIC 9(2)        VALUE 33.
               10  FILLER          PIC 9(2)        VALUE 34.
               10  FILLER          PIC 9(2)        VALUE 35.
               10  FILLER          PIC 9(2)        VALUE 36.
               10  FILLER          PIC 9(2)        VALUE 37.
               10  FILLER          PIC 9(2)        VALUE 38.
               10  FILLER          PIC 9(2)        VALUE 39.
               10  FILLER          PIC 9(2)        VALUE 40.
               10  FILLER          PIC 9(2)        VALUE 41.
               10  FILLER          PIC 9(2)        VALUE 42.
               10  FILLER          PIC 9(2)        VALUE 43.
               10  FILLER          PIC 9(2)        VALUE 44.
               10  FILLER          PIC 9(2)        VALUE 45.
               10  FILLER          PIC 9(2)        VALUE 46.
               10  FILLER          PIC 9(2)        VALUE 47.
               10  FILLER          PIC 9(2)        VALUE 48.
               10  FILLER          PIC 9(2)        VALUE 50.
               10  FILLER          PIC 9(2)        VALUE 51.
               10  FILLER          PIC 9(2)        VALUE 52.
               10  FILLER          PIC 9(2)        VALUE 53.
               10  FILLER          PIC 9(2)        VALUE 54.
               10  FILLER          PIC 9(2)        VALUE 55.
               10  FILLER          PIC 9(2)        VALUE 56.
               10  FILLER          PIC 9(2)        VALUE 57.
               10  FILLER          PIC 9(2)        VALUE 58.
               10  FILLER          PIC 9(2)        VALUE 59.
               10  FILLER          PIC 9(2)        VALUE 60.
               10  FILLER          PIC 9(2)        VALUE 61.
               10  FILLER          PIC 9(2)        VALUE 62.
               10  FILLER          PIC 9(2)        VALUE 63.
               10  FILLER          PIC 9(2)        VALUE 64.
               10  FILLER          PIC 9(2)        VALUE 65.
               10  FILLER          PIC 9(2)        VALUE 66.
               10  FILLER          PIC 9(2)        VALUE 67.
               10  FILLER          PIC 9(2)        VALUE 68.
               10  FILLER          PIC 9(2)        VALUE 71.
               10  FILLER          PIC 9(2)        VALUE 72.
               10  FILLER          PIC 9(2)        VALUE 73.
               10  FILLER          PIC 9(2)        VALUE 74.
               10  FILLER          PIC 9(2)        VALUE 75.
               10  FILLER          PIC 9(2)        VALUE 76.
               10  FILLER          PIC 9(2)        VALUE 77.
               10  FILLER          PIC 9(2)        VALUE 80.
               10  FILLER          PIC 9(2)        VALUE 81.
               10  FILLER          PIC 9(2)        VALUE 82.
               10  FILLER          PIC 9(2)        VALUE 83.
               10  FILLER          PIC 9(2)        VALUE 84.
               10  FILLER          PIC 9(2)        VALUE 85.
               10  FILLER          PIC 9(2)        VALUE 86.
               10  FILLER          PIC 9(2)        VALUE 87.
               10  FILLER          PIC 9(2)        VALUE 88.
               10  FILLER          PIC 9(2)        VALUE 90.
               10  FILLER          PIC 9(2)        VALUE 91.
               10  FILLER          PIC 9(2)        VALUE 92.
               10  FILLER          PIC 9(2)        VALUE 93.
               10  FILLER          PIC 9(2)        VALUE 94.
               10  FILLER          PIC 9(2)        VALUE 95.
               10  FILLER          PIC 9(2)        VALUE 98.
               10  FILLER          PIC 9(2)        VALUE 99.
           05  FILLER REDEFINES EIN-PREFIX-OCCS.
               10  FILLER                          OCCURS 83
                                                   INDEXED EP-DX.
                   15  EIN-PREFIX  PIC 9(2).
       
       01  EIN-SEQUENCE.
           05  EIN-SEQUENCE-MIN    PIC 9(7)        VALUE 0000000.
           05  EIN-SEQUENCE-MAX    PIC 9(7)        VALUE 9999999.
       
      **** A United States Individual Taxpayer Identification Number
      **** (ITIN) is a tax processing number issued by the Internal
      **** Revenue Service. It is a nine-digit number that always begins
      **** with the number 9 and has a range of 70-88 in the fourth and
      **** fifth digit. Effective April 12, 2011, the range was extended
      **** to include 900-70-0000 through 999-88-9999, 900-90-0000
      **** through 999-92-9999 and 900-94-0000 through 999-99-9999.
      
      **** ITINs follow a format of a three digit area, a hyphen, a two
      **** digit group, a hyphen, and a four digit serial: ###-##-####.
      
      **** 'https://www.irs.gov/individuals/international-taxpayers/...
      **** general-itin-information'.
       
       01  FORMAT-ITIN.
           05  FORMAT-ITIN-AREA    PIC 9(3).
           05  FORMAT-ITIN-GROUP   PIC 9(2).
           05  FORMAT-ITIN-SERIAL  PIC 9(4).
       
       01  FORMAT-ITIN-HYPHEN.
           05  FORMAT-ITIN-HYPHEN-AREA
                                   PIC 9(3).
           05  FILLER              PIC X           VALUE '-'.
           05  FORMAT-ITIN-HYPHEN-GROUP
                                   PIC 9(2).
           05  FILLER              PIC X           VALUE '-'.
           05  FORMAT-ITIN-HYPHEN-SERIAL
                                   PIC 9(4).
       
       01  ITIN-AREA.
           05  ITIN-AREA-MIN       PIC 9(3)        VALUE 900.
           05  ITIN-AREA-MAX       PIC 9(3)        VALUE 999.

       01  ITIN-GROUPS.
           05  ITIN-GROUP-CNT      PIC S9(4)       COMP VALUE 28.
           05  ITIN-GROUP-OCCS.
               10  FILLER          PIC 9(2)        VALUE 70.
               10  FILLER          PIC 9(2)        VALUE 71.
               10  FILLER          PIC 9(2)        VALUE 72.
               10  FILLER          PIC 9(2)        VALUE 73.
               10  FILLER          PIC 9(2)        VALUE 74.
               10  FILLER          PIC 9(2)        VALUE 75.
               10  FILLER          PIC 9(2)        VALUE 76.
               10  FILLER          PIC 9(2)        VALUE 77.
               10  FILLER          PIC 9(2)        VALUE 78.
               10  FILLER          PIC 9(2)        VALUE 79.
               10  FILLER          PIC 9(2)        VALUE 80.
               10  FILLER          PIC 9(2)        VALUE 81.
               10  FILLER          PIC 9(2)        VALUE 82.
               10  FILLER          PIC 9(2)        VALUE 83.
               10  FILLER          PIC 9(2)        VALUE 84.
               10  FILLER          PIC 9(2)        VALUE 85.
               10  FILLER          PIC 9(2)        VALUE 86.
               10  FILLER          PIC 9(2)        VALUE 87.
               10  FILLER          PIC 9(2)        VALUE 88.
               10  FILLER          PIC 9(2)        VALUE 90.
               10  FILLER          PIC 9(2)        VALUE 91.
               10  FILLER          PIC 9(2)        VALUE 92.
               10  FILLER          PIC 9(2)        VALUE 94.
               10  FILLER          PIC 9(2)        VALUE 95.
               10  FILLER          PIC 9(2)        VALUE 96.
               10  FILLER          PIC 9(2)        VALUE 97.
               10  FILLER          PIC 9(2)        VALUE 98.
               10  FILLER          PIC 9(2)        VALUE 99.
           05  FILLER REDEFINES ITIN-GROUP-OCCS.
               10  FILLER                          OCCURS 28
                                                   INDEXED IG-DX.
                   15  ITIN-GROUP  PIC 9(2).
       
       01  ITIN-SERIAL.
           05  ITIN-SERIAL-MIN     PIC 9(4)        VALUE 0001.
           05  ITIN-SERIAL-MAX     PIC 9(4)        VALUE 9999.
       
      **** A United States Social Security Number (SSN) is a nine-digit
      **** number that also follows a format of a three digit area,
      **** a hyphen, a two digit group, a hyphen, and a four digit 
      **** serial: ###-##-####.
       
      **** Invalid SSNs have the following characteristics:
      ****   Cannot begin with the number 9
      ****   Cannot begin with 666 in positions 1 - 3
      ****   Cannot begin with 000 in positions 1 - 3
      ****   Cannot contain 00 in positions 4 - 5
      ****   Cannot contain 0000 in positions 6 - 9
       
      **** See https://www.ssa.gov/kc/SSAFactSheet--IssuingSSNs.pdf
       
       01  FORMAT-SSN.
           05  FORMAT-SSN-AREA     PIC 9(3).
           05  FORMAT-SSN-GROUP    PIC 9(2).
           05  FORMAT-SSN-SERIAL   PIC 9(4).
       
       01  FORMAT-SSN-HYPHEN.
           05  FORMAT-SSN-HYPHEN-AREA
                                   PIC 9(3).
           05  FILLER              PIC X           VALUE '-'.
           05  FORMAT-SSN-HYPHEN-GROUP
                                   PIC 9(2).
           05  FILLER              PIC X           VALUE '-'.
           05  FORMAT-SSN-HYPHEN-SERIAL
                                   PIC 9(4).
       
       01  SSN-AREA.
           05  SSN-AREA-MIN        PIC 9(3)        VALUE 001.
           05  SSN-AREA-MAX        PIC 9(3)        VALUE 899.
           05  SSN-AREA-EXCL       PIC 9(3)        VALUE 666.
       
       01  SSN-GROUP.
           05  SSN-GROUP-MIN       PIC 9(2)        VALUE 01.
           05  SSN-GROUP-MAX       PIC 9(2)        VALUE 99.
       
       01  SSN-SERIAL.
           05  SSN-SERIAL-MIN      PIC 9(4)        VALUE 0001.
           05  SSN-SERIAL-MAX      PIC 9(4)        VALUE 9999.
