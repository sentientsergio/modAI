       *>**
       *>  Tests
       *>
       *>  @author Olegs Kunicins, Simon Sobisch
       *>  @license LGPL-3.0
       *>
       *>  This library is free software; you can redistribute it and/or
       *>  modify it under the terms of the GNU Lesser General Public
       *>  License as published by the Free Software Foundation; either
       *>  version 3.0 of the License, or (at your option) any later 
       *>  version.
       *>  
       *>  This library is distributed in the hope that it will be 
       *>  useful, but WITHOUT ANY WARRANTY; without even the implied 
       *>  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
       *>  PURPOSE.  See the GNU Lesser General Public License for more
       *>  details.
       *>  
       *>  You should have received a copy of the GNU Lesser General 
       *>  Public License along with this library.
       *>**

      * Test equality
       identification division.
       program-id. TESTEQ.
       data division.
       working-storage section.
       01 num-data.
         05 disp     usage display   pic s99v999        value -12.34.
         05 disp-u   usage display   pic  99v999        value  12.34.
         05 dispp    usage display   pic spppp9999      value -.0000123.
         05 dispp-u  usage display   pic  pppp9999      value  .0000123.
         05 disppp   usage display   pic s9999pppp      value -12340000.
         05 disppp-u usage display   pic  9999pppp      value  12340000.
         05 bin      usage binary    pic s99v999        value -12.34.
         05 bin-u    usage binary    pic  99v999        value  12.34.
         05 cmp3     usage packed-decimal pic s99v999   value -12.34.
         05 cmp3-u   usage packed-decimal pic  99v999   value  12.34.
         05 cmp5     usage comp-5    pic s99v999        value -12.34.
         05 cmp5-u   usage comp-5    pic  99v999        value  12.34.
         05 chr      usage binary    pic s999           value -128.
         05 chr-u    usage binary    pic  999           value 254.
         05 shrt     usage binary    pic s9(5)          value -32768.
         05 shrt-u   usage binary    pic  9(5)    value 65535.
         05 long     usage binary    pic s9(18)   value -2147483648.
         05 long-u   usage binary    pic  9(18)   value  4294967295.
       01 num-data-alt.
         05 disp     usage display   pic s99v999        value -12.35.
         05 disp-u   usage display   pic  99v999        value  12.35.
         05 dispp    usage display   pic spppp9999      value -.0000124.
         05 dispp-u  usage display   pic  pppp9999      value  .0000124.
         05 disppp   usage display   pic s9999pppp      value -12350000.
         05 disppp-u usage display   pic  9999pppp      value  12350000.
         05 bin      usage binary    pic s99v999        value -12.33.
         05 bin-u    usage binary    pic  99v999        value  12.33.
         05 cmp3     usage packed-decimal pic s99v999   value -12.33.
         05 cmp3-u   usage packed-decimal pic  99v999   value  12.33.
         05 cmp5     usage comp-5    pic s99v999        value -12.33.
         05 cmp5-u   usage comp-5    pic  99v999        value  12.33.
         05 chr      usage binary    pic s999           value -127.
         05 chr-u    usage binary    pic  999           value 253.
         05 shrt     usage binary    pic s9(5)          value -32767.
         05 shrt-u   usage binary    pic  9(5)          value 65534.
         05 long     usage binary    pic s9(18)   value -2147483647.
         05 long-u   usage binary    pic  9(18)   value  4294967294.
       
       01 fl-data.
          05 dbl     usage comp-2         value -3.40282e+38.
          05 flt     usage comp-1         value 3.40282e+38.
       01 fl-data-alt.
          05 dbl     usage comp-2         value -3.30282e+38.
          05 flt     usage comp-1         value 3.30282e+38.
       
       01 anum-data.
          05 alpnum     pic x(36) value "some numb3rs 4 n00bs l1k3 m3".
          05 alpha      pic a(36) value "thats some text".
          05 edit-num1  pic --9.999.
          05 edit-num2  pic ++9.999.
          05 edit-num3  pic zz9.999.
       01 anum-data-alt.
          05 alpnum     pic x(36) value "some numb3rs 4 n11bs l1k3 m3".
          05 alpha      pic a(36) value "thats sometext".
          05 edit-num1  pic ++9.999.
          05 edit-num2  pic --9.999.
          05 edit-num3  pic -zz9.999.
       procedure division.
       all-tests section.
           perform num-data-test.
           perform fl-data-test.
           perform anum-data-test.
           goback.

       num-data-test section.
           call "ecblueq" using disp of num-data, disp of num-data.
           call "ecblueq" using disp-u of num-data, disp-u of num-data.
           call "ecblueq" using dispp of num-data, dispp of num-data.
           call "ecblueq" using dispp-u of num-data, 
              dispp-u of num-data.
           call "ecblueq" using disppp of num-data, disppp of num-data.
           call "ecblueq" using disppp-u of num-data,
              disppp-u of num-data.
           call "ecblueq" using bin of num-data, bin of num-data.
           call "ecblueq" using bin-u of num-data, bin-u of num-data.
           call "ecblueq" using cmp3 of num-data, cmp3 of num-data.
           call "ecblueq" using cmp3-u of num-data, cmp3-u of num-data.
           call "ecblueq" using cmp5 of num-data, cmp5 of num-data.
           call "ecblueq" using cmp5-u of num-data, cmp5-u of num-data.
           call "ecblueq" using chr of num-data, chr of num-data.
           call "ecblueq" using chr-u of num-data, chr-u of num-data.
           call "ecblueq" using shrt of num-data, shrt of num-data.
           call "ecblueq" using shrt-u of num-data, shrt-u of num-data.
           call "ecblueq" using long of num-data, long of num-data.
           call "ecblueq" using long-u of num-data, long-u of num-data.
       
       fl-data-test section.
           call "ecblueq" using dbl of fl-data, dbl of fl-data.
           call "ecblueq" using flt of fl-data, flt of fl-data.
       
       anum-data-test section.
           call "ecblueq" using alpnum of anum-data, alpnum of anum-data.
           call "ecblueq" using alpha of anum-data, alpha of anum-data.
       end program TESTEQ.

      * Test inequality
       identification division.
       program-id. TESTNEQ.
       data division.
       working-storage section.
       01 num-data.
         05 disp     usage display   pic s99v999        value -12.34.
         05 disp-u   usage display   pic  99v999        value  12.34.
         05 dispp    usage display   pic spppp9999      value -.0000123.
         05 dispp-u  usage display   pic  pppp9999      value  .0000123.
         05 disppp   usage display   pic s9999pppp      value -12340000.
         05 disppp-u usage display   pic  9999pppp      value  12340000.
         05 bin      usage binary    pic s99v999        value -12.34.
         05 bin-u    usage binary    pic  99v999        value  12.34.
         05 cmp3     usage packed-decimal pic s99v999   value -12.34.
         05 cmp3-u   usage packed-decimal pic  99v999   value  12.34.
         05 cmp5     usage comp-5    pic s99v999        value -12.34.
         05 cmp5-u   usage comp-5    pic  99v999        value  12.34.
         05 chr      usage binary    pic s999           value -128.
         05 chr-u    usage binary    pic  999           value 254.
         05 shrt     usage binary    pic s9(5)          value -32768.
         05 shrt-u   usage binary    pic  9(5)    value 65535.
         05 long     usage binary    pic s9(18)   value -2147483648.
         05 long-u   usage binary    pic  9(18)   value  4294967295.
       01 num-data-a.
         05 disp     usage display   pic s99v999        value -12.35.
         05 disp-u   usage display   pic  99v999        value  12.35.
         05 dispp    usage display   pic spppp9999      value -.0000124.
         05 dispp-u  usage display   pic  pppp9999      value  .0000124.
         05 disppp   usage display   pic s9999pppp      value -12350000.
         05 disppp-u usage display   pic  9999pppp      value  12350000.
         05 bin      usage binary    pic s99v999        value -12.33.
         05 bin-u    usage binary    pic  99v999        value  12.33.
         05 cmp3     usage packed-decimal pic s99v999   value -12.33.
         05 cmp3-u   usage packed-decimal pic  99v999   value  12.33.
         05 cmp5     usage comp-5    pic s99v999        value -12.33.
         05 cmp5-u   usage comp-5    pic  99v999        value  12.33.
         05 chr      usage binary    pic s999           value -127.
         05 chr-u    usage binary    pic  999           value 253.
         05 shrt     usage binary    pic s9(5)          value -32767.
         05 shrt-u   usage binary    pic  9(5)          value 65534.
         05 long     usage binary    pic s9(18)   value -2147483647.
         05 long-u   usage binary    pic  9(18)   value  4294967294.
       
       01 fl-data.
          05 dbl     usage comp-2         value -3.40282e+38.
          05 flt     usage comp-1         value 3.40282e+38.
       01 fl-data-a.
          05 dbl     usage comp-2         value -3.30282e+38.
          05 flt     usage comp-1         value 3.30282e+38.
       
       01 anum-data.
          05 alpnum     pic x(36) value "some numb3rs 4 n00bs l1k3 m3".
          05 alpha      pic a(36) value "thats some text".
          05 edit-num1  pic --9.999.
          05 edit-num2  pic ++9.999.
          05 edit-num3  pic zz9.999.
       01 anum-data-a.
          05 alpnum     pic x(36) value "some numb3rs 4 n11bs l1k3 m3".
          05 alpha      pic a(36) value "thats sometext".
          05 edit-num1  pic ++9.999.
          05 edit-num2  pic --9.999.
          05 edit-num3  pic -zz9.999.
       procedure division.
       all-tests section.
           perform num-data-test.
           perform fl-data-test.
           perform anum-data-test.
           goback.

       num-data-test section.
           call "ecbluneq" using disp of num-data-a, disp of num-data.
           call "ecbluneq" using disp-u of num-data-a, 
              disp-u of num-data.
           call "ecbluneq" using dispp of num-data-a, dispp of num-data.
           call "ecbluneq" using dispp-u of num-data-a, 
              dispp-u of num-data.
           call "ecbluneq" using disppp of num-data-a, 
              disppp of num-data.
           call "ecbluneq" using disppp-u of num-data-a, 
              disppp-u of num-data.
           call "ecbluneq" using bin of num-data-a, bin of num-data.
           call "ecbluneq" using bin-u of num-data-a, bin-u of num-data.
           call "ecbluneq" using cmp3 of num-data-a, cmp3 of num-data.
           call "ecbluneq" using cmp3-u of num-data-a, 
              cmp3-u of num-data.
           call "ecbluneq" using cmp5 of num-data-a, cmp5 of num-data.
           call "ecbluneq" using cmp5-u of num-data-a, 
              cmp5-u of num-data.
           call "ecbluneq" using chr of num-data-a, chr of num-data.
           call "ecbluneq" using chr-u of num-data-a, chr-u of num-data.
           call "ecbluneq" using shrt of num-data-a, shrt of num-data.
           call "ecbluneq" using shrt-u of num-data-a, 
              shrt-u of num-data.
           call "ecbluneq" using long of num-data-a, long of num-data.
           call "ecbluneq" using long-u of num-data-a, 
              long-u of num-data.
       
       fl-data-test section.
           call "ecbluneq" using dbl of fl-data-a, dbl of fl-data.
           call "ecbluneq" using flt of fl-data-a, flt of fl-data.
       
       anum-data-test section.
           call "ecbluneq" using alpnum of anum-data-a, 
              alpnum of anum-data.
           call "ecbluneq" using alpha of anum-data-a, 
              alpha of anum-data.
           call "ecbluneq" using edit-num1 of anum-data-a, 
              edit-num1 of anum-data.
           call "ecbluneq" using edit-num2 of anum-data-a, 
              edit-num2 of anum-data.
           call "ecbluneq" using edit-num3 of anum-data-a, 
              edit-num3 of anum-data.
       end program TESTNEQ.

      * Test record equality
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TESTREQ.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 actual.
         05 FILLER PIC X(5) VALUE "Hello".
         05 FILLER PIC X VALUE SPACE.
         05 actual-field PIC X(5) VALUE "World".
       01 expected-a PIC X(2) VALUE "He".
       01 expected-b PIC X(11) VALUE "Hello World".
       01 expected-c PIC X(2) VALUE "Wo".
       PROCEDURE DIVISION.
           CALL "ECBLUREQ" USING
             BY CONTENT ADDRESS OF expected-a
             BY CONTENT ADDRESS OF actual
             BY CONTENT LENGTH OF expected-a.
           CALL "ECBLUREQ" USING
             BY CONTENT ADDRESS OF expected-b
             BY CONTENT ADDRESS OF actual
             BY CONTENT LENGTH OF expected-b.
           CALL "ECBLUREQ" USING
             BY CONTENT ADDRESS OF expected-c
             BY CONTENT ADDRESS OF actual-field
             BY CONTENT LENGTH OF expected-c.
       END PROGRAM TESTREQ.

      * Test error
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TESTERR.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
        01 WS-RESULT PIC 9 USAGE BINARY.
        01 WS-DIV PIC 9 USAGE BINARY.
       PROCEDURE DIVISION.
      D    DISPLAY "A debug line".
           COMPUTE WS-RESULT = 1 / WS-DIV.
       END PROGRAM TESTERR.

      * Test diff
       identification division.
       program-id. testdiff.
       data division.
       working-storage section.
       01 num-data.
         05 disp     usage display   pic s99v999        value -12.34.
         05 disp-u   usage display   pic  99v999        value  12.34.
         05 dispp    usage display   pic spppp9999      value -.0000123.
         05 dispp-u  usage display   pic  pppp9999      value  .0000123.
         05 disppp   usage display   pic s9999pppp      value -12340000.
         05 disppp-u usage display   pic  9999pppp      value  12340000.
         05 bin      usage binary    pic s99v999        value -12.34.
         05 bin-u    usage binary    pic  99v999        value  12.34.
         05 cmp3     usage packed-decimal pic s99v999   value -12.34.
         05 cmp3-u   usage packed-decimal pic  99v999   value  12.34.
         05 cmp5     usage comp-5    pic s99v999        value -12.34.
         05 cmp5-u   usage comp-5    pic  99v999        value  12.34.
         05 chr      usage binary    pic s999           value -128.
         05 chr-u    usage binary    pic  999           value 254.
         05 shrt     usage binary    pic s9(5)          value -32768.
         05 shrt-u   usage binary    pic  9(5)    value 65535.
         05 long     usage binary    pic s9(18)   value -2147483648.
         05 long-u   usage binary    pic  9(18)   value  4294967295.
       01 num-data-a.
         05 disp     usage display   pic s99v999        value -12.35.
         05 disp-u   usage display   pic  99v999        value  12.35.
         05 dispp    usage display   pic spppp9999      value -.0000124.
         05 dispp-u  usage display   pic  pppp9999      value  .0000124.
         05 disppp   usage display   pic s9999pppp      value -12350000.
         05 disppp-u usage display   pic  9999pppp      value  12350000.
         05 bin      usage binary    pic s99v999        value -12.33.
         05 bin-u    usage binary    pic  99v999        value  12.33.
         05 cmp3     usage packed-decimal pic s99v999   value -12.33.
         05 cmp3-u   usage packed-decimal pic  99v999   value  12.33.
         05 cmp5     usage comp-5    pic s99v999        value -12.33.
         05 cmp5-u   usage comp-5    pic  99v999        value  12.33.
         05 chr      usage binary    pic s999           value -127.
         05 chr-u    usage binary    pic  999           value 253.
         05 shrt     usage binary    pic s9(5)          value -32767.
         05 shrt-u   usage binary    pic  9(5)          value 65534.
         05 long     usage binary    pic s9(18)   value -2147483647.
         05 long-u   usage binary    pic  9(18)   value  4294967294.
       
       01 fl-data.
          05 dbl     usage comp-2         value -3.40282e+38.
          05 flt     usage comp-1         value 3.40282e+38.
       01 fl-data-a.
          05 dbl     usage comp-2         value -3.30282e+38.
          05 flt     usage comp-1         value 3.30282e+38.
       
       01 anum-data.
          05 alpnum     pic x(36) value "some numb3rs 4 n00bs l1k3 m3".
          05 alpha      pic a(36) value "thats some text".
          05 edit-num1  pic --9.999.
          05 edit-num2  pic ++9.999.
          05 edit-num3  pic zz9.999.
       01 anum-data-a.
          05 alpnum     pic x(36) value "some numb3rs 4 n11bs l1k3 m3".
          05 alpha      pic a(36) value "thats sometext".
          05 edit-num1  pic ++9.999.
          05 edit-num2  pic --9.999.
          05 edit-num3  pic -zz9.999.
       procedure division.
       all-tests section.
           perform num-data-test.
           perform fl-data-test.
           perform anum-data-test.
           perform anum-pointer-test.
           goback.

       num-data-test section.
           call "ecblueq" using disp of num-data-a, disp of num-data.
           call "ecblueq" using disp-u of num-data-a, 
              disp-u of num-data.
           call "ecblueq" using dispp of num-data-a, dispp of num-data.
           call "ecblueq" using dispp-u of num-data-a, 
              dispp-u of num-data.
           call "ecblueq" using disppp of num-data-a, 
              disppp of num-data.
           call "ecblueq" using disppp-u of num-data-a, 
              disppp-u of num-data.
           call "ecblueq" using bin of num-data-a, bin of num-data.
           call "ecblueq" using bin-u of num-data-a, bin-u of num-data.
           call "ecblueq" using cmp3 of num-data-a, cmp3 of num-data.
           call "ecblueq" using cmp3-u of num-data-a, 
              cmp3-u of num-data.
           call "ecblueq" using cmp5 of num-data-a, cmp5 of num-data.
           call "ecblueq" using cmp5-u of num-data-a, 
              cmp5-u of num-data.
           call "ecblueq" using chr of num-data-a, chr of num-data.
           call "ecblueq" using chr-u of num-data-a, chr-u of num-data.
           call "ecblueq" using shrt of num-data-a, shrt of num-data.
           call "ecblueq" using shrt-u of num-data-a, 
              shrt-u of num-data.
           call "ecblueq" using long of num-data-a, long of num-data.
           call "ecblueq" using long-u of num-data-a, 
              long-u of num-data.
       
       fl-data-test section.
           call "ecblueq" using dbl of fl-data-a, dbl of fl-data.
           call "ecblueq" using flt of fl-data-a, flt of fl-data.
       
       anum-data-test section.
           call "ecblueq" using alpnum of anum-data-a, 
              alpnum of anum-data.
           call "ecblueq" using alpha of anum-data-a, 
              alpha of anum-data.
           call "ecblueq" using edit-num1 of anum-data-a, 
              edit-num1 of anum-data.
           call "ecblueq" using edit-num2 of anum-data-a, 
              edit-num2 of anum-data.
           call "ecblueq" using edit-num3 of anum-data-a, 
              edit-num3 of anum-data.

       anum-pointer-test section.
           call "ecblureq" using 
             by content address of alpnum of anum-data-a,
             by content address of alpnum of anum-data,
             by content length of alpnum of anum-data-a.
           call "ecblureq" using 
             by content address of alpha of anum-data-a,
             by content address of alpha of anum-data,
             by content length of alpha of anum-data-a.
           call "ecblureq" using 
             by content address of edit-num1 of anum-data-a,
             by content address of edit-num1 of anum-data,
             by content length of edit-num1 of anum-data-a.
           call "ecblureq" using 
             by content address of edit-num2 of anum-data-a,
             by content address of edit-num2 of anum-data,
             by content length of edit-num2 of anum-data-a.
           call "ecblureq" using 
             by content address of edit-num3 of anum-data-a,
             by content address of edit-num3 of anum-data,
             by content length of edit-num3 of anum-data-a.
       end program testdiff.
