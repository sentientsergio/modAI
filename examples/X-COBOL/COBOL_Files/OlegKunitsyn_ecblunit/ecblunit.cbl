       *>**
       *>  ECBLUnit
       *>  Simple Unit Testing for z/OS written in IBM Enterprise COBOL
       *>
       *>  @author Olegs Kunicins
       *>  @license GPL
       *>
       *>  This program is free software; you can redistribute it and/or
       *>  modify it under the terms of the GNU General Public License 
       *>  as published by the Free Software Foundation; either version
       *>  2, or (at your option) any later version.
       *>  
       *>  This program is distributed in the hope that it will be 
       *>  useful, but WITHOUT ANY WARRANTY; without even the implied 
       *>  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
       *>  PURPOSE. See the GNU General Public License for more details.
       *>  
       *>  You should have received a copy of the GNU General Public
       *>  License along with this software; see the file COPYING.
       *>  If not, write to the Free Software Foundation, Inc.,
       *>  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
       *>**
       
       identification division.
       program-id. ECBLUNIT.
       environment division.
       data division.
       working-storage section.
      * constants
       01 INTRO.
        05 filler pic x(8) value "ECBLUnit".
        05 filler pic x value SPACE.
        05 filler pic x(6) value "1.64.8".
        05 filler pic x value SPACE.
        05 filler pic x(35) value "by Olegs Kunicins and contributors.".
        05 filler pic x(2) value x'15'.
       01 HELP.
        05 filler pic x(13) value "Usage in JCL:".
        05 filler pic x(2) value x'15'.
        05 filler pic x(32) value "//RUN          EXEC PGM=ECBLUNIT".
        05 filler pic x(30) value ",PARM='<testA testB ...>'".

      * assertions
       01 assertions-counter pic 9(3) usage binary external.
       01 summary-pointer usage pointer external.
       01 summary.
        03 assertions-total pic 9(3) usage binary.
        03 failures-total pic 9(3) usage binary.
        03 assertions occurs 0 to 999 depending on assertions-counter.
         05 assertion-status pic x value SPACE.
          88 assertion-failed value "F".
         05 assertion-idx pic 9(9) usage binary.
         05 assertion-nr pic 9(3).
         05 assertion-name pic x(3) value SPACES.
         05 assertion-expected pic x(32).
         05 assertion-actual pic x(32).

      * handler
       01 ws-err-ptr usage procedure-pointer.
       01 ws-err-msg-ptr usage pointer.
       01 ws-err-fc pic x(12) value low-value.

      * args
       01 arg-idx pic 9(3) usage binary value 1.
       01 arg-first pic 9(3) usage binary value 1.

      * timestamps
       01 current-time.
        05 hours pic 9(2).
        05 minutes pic 9(2).
        05 seconds pic 9(2).
       01 elapsed-time.
        05 hours pic 9(2).
        05 minutes pic 9(2).
        05 seconds pic 9(2).

      * local
       01 idx pic 9(9) usage binary.
       01 diff-exp-str pic x(32) value SPACES.
       01 diff-act-str pic x(32) value SPACES.
       01 diff-pointer pic x(64) value SPACES.
       01 assertions-index pic 9(3) usage binary.
       01 test-pointer usage procedure-pointer.
       01 testsuite-name pic x(8) value SPACES.
       01 tests-total pic 9(3) usage binary.
       01 skipped-total pic 9(3) usage binary.
       01 errors-total pic 9(3) usage binary external.
       linkage section.
       01 arg.
        05 arg-len pic 9(3) usage binary.
        05 arg-value pic x(81) value SPACES.
       procedure division using arg.
       ecblu-init section.
           perform ecblu-start.

           add 1 to arg-len.
           move SPACE to arg-value(arg-len:1).
           perform varying arg-idx from 1 by 1 until arg-idx > arg-len
             if arg-value(arg-idx:1) = SPACE
               move arg-value(arg-first:arg-idx - arg-first) 
                    to testsuite-name
               compute arg-first = 1 + arg-idx
               perform ecblu-exec
             end-if
           end-perform.

           perform ecblu-finish.
           stop run.

       ecblu-start section.
           display INTRO.
           if arg-len = 0
              display HELP
              stop run
           end-if.

           *>set ws-err-ptr to entry "ECBLUERR".
           set ws-err-msg-ptr to address of testsuite-name.
           set summary-pointer to address of summary.
           accept elapsed-time from TIME.

       ecblu-exec section.
           add 1 to tests-total.
           set test-pointer to entry testsuite-name.
           *>call "CEEHDLR" using ws-err-ptr, ws-err-msg-ptr, ws-err-fc.
           call test-pointer.
           *>call "CEEHDLU" USING ws-err-ptr, ws-err-msg-ptr, ws-err-fc.

       ecblu-finish section.
           accept current-time from TIME.
           subtract corresponding current-time from elapsed-time.
           
           *> time
           display "Time: " 
             hours of elapsed-time ":" 
             minutes of elapsed-time ":" 
             seconds of elapsed-time.
       
           *> failures
           if failures-total of summary > 0
             display "There was " failures-total of summary 
             " failure(s):"
           end-if.
           perform varying assertions-index from 1 by 1 
             until assertions-index > assertions-total of summary
             if assertion-failed(assertions-index)
               *> filter special chars
               move assertion-expected(assertions-index) to diff-exp-str
               move assertion-actual(assertions-index) to diff-act-str
               perform varying idx from 1 by 1 
                 until idx > length of diff-exp-str
                 if diff-exp-str(idx:1) is not alphabetic 
                   and diff-exp-str(idx:1) is not numeric
                   move "."  to diff-exp-str(idx:1)
                 end-if
                 if diff-act-str(idx:1) is not alphabetic 
                   and diff-act-str(idx:1) is not numeric
                   move "."  to diff-act-str(idx:1)
                 end-if
               end-perform
               *> show expected
               display 
                 "#" assertion-nr(assertions-index) SPACE
                 assertion-name(assertions-index) SPACE
                 function hex-of(assertion-expected(assertions-index)) 
                 SPACE diff-exp-str 
               *> show actual
               display 
                 "         " 
                 function hex-of(assertion-actual(assertions-index))
                 SPACE diff-act-str
               *> show pointer
               move SPACES to diff-pointer
               compute idx = 8 + 
                 function mod(assertion-idx(assertions-index), 32) * 2
               move assertion-idx(assertions-index) to diff-pointer(1:)
               move "^^" to diff-pointer(idx:)
               display diff-pointer
             end-if
           end-perform.
       
           *> report
           if errors-total > 0
             display "EXCEPTIONS!"
             move 1 to RETURN-CODE 
           end-if.
           if failures-total of summary > 0
             display "FAILURES!"
             move 1 to RETURN-CODE 
           end-if.
           if errors-total = 0 and failures-total of summary = 0
             if tests-total > 0 and assertions-total of summary > 0
               display "OK"
             else 
               if tests-total = 0
                 display "No tests found"
               else 
                 display "No assertions found"
               end-if
             end-if
             move 0 to RETURN-CODE 
           end-if.
           display "Tests: " tests-total ", Skipped: " skipped-total.
           display "Assertions: " assertions-total of summary
             ", Failures: " failures-total of summary
             ", Exceptions: " errors-total.
       end program ECBLUNIT.

      * Error handler
       identification division.
       program-id. ECBLUERR.
       data division.
       working-storage section.
       01 errors-total pic 9(3) usage binary external.
       linkage section.
       01 curr-token pic x(12).
       01 token-ptr usage pointer.
       01 rc pic s9(9) usage binary.
       01 new-token pic x(12).
       01 testsuite-name pic x(8).
       procedure division using curr-token, token-ptr, rc, new-token.
           set address of testsuite-name to token-ptr.
           if testsuite-name not = SPACE
             add 1 to errors-total
             display SPACE
             display "There was an error in " testsuite-name
           end-if.
           move 10 to rc.
           move "*OMIT" to new-token.
       end program ECBLUERR.

      * Assert EQ
       identification division.
       program-id. ECBLUEQ.
       data division.
       working-storage section.
       01 assertions-counter pic 9(3) usage binary external.
       01 summary-pointer usage pointer external.
       01 assertions-nr pic 9(2).
       01 idx pic 9(2) usage binary.
       linkage section.
       01 expected pic x(32).
       01 actual pic x(32). 
       01 summary.
        03 assertions-total pic 9(3) usage binary.
        03 failures-total pic 9(3) usage binary.
        03 assertions occurs 0 to 999 depending on assertions-counter.
         05 assertion-status pic x value SPACE.
          88 assertion-failed value "F".
         05 assertion-idx pic 9(9) usage binary.
         05 assertion-nr pic 9(3).
         05 assertion-name pic x(3) value SPACES.
         05 assertion-expected pic x(32).
         05 assertion-actual pic x(32).
       procedure division using expected, actual.
           set address of summary to summary-pointer.
           add 1 to assertions-total.
           add 1 to assertions-nr.
           add 1 to assertions-counter.
           move assertions-nr to assertion-nr(assertions-counter).
           move "EQ" to assertion-name(assertions-counter).
           move expected to assertion-expected(assertions-counter).
           move actual to assertion-actual(assertions-counter).

           move 0 to assertion-idx(assertions-counter).
           perform varying idx from 1 by 1 until idx = length of actual
             if function hex-of(expected(idx:1)) not = 
               function hex-of(actual(idx:1))
               move idx to assertion-idx(assertions-counter)
               exit perform
             end-if
           end-perform.

           if assertion-idx(assertions-counter) not = 0
             move "F" to assertion-status(assertions-counter)
             add 1 to failures-total
           end-if.
       end program ECBLUEQ.

      * Assert NEQ
       identification division.
       program-id. ECBLUNEQ.
       data division.
       working-storage section.
       01 assertions-counter pic 9(3) usage binary external.
       01 summary-pointer usage pointer external.
       01 assertions-nr pic 9(2).
       01 idx pic 9(2) usage binary.
       linkage section.
       01 expected pic x(32).
       01 actual pic x(32). 
       01 summary.
        03 assertions-total pic 9(3) usage binary.
        03 failures-total pic 9(3) usage binary.
        03 assertions occurs 0 to 999 depending on assertions-counter.
         05 assertion-status pic x value SPACE.
          88 assertion-failed value "F".
         05 assertion-idx pic 9(9) usage binary.
         05 assertion-nr pic 9(3).
         05 assertion-name pic x(3) value SPACES.
         05 assertion-expected pic x(32).
         05 assertion-actual pic x(32).
       procedure division using expected, actual.
           set address of summary to summary-pointer.
           add 1 to assertions-total.
           add 1 to assertions-nr.
           add 1 to assertions-counter.
           move assertions-nr to assertion-nr(assertions-counter).
           move "NEQ" to assertion-name(assertions-counter).
           move expected to assertion-expected(assertions-counter).
           move actual to assertion-actual(assertions-counter).

           move 0 to assertion-idx(assertions-counter).
           perform varying idx from 1 by 1 until idx = length of actual
             if function hex-of(expected(idx:1)) not = 
               function hex-of(actual(idx:1))
               move idx to assertion-idx(assertions-counter)
               exit perform
             end-if
           end-perform.

           if assertion-idx(assertions-counter) = 0
             move "F" to assertion-status(assertions-counter)
             add 1 to failures-total
           end-if.
       end program ECBLUNEQ.

      * Assert REQ
       identification division.
       program-id. ECBLUREQ.
       data division.
       working-storage section.
       01 assertions-counter pic 9(3) usage binary external.
       01 summary-pointer usage pointer external.
       01 assertions-nr pic 9(2).
       01 expected-ptr usage pointer.
       01 expected-idx redefines expected-ptr pic 9(9) usage binary.
       01 actual-ptr usage pointer.
       01 actual-idx redefines actual-ptr pic 9(9) usage binary.
       01 idx pic 9(9) usage binary.
       linkage section.
       01 expected usage pointer.
       01 actual usage pointer. 
       01 len pic 9(9) usage binary.
       01 summary.
        03 assertions-total pic 9(3) usage binary.
        03 failures-total pic 9(3) usage binary.
        03 assertions occurs 0 to 999 depending on assertions-counter.
         05 assertion-status pic x value SPACE.
          88 assertion-failed value "F".
         05 assertion-idx pic 9(9) usage binary.
         05 assertion-nr pic 9(3).
         05 assertion-name pic x(3) value SPACES.
         05 assertion-expected pic x(32).
         05 assertion-actual pic x(32).
       01 actual-char pic x(32) value SPACES.
       01 expected-char pic x(32) value SPACES.
       procedure division using expected, actual, len.
           set address of summary to summary-pointer.
           add 1 to assertions-total.
           add 1 to assertions-nr.
           add 1 to assertions-counter.
           move assertions-nr to assertion-nr(assertions-counter).
           move "REQ" to assertion-name(assertions-counter).

           set actual-ptr to actual.
           set expected-ptr to expected.

           move 0 to assertion-idx(assertions-counter).
           perform varying idx from 1 by 1 until idx > len
             set address of actual-char to actual-ptr
             set address of expected-char to expected-ptr
             if function hex-of(expected-char(1:1)) not = 
               function hex-of(actual-char(1:1))
               move idx to assertion-idx(assertions-counter)
               *> rewind
               compute idx = function mod(idx, 32)
               compute expected-idx = expected-idx - idx + 1
               compute actual-idx = actual-idx - idx + 1
               set address of actual-char to actual-ptr
               set address of expected-char to expected-ptr
               move expected-char to 
                 assertion-expected(assertions-counter)
               move actual-char to 
                 assertion-actual(assertions-counter)
               exit perform
             end-if
             add 1 to expected-idx
             add 1 to actual-idx
           end-perform.

           if assertion-idx(assertions-counter) not = 0
             move "F" to assertion-status(assertions-counter)
             add 1 to failures-total
           end-if.
       end program ECBLUREQ.
