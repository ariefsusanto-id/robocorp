*** Settings ***
Documentation     Standart Connection.
Library	          RPA.Database

*** Variables ***
# Database
${username}       postgres
${password}       postgres
${driver}         psycopg2
${database}       cobarobot
${server}         128.199.201.148
${port}           5432


*** Tasks ***
Minimal task
    Connect To Database    	${driver}  ${database}  ${username}  ${password}  ${server}  ${port}
    @{rows} =    Query   SELECT * FROM komunitas;
    FOR  ${row}  IN  @{rows}
      Log   ${row}
    END
    Disconnect From Database
    Log    Done.