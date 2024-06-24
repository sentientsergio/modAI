#!/bin/bash

# SQLCA: SQL Communications Area for Ocesql
COPY=/home/$USER/Open-COBOL-ESQL-1.2/copy
SCR=/usr/local/share/gnucobol/copy
OC_OBJ=/home/$USER/Open-COBOL-ESQL-1.2/dblib

# clean
rm PGTEST7
rm PGMOD7.cob

# SQL precompile
ocesql PGMOD7.cbl PGMOD7.cob

# static compile
cobc -x PGTEST7.cob PGMOD7.cob PGSQLMSG.cob $OC_OBJ/ocdb.o $OC_OBJ/ocdblog.o $OC_OBJ/ocdbutil.o $OC_OBJ/ocesql.o $OC_OBJ/ocpgsql.o -I$COPY -I$SCR -locesql -lpq
