*** Settings ***

Library     Browser
Library     libs/database.py
Library     String   

Resource    env.resource
Resource    ../pages/SignupPage.robot
Resource    ../pages/LoginPage.robot

*** Keywords ***
Start Session
    New Browser    browser=chromium    headless=false
    New Page       ${BASE_URL}