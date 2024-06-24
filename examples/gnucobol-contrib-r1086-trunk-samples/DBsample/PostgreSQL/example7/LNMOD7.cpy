      *>************************************************************************
      *>  This file is part of DBsample.
      *>
      *>  LNMOD7.cpy is free software: you can redistribute it and/or 
      *>  modify it under the terms of the GNU Lesser General Public License as 
      *>  published by the Free Software Foundation, either version 3 of the
      *>  License, or (at your option) any later version.
      *>
      *>  LNMOD7.cpy is distributed in the hope that it will be useful, 
      *>  but WITHOUT ANY WARRANTY; without even the implied warranty of 
      *>  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
      *>  See the GNU Lesser General Public License for more details.
      *>
      *>  You should have received a copy of the GNU Lesser General Public  
      *>  License along with LNMOD7.cpy.
      *>  If not, see <http://www.gnu.org/licenses/>.
      *>************************************************************************
      
      *>************************************************************************
      *> Program:      LNMOD7.cpy
      *>
      *> Purpose:      Linkage for the module PGMOD3.cbl
      *>
      *> Author:       Laszlo Erdos - https://www.facebook.com/wortfee
      *>
      *> Date-Written: 2018.07.13
      *>
      *> Usage:        Use this copy file in GnuCOBOL PostgreSQL programs.
      *>
      *>************************************************************************
      *> Date       Name / Change description 
      *> ========== ============================================================
      *> 2018.07.13 Laszlo Erdos: 
      *>            - first version. 
      *>************************************************************************
      
       01 LN-MOD.
         02 LN-INPUT.
           03 LN-FNC                      PIC X(2).
              88 V-LN-FNC-CONNECT         VALUE "CO".
              88 V-LN-FNC-DISCONNECT      VALUE "DC".
              88 V-LN-FNC-SELECT          VALUE "SE".
              88 V-LN-FNC-INSERT          VALUE "IN".
              88 V-LN-FNC-UPDATE          VALUE "UP".
              88 V-LN-FNC-DELETE          VALUE "DE".
              88 V-LN-FNC-PAGING-FIRST    VALUE "PF".
              88 V-LN-FNC-PAGING-NEXT     VALUE "PN".
              88 V-LN-FNC-PAGING-PREVIOUS VALUE "PP".
              88 V-LN-FNC-PAGING-LAST     VALUE "PL".
              88 V-LN-FNC-LIST-FIRST      VALUE "LF".
              88 V-LN-FNC-LIST-NEXT       VALUE "LN".
              88 V-LN-FNC-LIST-PREVIOUS   VALUE "LP".
              88 V-LN-FNC-LIST-LAST       VALUE "LL".
           03 LN-CONNECT.
             04 LN-DBNAME                 PIC X(20).
             04 LN-USERID                 PIC X(20).
             04 LN-PSWD                   PIC X(20).
           03 LN-INP-BOOK.
             04 LN-INP-ISBN               PIC 9(13).
             04 LN-INP-AUTHORS            PIC X(40).
             04 LN-INP-TITLE              PIC X(60).
             04 LN-INP-PUB-DATE           PIC X(10).
             04 LN-INP-PAGE-NR            PIC 9(4).
             04 LN-INP-LUPD-TIMESTAMP     PIC X(26).
             04 LN-INP-LUPD-COUNTER       PIC 9(6).
         02 LN-OUTPUT.
           03 LN-MSG.
             04 LN-SQLCODE                PIC S9(10).
             04 LN-SQLSTATE               PIC X(5).
             04 LN-MSG-1                  PIC X(80).
             04 LN-MSG-2                  PIC X(80).
             04 LN-MSG-3                  PIC X(80).
             04 LN-MSG-4                  PIC X(80).
           03 LN-OUT-BOOK.
             04 LN-OUT-ISBN               PIC 9(13).
             04 LN-OUT-AUTHORS            PIC X(40).
             04 LN-OUT-TITLE              PIC X(60).
             04 LN-OUT-PUB-DATE           PIC X(10).
             04 LN-OUT-PAGE-NR            PIC 9(4).
             04 LN-OUT-INSERT-USER        PIC X(20).
             04 LN-OUT-INSERT-TIMESTAMP   PIC X(26).
             04 LN-OUT-LUPD-USER          PIC X(20).
             04 LN-OUT-LUPD-TIMESTAMP     PIC X(26).
             04 LN-OUT-LUPD-COUNTER       PIC 9(6).
           03 LN-OUT-BOOK-TABLE.
             04 LN-OUT-BOOK-TAB-LINE-NR   PIC 9(2).
      *>     see constant C-MAX-LINE-NR = 10 in the programs       
             04 LN-OUT-BOOK-TAB OCCURS 10 TIMES. 
               05 LN-OUT-BOOK-TAB-LINE.
                 06 LN-OUT-BOOK-TAB-AUTHORS PIC X(40).
                 06 LN-OUT-BOOK-TAB-TITLE  PIC X(60).
                 06 LN-OUT-BOOK-TAB-ISBN   PIC 9(13).

