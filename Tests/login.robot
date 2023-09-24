*** Settings ***
Documentation    Cenários de testes do cadastro de usuários

Resource    ../resources/config.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve poder logar com um usuáro pré-cadastrado
    [Tags]    user_login

    ${user}    Create Dictionary    
    ...        name=Fernando Papito
    ...        email=papito@msn.com
    ...        password=123456
    
    Submit login form    ${user}

    User should be logged    ${user}[name]