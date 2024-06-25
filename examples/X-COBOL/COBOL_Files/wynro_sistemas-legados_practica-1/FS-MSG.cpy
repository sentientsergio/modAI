       EVALUATE STATUS
            WHEN 00 MOVE 'SUCCESS                                 '
                 TO MSG *>|00| Success                               |
            WHEN 02 MOVE 'SUCCESS DUPLICATE KEY WRITTEN           '
                 TO MSG *>|02| Success (Duplicate Record Key Written)|
            WHEN 04 MOVE 'SUCCESS INCOMPLETE                      '
                 TO MSG *>|02| Success (Incomplete write)            |
            WHEN 05 MOVE 'SUCCESS OPTIONAL FILE NOT FOUND         '
                 TO MSG *>|05| Success (Optional File Not Found)     |
            WHEN 07 MOVE 'SUCCESS NO UNIT                         '
                 TO MSG *>|07| Success (No Unit)                     |
            WHEN 10 MOVE 'END OF FILE                             '
                 TO MSG *>|10| End of file                           |
            WHEN 14 MOVE 'OUT OF KEY RANGE                        '
                 TO MSG *>|14| Out of key range                      |
            WHEN 21 MOVE 'KEY INVALID                             '
                 TO MSG *>|21| Key invalid                           |
            WHEN 22 MOVE 'KEY EXISTS (ATTEMP TO DUPLICATE)        '
                 TO MSG *>|22| Attempt to duplicate key value        |
            WHEN 23 MOVE 'KEY NOT EXISTS                          '
                 TO MSG *>|23| Key not found                         |
            WHEN 30 MOVE 'PERMANENT IO ERROR                      '
                 TO MSG *>|30| Permanent I/O error                   |
            WHEN 31 MOVE 'INCONSISTENT FILENAME                   '
                 TO MSG *>|31| Inconsistent filename                 |
            WHEN 34 MOVE 'BOUNDARY VIOLATION                      '
                 TO MSG *>|34| Boundary violation                    |
            WHEN 35 MOVE 'FILE NOT FOUND                          '
                 TO MSG *>|35| File not found                        |
            WHEN 37 MOVE 'PERMISSION DENIED                       '
                 TO MSG *>|37| Permission denied                     |
            WHEN 38 MOVE 'CLOSED WITH LOCK                        '
                 TO MSG *>|38| Closed with lock                      |
            WHEN 39 MOVE 'CONFLICT ATTRIBUTE                      '
                 TO MSG *>|39| Conflicting attribute                 |
            WHEN 41 MOVE 'ALREADY OPEN                            '
                 TO MSG *>|41| File already OPEN                     |
            WHEN 42 MOVE 'NOT OPEN                                '
                 TO MSG *>|42| File not OPEN                         |
            WHEN 43 MOVE 'READ NOT DONE                           '
                 TO MSG *>|43| Read not done                         |
            WHEN 44 MOVE 'RECORD OVERFLOW                         '
                 TO MSG *>|44| Record overflow                       |
            WHEN 46 MOVE 'READ ERROR                              '
                 TO MSG *>|46| READ error                            |
            WHEN 47 MOVE 'INPUT DENIED                            '
                 TO MSG *>|47| OPEN INPUT denied                     |
            WHEN 48 MOVE 'OUTPUT DENIED                           '
                 TO MSG *>|48| OPEN OUTPUT denied                    |
            WHEN 49 MOVE 'I/O DENIED                              '
                 TO MSG *>|49| OPEN I-O denied                       |
            WHEN 51 MOVE 'RECORD LOCKED                           '
                 TO MSG *>|51| Record locked                         |
            WHEN 52 MOVE 'END-OF-PAGE                             '
                 TO MSG *>|52| End of page                           |
            WHEN 57 MOVE 'I/O LINAGE                              '
                 TO MSG *>|57| LINAGE specifications invalid         |
            WHEN 61 MOVE 'FILE SHARING FAILURE                    '
                 TO MSG *>|61| File sharing failure                  |
            WHEN 91 MOVE 'FILE NOT AVAILABLE                      '
                 TO MSG *>|91| File not available                    |
       END-EVALUATE.
