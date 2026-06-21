*** Settings ***
Library           SeleniumLibrary
Library           Collections
Test Template    ทดสอบระบบเช็คราคาสินค้า

*** Variables ***
${URL}         https://www.saucedemo.com/
${BROWSER}     edge

*** Test Cases ***
AT_0013 User ID ปกติที่สามารถใช้งานได้และราคาสินค้าถูกต้อง
...    standard_user                                    # USERNAME  
...    secret_sauce                                     # PASSWORD 
...    https://www.saucedemo.com/inventory.html         # EXPECTED_URL
AT_0014 User ID ปกติที่สามารถใช้งานได้และราคาสินค้าถูกต้อง 
...    problem_user                                     # USERNAME
...    secret_sauce                                     # PASSWORD
...    https://www.saucedemo.com/inventory.html         # EXPECTED_URL
AT_0015 User ID ปกติที่สามารถใช้งานได้และราคาสินค้าถูกต้อง 
...    performance_glitch_user                          # USERNAME
...    secret_sauce                                     # PASSWORD
...    https://www.saucedemo.com/inventory.html         # EXPECTED_URL
AT_0016 User ID ปกติที่สามารถใช้งานได้และราคาสินค้าถูกต้อง 
...    error_user                                       # USERNAME
...    secret_sauce                                     # PASSWORD
...    https://www.saucedemo.com/inventory.html         # EXPECTED_URL
AT_0017 User ID ปกติที่สามารถใช้งานได้และราคาสินค้าถูกต้อง 
...    visual_user                                      # USERNAME
...    secret_sauce                                     # PASSWORD
...    https://www.saucedemo.com/inventory.html         # EXPECTED_URL



*** Keywords ***
ทดสอบระบบเช็คราคาสินค้า
    [Arguments]    ${username}    ${password}    ${expected_url}
    Open Browser    ${URL}    ${BROWSER}
    Input Text      id=user-name     ${username}
    Input Text      id=password     ${password}
    Click Button    id=login-button
    Wait Until Element Is Visible    css:.inventory_item    timeout=5s

    # รายการราคาที่ถูกต้อง (Expected)
    @{expected_prices}=    Create List    $29.99    $9.99    $15.99    $49.99    $7.99    $15.99

    # ดึงราคาทั้งหมดจากหน้าเว็บมาเก็บไว้ใน List
    @{elements}=    Get WebElements    css:.inventory_item_price
    
    # ลูปเพื่อเช็คทีละตัว
    FOR    ${index}    IN RANGE    0    6
        ${actual_price}=    Get Text    ${elements}[${index}]
        ${expected}=        Get From List    ${expected_prices}    ${index}
        
        Log To Console    เช็คราคาชิ้นที่ ${index+1}: บนเว็บคือ ${actual_price} | คาดหวังคือ ${expected}
        Should Be Equal As Strings    ${actual_price}    ${expected}
    END
    
    Close Browser
