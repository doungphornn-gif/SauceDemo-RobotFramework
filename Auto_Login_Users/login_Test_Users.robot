*** Settings ***
Library          SeleniumLibrary
Test Template    ทดสอบระบบ login User

*** Variables ***
${URL}           https://www.saucedemo.com/
${BROWSER}       edge

*** Test Cases ***                                                      
AT_0001 User ID ปกติที่สามารถใช้งานได้
...    standard_user                                    # USERNAME  
...    secret_sauce                                     # PASSWORD 
...    https://www.saucedemo.com/inventory.html         # EXPECTED_URL
AT_0002 User ID ทีั่โดนบล็อกจากระบบไม่สามารถใช้งานได้           
...    locked_out_user                                  # USERNAME 
...    secret_sauce                                     # PASSWORD
...    https://www.saucedemo.com/                       # EXPECTED_URL
AT_0003 User ID ปกติที่สามารถใช้งานได้ 
...    problem_user                                     # USERNAME
...    secret_sauce                                     # PASSWORD
...    https://www.saucedemo.com/inventory.html         # EXPECTED_URL
AT_0004 User ID ปกติที่สามารถใช้งานได้ 
...    performance_glitch_user                          # USERNAME
...    secret_sauce                                     # PASSWORD
...    https://www.saucedemo.com/inventory.html         # EXPECTED_URL
AT_0005 User ID ปกติที่สามารถใช้งานได้ 
...    error_user                                       # USERNAME
...    secret_sauce                                     # PASSWORD
...    https://www.saucedemo.com/inventory.html         # EXPECTED_URL
AT_0006 User ID ปกติที่สามารถใช้งานได้ 
...    visual_user                                      # USERNAME
...    secret_sauce                                     # PASSWORD
...    https://www.saucedemo.com/inventory.html         # EXPECTED_URL
AT_0007 User กรณี ID User ถูกแต่ password ผิด
...    standard_user                                    # USERNAME
...    wrong_password                                   # PASSWORD
...    https://www.saucedemo.com/                       # EXPECTED_URL
AT_0008 User กรณี ID User ผิดแต่ password ถูก
...    A001                                             # USERNAME
...    secret_sauce                                     # PASSWORD
...    https://www.saucedemo.com/         # EXPECTED_URL
AT_0009 User กรณี ID User และ password ไม่ถูก
...    A001                                             # USERNAME
...    wrong_password                                   # PASSWORD
...    https://www.saucedemo.com/                       # EXPECTED_URL
AT_0010 User กรณี ID User และ password ไม่ใส่
...    ${EMPTY}                                         # USERNAME
...    ${EMPTY}                                         # PASSWORD
...    https://www.saucedemo.com/                       # EXPECTED_URL
AT_0011 User กรณี ID User ถูกแต่ password ไม่ใส่
...    standard_user                                    # USERNAME
...    ${EMPTY}                                         # PASSWORD
...    https://www.saucedemo.com/                       # EXPECTED_URL
AT_0012 User กรณี ID User ไม่ใส่แต่ password ถูก
...    ${EMPTY}                                         # USERNAME
...    secret_sauce                                     # PASSWORD
...    https://www.saucedemo.com/                       # EXPECTED_URL

*** Keywords ***
ทดสอบระบบ login User
    [Arguments]    ${username}    ${password}    ${expected_url}
    Open Browser    ${URL}    ${BROWSER}
    
    Input Text      id=user-name    ${username}
    Input Text      id=password     ${password}
    Click Button    id=login-button
    
    Wait Until Location Is    ${expected_url}    timeout=2s

    Close Browser