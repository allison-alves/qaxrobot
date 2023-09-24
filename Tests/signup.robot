*** Settings ***
Documentation    Cenários de testes do cadastro de usuários

Resource    ../resources/config.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuario
    [Tags]    new_user

    #Váriaveis
    ${user}    Create Dictionary    
    ...        name=Fernando Papito
    ...        email=papito@yahoo.com
    ...        password=pwd123
    
    # limpa o cadastro do banco de dados antes de iniciar a pagina
    Remove user from database    ${user}[email]
    
    #Navega até a página
    Go to signup page
    
    #Preenche e envia o formulário
    Submit signup form    ${user}
    
    #Valida a mensagem
    Notice should be    Boas vindas ao Mark85, o seu gerenciador de tarefas.
    
Não deve permitir o email com cadastro duplicado
    [Tags]    double

    ${user}    Create Dictionary    
    ...        name=Papito Fernando
    ...        email=papito@gmail.com
    ...        password=pwd123

    # limpa o cadastro do banco de dados antes de iniciar a pagina
    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    
    #Navega até a página de cadastro
    Go to signup page
    
    #Preenche e envia o formulário
    Submit signup form    ${user}
    
    #Valida a mensagem
    Notice should be    Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios
    [Tags]    required

    ${user}    Create Dictionary    
    ...        name=${EMPTY}
    ...        email=${EMPTY}
    ...        password=${EMPTY}
    
    #Navega até a página de cadastro
    Go to signup page

    #Preenche e envia o formulário
  Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos
   Submit signup form    ${user}
    
    #Valida os campos obrigatorios
   
Não deve cadastrar com email incorreto
    [Tags]    inv_email
    
    #váriaveis do teste
    ${user}    Create Dictionary
    ...        name=Charles Xavier
    ...        email=xavier.com.br
    ...        password=123456
    
    #Navega até a página de cadastro
    Go to signup page
    
    #Preenche e envia o formulário
    Submit signup form    ${user}

    #Valida a mensagem de alerta email incorreto
    Alert should be    Digite um e-mail válido

Não deve cadastrar com senha muito curta
    [Tags]    short_pass
    
    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
    
    ${user}    Create Dictionary    
    ...        name=Charles Papito
    ...        email=charles@gmail.com
    ...        password=${password}
    
    #Navega até a página de cadastro
    Go to signup page

    #Preenche e envia o formulário
    Submit signup form    ${user}
    
    #Valida o tamanho da senha

    Alert should be    Informe uma senha com pelo menos 6 digitos
        
    END