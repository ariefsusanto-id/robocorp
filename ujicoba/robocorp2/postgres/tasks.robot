*** Settings ***
Library        RPA.Windows
Library        RPA.core.notebook
*** Keywords ***
Calculator
    Windows Search    outlook    wait_time=5.0
    Click    name:Name	Send/Receive All Folders




*** Tasks ***
Minimal Tasks 
    Calculator 
