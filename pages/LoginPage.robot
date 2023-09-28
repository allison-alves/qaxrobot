*** Settings ***
Documentation    Elementos e ações da página de login

Library    Browser
Library    String


Resource    ../resources/env.resource

*** Keywords *** 
Submit login form
    [Arguments]    ${user}

    Fill Text    css=input[placeholder$=mail]    ${user}[email]
    Fill Text    css=input[placeholder=Senha]    ${user}[password]

    Click    css=button >> text=Entrar

User should be logged
    [Arguments]    ${name}

    @{splited_name}    Split String    ${name}
    
    ${element_header}    Set Variable    css=header .right small 

    Wait For Elements State    ${element_header}    visible    5

    Get Text    ${element_header}    equal    Olá, ${splited_name}[0]
    