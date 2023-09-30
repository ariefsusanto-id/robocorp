*** Settings ***
Documentation      Enter weekly sales into the RobotSpareBin Industries Intranet.
Library            RPA.Browser.Selenium  auto_close=${FALSE}
Library            RPA.HTTP
Library            RPA.Excel.Files
Library            RPA.PDF

*** Variables ***
${URL}             https://robotsparebinindustries.com/
${filedownload}    https://robotsparebinindustries.com/SalesData.xlsx
${username}    maria
${password}    thoushallnotpass


*** Tasks ***
Open the intranet site and log in
    Open the intranet website
    Log in
    Download the Excel file
#    Fill and submit the form
    Fill the form using the data from the Excel file
    Collect the results
    Export the table as a PDF
    [Teardown]    Log out and close the browser


*** Keywords ***
Open the intranet website
    Open Available Browser     ${URL}

Log in
    Input Text        username    ${username}
    Input Password    password    ${password}
    Submit Form
    Wait Until Page Contains Element    id:sales-form

Download the Excel file
    Download   ${filedownload}     overwrite=True

Fill and submit the form
    Input Text        firstname    maria
    Input Text        lastname    maria
    Input Text        salesresult    15000
    Select From List By Value    salestarget    10000
    Click Button    Submit


Fill and submit the form for one person
    [Arguments]    ${sales_rep}
    Input Text    firstname    ${sales_rep}[First Name]
    Input Text    lastname    ${sales_rep}[Last Name]
    Input Text    salesresult    ${sales_rep}[Sales]
    Select From List By Value    salestarget    ${sales_rep}[Sales Target]
    Click Button    Submit
    Wait Until Page Contains Element    id:sales-form

Fill the form using the data from the Excel file
    Open Workbook    SalesData.xlsx
    ${sales_reps}=    Read Worksheet As Table    header=True
    Close Workbook
    FOR    ${sales_rep}    IN    @{sales_reps}
        Fill and submit the form for one person    ${sales_rep}
    END

Collect the results
    Screenshot    css:div.sales-summary    ${OUTPUT_DIR}${/}sales_summary.png

Export the table as a PDF
    Wait Until Element Is Visible    id:sales-results
    ${sales_results_html}=    Get Element Attribute    id:sales-results    outerHTML
    Html To Pdf    ${sales_results_html}    ${OUTPUT_DIR}${/}sales_results.pdf

Log out and close the browser
    Click Button    Log out
    Close Browser