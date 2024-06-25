      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      * 2020-02-11  1.0.1    Add BANK and TELETELEPHONE numbers
      *================================================================*

      **** Input fields:
      ****     FAKER-PROVIDER-FUNCTION:
      ****         Set appropriate 88 level for  desired function.
      ****     FAKER-SEED-NO: 
      ****         If > 0, used to set seed to get same random
      ****         sequence on each call.
      ****     FAKER-SEED-TEXT: 
      ****         If FAKER-SEED-NO = 0 and this is not spaces, used to
      ****         set seed to get same random sequence on each call
      ****         (e.g. to get same fake name each time real name is
      ****         being anonymized, move real name to FAKER-SEED-TEXT
      ****         before call). 

           05  FAKER-PROVIDER-FUNCTION
                                   PIC X(30).
               88  ADDRESS-ADDRESS                 VALUE 
                                   'ADDRESS-ADDRESS'.
               88  ADDRESS-BUILDING-NO             VALUE 
                                   'ADDRESS-BUILDING-NO'.
               88  ADDRESS-CITY                    VALUE 
                                   'ADDRESS-CITY'.
               88  ADDRESS-CITY-PREFIX             VALUE 
                                   'ADDRESS-CITY-PREFIX'.
               88  ADDRESS-CITY-SUFFIX             VALUE 
                                   'ADDRESS-CITY-SUFFIX'.
               88  ADDRESS-MILITARY-APO            VALUE
                                   'ADDRESS-MILITARY-APO'.
               88  ADDRESS-MILITARY-DPO            VALUE
                                   'ADDRESS-MILITARY-DPO'.
               88  ADDRESS-MILITARY-SHIP-PREFIX    VALUE
                                   'ADDRESS-MILITARY-SHIP-PREFIX'.
               88  ADDRESS-MILITARY-STATE-ABBR     VALUE
                                   'ADDRESS-MILITARY-STATE-ABBR'.
               88  ADDRESS-POSTCODE                VALUE 
                                   'ADDRESS-POSTCODE'.
               88  ADDRESS-SECONDARY-ADDRESS       VALUE 
                                   'ADDRESS-SECONDARY-ADDRESS'.
               88  ADDRESS-STATE                   VALUE 
                                   'ADDRESS-STATE'.
               88  ADDRESS-STATE-ABBR              VALUE 
                                   'ADDRESS-STATE-ABBR'.
               88  ADDRESS-STATE-POSTCODE          VALUE 
                                   'ADDRESS-STATE-POSTCODE'.
               88  ADDRESS-STREET-ADDRESS          VALUE 
                                   'ADDRESS-STREET-ADDRESS'.
               88  ADDRESS-STREET-NAME             VALUE 
                                   'ADDRESS-STREET-NAME'.
               88  ADDRESS-STREET-SUFFIX           VALUE 
                                   'ADDRESS-STREET-SUFFIX'.
               88  ADDRESS-TERRITORY-ABBR          VALUE
                                   'ADDRESS-TERRITORY-ABBR'.
               88  BANK-ACCOUNT                    VALUE
                                   'BANK-ACCOUNT'.
               88  BANK-ROUTING                    VALUE
                                   'BANK-ROUTING'.
               88  COMPANY-COMPANY                 VALUE
                                   'COMPANY-COMPANY'.
               88  COMPANY-SUFFIX                  VALUE
                                   'COMPANY-SUFFIX'.
               88  PERSON-FIRST-NAME               VALUE 
                                   'PERSON-FIRST-NAME'.    
               88  PERSON-FIRST-NAME-MALE          VALUE
                                   'PERSON-FIRST-NAME-MALE'.    
               88  PERSON-FIRST-NAME-FEMALE        VALUE 
                                   'PERSON-FIRST-NAME-FEMALE'.    
               88  PERSON-LAST-NAME                VALUE 
                                   'PERSON-LAST-NAME'.    
               88  PERSON-LAST-NAME-MALE           VALUE 
                                   'PERSON-LAST-NAME-MALE'.    
               88  PERSON-LAST-NAME-FEMALE         VALUE 
                                   'PERSON-LAST-NAME-FEMALE'.    
               88  PERSON-NAME                     VALUE 
                                   'PERSON-NAME'.    
               88  PERSON-NAME-MALE                VALUE 
                                   'PERSON-NAME-MALE'.    
               88  PERSON-NAME-FEMALE              VALUE 
                                   'PERSON-NAME-FEMALE'.    
               88  PERSON-PREFIX                   VALUE 
                                   'PERSON-PREFIX'.    
               88  PERSON-PREFIX-MALE              VALUE 
                                   'PERSON-PREFIX-MALE'.    
               88  PERSON-PREFIX-FEMALE            VALUE 
                                   'PERSON-PREFIX-FEMALE'.    
               88  PERSON-SUFFIX                   VALUE 
                                   'PERSON-SUFFIX'.    
               88  PERSON-SUFFIX-MALE              VALUE 
                                   'PERSON-SUFFIX-MALE'.    
               88  PERSON-SUFFIX-FEMALE            VALUE 
                                   'PERSON-SUFFIX-FEMALE'. 
               88  TAXID-EIN                       VALUE 
                                   'TAXID-EIN'. 
               88  TAXID-EIN-HYPHEN                VALUE 
                                   'TAXID-EIN-HYPHEN'. 
               88  TAXID-ITIN                      VALUE 
                                   'TAXID-ITIN'. 
               88  TAXID-ITIN-HYPHEN               VALUE 
                                   'TAXID-ITIN-HYPHEN'. 
               88  TAXID-SSN                       VALUE 
                                   'TAXID-SSN'. 
               88  TAXID-SSN-HYPHEN                VALUE 
                                   'TAXID-SSN-HYPHEN'. 
               88  TELEPHONE                       VALUE 
                                   'TELEPHONE'. 

           05  FAKER-SEED-NO       PIC 9(9)   COMP VALUE 0.

           05  FAKER-SEED-TEXT     PIC X(80)       VALUE SPACES.

      **** Output fields:
      ****     FAKER-RESPONSE-CODE
      ****         Use 88 levels to determine result of calls.
      ****     FAKER-RESPONSE-MSG
      ****         Non-space if bad response.
      ****     FAKER-RESULT
      ****         Returned result of the call.
      ****     FAKER-RESULT-FIELDS
      ****         Populated for certain compound results - redefined
      ****         for address and person fields.
      ****     FAKER-INFO-CNT
      ****         Debugging information count.
      ****     FAKER-INFO-OCCS
      ****         Debugging information.

           05  FAKER-RESPONSE-CODE PIC 9(4). 
               88  FAKER-RESPONSE-GOOD             VALUE 0.
               88  FAKER-UNKNOWN-PROVIDER          VALUE 10.
               88  FAKER-UNKNOWN-FUNCTION          VALUE 20.
               88  FAKER-UNKNOWN-FORMAT            VALUE 30.

           05  FAKER-RESPONSE-MSG  PIC X(80). 

           05  FAKER-RESULT        PIC X(80). 

           05  FAKER-RESULT-FIELDS PIC X(80). 

      **** These fields are populated only for ADDRESS-ADDRESS calls:
           05  FAKER-ADDRESS REDEFINES FAKER-RESULT-FIELDS.
               10  FAKER-ADDRESS-STREET
                                   PIC X(35).
               10  FAKER-ADDRESS-CITY
                                   PIC X(25).
               10  FAKER-ADDRESS-STATE
                                   PIC X(10).
               10  FAKER-ADDRESS-POSTCODE
                                   PIC X(10).

      **** These fields are populated only for PERSON-NAME, 
      **** PERSON-NAME-MALE and PERSON-NAME-FEMALE calls:
           05  FAKER-PERSON REDEFINES FAKER-RESULT-FIELDS.
               10  FAKER-PERSON-PREFIX
                                   PIC X(10).
               10  FAKER-PERSON-FIRST-NAME
                                   PIC X(25).
               10  FAKER-PERSON-LAST-NAME
                                   PIC X(35).
               10  FAKER-PERSON-SUFFIX
                                   PIC X(10).

      **** These fields are populated only for TELEPHONE calls:
           05  FAKER-TELEPHONE REDEFINES FAKER-RESULT-FIELDS.
               10  FAKER-TELEPHONE-AREA-CODE
                                   PIC X(03).
               10  FILLER          PIC X(01).
               10  FAKER-TELEPHONE-PREFIX
                                   PIC X(03).
               10  FILLER          PIC X(01).
               10  FAKER-TELEPHONE-SUFFIX
                                   PIC X(04).
               10  FILLER          PIC X(01).
               10  FAKER-TELEPHONE-EXTENSION
                                   PIC X(04).

           05  FAKER-INFO-CNT      PIC S9(4)  COMP. 

           05  FAKER-INFO-OCCS.
               10  FAKER-INFO                      OCCURS 20
                                                   INDEXED FI-DX
                                                           FI-DX2.
                   15  FAKER-TABLE PIC X(30).
                   15  FAKER-RANDOM-NO-SUB
                                   PIC S9(4)V9(9)
                                              COMP.
                   15  FAKER-TABLE-ENTRY
                                   PIC S9(4)  COMP.
           
