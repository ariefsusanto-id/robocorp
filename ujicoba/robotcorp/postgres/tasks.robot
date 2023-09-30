*** Settings ***
Library         RPA.Database

*** Tasks ***
Get Orders From Database
    Connect To Database  psycopg3  training  postgres  postgres  128.199.201.148
    @{orders}            Query    Select * FROM agenda
    FOR    ${order}    IN    @{orders}
        Handle Order    ${order}
    END