*** Settings ***
Documentation    Elementos e ações da página de cadastro

Library    Browser

Resource    ../resources/env.resource

*** Keywords ***
Go to signup page
    Go To    ${BASE_URL}/signup
    
    # valida se o usuário encontra-se na página correta
    Wait For Elements State    h1    visible    5
    Get Text                   h1    equal    Faça seu cadastro
    
Submit signup form
    [Arguments]    ${user}
    # preenche os campos para realizar o cadastro
    Fill Text    id=name        ${user}[name]
    Fill Text    id=email       ${user}[email]
    Fill Text    id=password    ${user}[password]
    
    # envia o formulário de cadastro
    Click    id=buttonSignup

Notice should be
    [Arguments]    ${expected_text}

    ${element_notice}    Set Variable    css=.notice p

    # valida se o usuário novo usuario foi cadastrado com sucesso
    Wait For Elements State      ${element_notice}      visible    5
    Get Text                     ${element_notice}      equal      ${expected_text}

Alert should be
    [Arguments]    ${expected_text}

    ${element_alert}    Set Variable    css=.alert-error
    
    Wait For Elements State    ${element_alert} >> text=${expected_text}    visible    5