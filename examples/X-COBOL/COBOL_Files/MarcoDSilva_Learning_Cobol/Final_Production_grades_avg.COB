      *=======================================================================*
       IDENTIFICATION DIVISION.
      *=======================================================================*
       PROGRAM-ID. PROD0V0.
      *************************************************************************
      *************************************************************************
      *************************************************************************
      *                           IEFP SOLUTIONS                              *
      *DATA:            02/09/2019                                            *
      *PROGRAMADOR:     Marco Silva                                           *
      *OBJECTIVO:                                                             *
      *               ESTE PROGRAMA SUPOSTAMENTE SERÁ UTILIZADO               *
      *              PARA AVALIAR O FORMANDO NA SUA " HABILIDADE"             *
      *                       DE COMPREENSÃO EM COBOL                         *
      *                                                                       *
      *                                                                       *
      *************************************************************************
      ***************************FIM DOCUMENTAÇÃO******************************

      *=======================================================================*
                             ENVIRONMENT DIVISION.

      *=======================================================================*
                             CONFIGURATION SECTION.
      *=======================================================================*
                               SPECIAL-NAMES.
      *=======================================================================*
                             INPUT-OUTPUT SECTION.
      *=======================================================================*
                               FILE-CONTROL.
      *=======================================================================*
                               DATA DIVISION.
      *=======================================================================*
                               FILE SECTION.
      *=======================================================================*
                           WORKING-STORAGE SECTION.

       77  input_grade         PIC z9.
       77  student_name        PIC A(20) VALUE SPACES.
       77  first_grade         PIC 9(2) VALUE 0.
       77  second_grade        PIC 9(2) VALUE 0.
       77  third_grade         PIC 9(2) VALUE 0.
       77  fourth_grade        PIC 9(2) VALUE 0.
       77  sum_grades          PIC 9(2) value zero.
       77  average             PIC S9(2)V99.
       77  avg_masked          PIC z9.99.
       77  exit_cmd            pic x(1) value null.
       77  exam_grade          pic 9(2) value zero.
       77  faulty_hours        pic 9(2) value zero.
       77  faulty_dec          pic 9(2)V99.
       77  faulty_masked       pic z9.99.

       01  actual_date.
           03 ac_year   PIC  9(2) values zero.
           03 ac_month  PIC  9(2) values zero.
           03 ac_day    PIC  9(2) values zero.

      *=======================================================================*
           PROCEDURE DIVISION.

           ACCEPT actual_date FROM DATE.
           DISPLAY "data: " AT 0125 ac_day "/" ac_month "/" ac_year.

           getName.
           DISPLAY "Insert the student name: " AT 0315.
           ACCEPT student_name AT 0340.

           IF (student_name IS NOT ALPHABETIC) OR
      -         (student_name IS EQUAL TO SPACES)
               GO TO getName
           END-IF.

           DISPLAY SPACE AT 0315 SPACE AT 0340.

           DISPLAY "_________________________________________" AT 0215.
           DISPLAY "Evaluating student: " AT 0315 student_name AT 0345.

      *      ======== ACCEPTING GRADES AND CHECKING THE VALUES =====          *
           firstGrade.
           DISPLAY "Insert first grade : " AT 0615.
           ACCEPT input_grade AT 0636.
           MOVE input_grade TO first_grade.

           IF (first_grade GREATER THAN 20) OR (first_grade LESS THAN 0)
              GO TO firstGrade
           END-IF.

           secondGrade.
           DISPLAY "Insert second grade : " AT 0815.
           ACCEPT input_grade AT 0836.
           MOVE input_grade TO second_grade.

           IF (second_grade > 20) OR (second_grade LESS THAN 0)
              GO TO secondGrade
           END-IF.

           thirdGrade.
           DISPLAY "Insert third grade : " AT 1015.
           ACCEPT input_grade AT 1036.
           MOVE input_grade TO third_grade.

           IF (third_grade GREATER THAN 20) OR (third_grade LESS THAN 0)
              GO TO thirdGrade
           END-IF.

           fourthGrade.
           DISPLAY "Insert fourth grade : " AT 1215.
           ACCEPT input_grade AT 1236.
           MOVE input_grade TO fourth_grade.

           IF (fourth_grade > 20) OR (fourth_grade LESS THAN 0)
              GO TO fourthGrade
           END-IF.

      *    ================ HOURS THE STUDENT SKIPPED ===============
           skippingHours.
           DISPLAY "Insert the hours the student skipped : " AT 1415.
           ACCEPT faulty_hours AT 1455.
           COMPUTE faulty_dec = (faulty_hours * 0.5);


      *        ============== AVERAGE CALCULATION ==================          *
           COMPUTE sum_grades  = first_grade + second_grade
      -        + third_grade + fourth_grade.

           COMPUTE average = (sum_grades / 4).
           MOVE average to avg_masked.

      *      ================= HOURS VS AVERAGE ====================
           IF (faulty_hours > 25)
               GO TO skull
           ELSE
               IF (faulty_dec > average)
                COMPUTE faulty_masked = (average - faulty_dec)
                DISPLAY "Student failed after skipping classes" AT 1515
                DISPLAY " - " AT 1560 faulty_masked at 1562
                GO TO BUBAY
           END-IF.

           DISPLAY "Average of the student: " AT 1515 avg_masked AT 1540

           DISPLAY "_________________________________________" AT 1615.

      *        ======== VERIFIES IF THE AVG ============
           IF (average < 10)
               DISPLAY "FAILED THE YEAR" AT 1715
               GO TO exam
           ELSE
               DISPLAY "CONGRATULATIONS YOU PASSED" AT 1715
           END-IF.

           ACCEPT exit_cmd at 1900.
           STOP RUN.

           exam.
               DISPLAY "Exam to recover the year grade: " AT 1815.
               ACCEPT exam_grade AT 1848

           IF (exam_grade GREATER THAN 20) OR (exam_grade LESS THAN 0)
              GO TO exam
           END-IF.

           COMPUTE exam_grade = ((exam_grade + average) / 2).
           MOVE exam_grade TO avg_masked.

           IF exam_grade GREATER or EQUAL to 10
               DISPLAY "CONGRATULATIONS YOU PASSED" AT 1915
      -        " with the average of " avg_masked AT 1965
           ELSE
               DISPLAY "YOU FAILED, LOSER!" AT 1915
           END-IF.

           skull.

           DISPLAY SPACE ERASE EOS.
           DISPLAY "YOU FAILED, LOSER!" AT 0115.
           DISPLAY "                    :::!~!!!!!:." AT 0215.
           DISPLAY "               .xUHWH!! !!?M88WHX:." AT 0315.
           DISPLAY "            .X*#M@$!!  !X!M$$$$$$WWx:." AT 0415.
           DISPLAY "            :!!!!!!?H! :!$!$$$$$$$$$$8X:" AT 0515.
           DISPLAY "           !!~  ~:~!! :~!$!#$$$$$$$$$$8X:" AT 0615.
           DISPLAY "           :!~::!H!<   ~.U$X!?R$$$$$$$$MM!" AT 0715.
           DISPLAY "           ~!~!!!!~~ .:XW$$$U!!?$$$$$$RMM!" AT 0815.
           DISPLAY "             !:~~~ .:!M""T#$$$$WX??#MRRMMM" AT 0915.
           DISPLAY "              ~?WuxiW*`  `'''#$$$$8!!!!??"  AT 1015.
           DISPLAY "          :X- M$$$$    `''T#$T~!8$WUXU~" AT 1115.
           DISPLAY "          :`  ~#$$$m:        ~!~ ?$$$$$$" AT 1215.
           DISPLAY "        :!`.-   ~T$$$$8xx.  .xWW- ~''##*"  AT 1315.
           DISPLAY "...  -~~:<` !    ~?T#$$@@W@*?$$      /`" AT 1415.
           DISPLAY "W$@M!!! .!~~ !!     .:XUW$W!~ `''~:    :" AT 1515.
           DISPLAY "#""~`.:x`!!  !H:   !WM$$$$Ti.: .!WUn+!`" AT 1615.
           DISPLAY "::::!!`:X~ .: ?H.!u '''$$$B$$$!W:U!T$$M~" AT 1715.
           DISPLAY ".~  :X@!.-~   ?@WTWo(''*$$$W$TH$! `" AT 1815.
           DISPLAY "W~!X$?!-~    : ?$$$B$Wu(''''**$RM!" AT 1915.
           DISPLAY "$i.~~ !     :   ~$$$$$B$$en:``" AT 2015.
           DISPLAY "?MX@Wx.~    :     ~''##*$$$$M~" AT 2115.

           BUBAY.
           ACCEPT exit_cmd at 2015.

       STOP RUN.

       END PROGRAM PROD0V0.
