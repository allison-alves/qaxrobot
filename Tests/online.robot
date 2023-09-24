*** Settings ***
Documentation    online

Resource    ../resources/config.resource

*** Test Cases ***
Web app deve estar online

    Start Session
    
    Get Title    equal    Mark85 by QAx