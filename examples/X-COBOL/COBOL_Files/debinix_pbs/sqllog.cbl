      **********************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. sqllog.
      **********************************************************
      *
      * Authors: Peter B, Bertil K and Sergejs S.
      * Purpose: Log program SQL errors to log file
      * Initial Version Created: 2014-03-26
      *
      **********************************************************
       ENVIRONMENT DIVISION.
      *---------------------------------------------------------
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL sqllogfile
                  ASSIGN TO 'sqlerror.log'
                  ORGANIZATION IS LINE SEQUENTIAL.

      **********************************************************
       DATA DIVISION.
      *---------------------------------------------------------
       FILE SECTION.
       FD  sqllogfile.
       01  fd-sqllogfile-post.
           03  fc-yyyy                    PIC X(4).
           03  fc-sep-1                   PIC X.
           03  fc-monthmonth              PIC X(2).
           03  fc-sep-2                   PIC X.
           03  fc-dd                      PIC X(2).
           03  fc-sep-3                   PIC X.
           03  fc-hh                      PIC X(2).
           03  fc-sep-4                   PIC X.
           03  fc-mm                      PIC X(2).
           03  fc-sep-5                   PIC X.
           03  fc-ss                      PIC X(2).
           03  fc-sep-6                   PIC X.
           03  fc-tt                      PIC X(2).
           03  fc-sep-7                   PIC X.
           03  fc-log-text                PIC X(80).
           03  fc-sep-8                   PIC X.

      **********************************************************
       WORKING-STORAGE SECTION.
       01  wr-log-date-time.
           03  wr-yyyymmdd.
               05 wn-year     PIC 9(4) VALUE ZERO.
               05 wn-month    PIC 9(2) VALUE ZERO.
               05 wn-day      PIC 9(2) VALUE ZERO.
               03  wr-hhmmss.
                   05 wn-hour     PIC 9(2) VALUE ZERO.
                   05 wn-minute   PIC 9(2) VALUE ZERO.
                   05 wn-second   PIC 9(2) VALUE ZERO.
                   05 wn-hundred  PIC 9(2) VALUE ZERO.
           03  wc-other       PIC X(5) VALUE SPACE.


       LINKAGE SECTION.
      *---------------------------------------------------------
       01  lc-log-text                  PIC X(80).

      **********************************************************
       PROCEDURE DIVISION USING lc-log-text.
       000-sql-log.

           PERFORM A0100-append-msg-to-error-file

           EXIT PROGRAM
           .

      **********************************************************
       A0100-append-msg-to-error-file.

           MOVE FUNCTION CURRENT-DATE TO wr-log-date-time

      *    append data
           OPEN EXTEND sqllogfile

           MOVE wn-year TO fc-yyyy
           MOVE '-' TO fc-sep-1
           MOVE wn-month TO fc-monthmonth
           MOVE '-' TO fc-sep-2
           MOVE wn-day TO fc-dd
           MOVE 'T' TO fc-sep-3
           MOVE wn-hour TO fc-hh
           MOVE ':' TO fc-sep-4
           MOVE wn-minute TO fc-mm
           MOVE ':' TO fc-sep-5
           MOVE wn-second TO fc-ss
           MOVE ',' TO fc-sep-6
           MOVE wn-hundred TO fc-tt
           MOVE '|' TO fc-sep-7
           MOVE lc-log-text TO fc-log-text
           MOVE '|' TO fc-sep-8

           WRITE fd-sqllogfile-post

           CLOSE sqllogfile
           .

      **********************************************************
