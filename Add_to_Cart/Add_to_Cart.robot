*** Settings ***
Library          SeleniumLibrary
Test Template    ทดสอบระบบ Add to Cart 

*** Variables ***
${URL}           https://www.saucedemo.com/
${BROWSER}       edge
# จำนวนสินค้าในตะกร้า
${CART_BADGE}           css:[data-test="shopping-cart-badge"]
# Product IDs 
${btn_add_1}    add-to-cart-sauce-labs-backpack
${btn_add_2}    add-to-cart-sauce-labs-bike-light
${btn_add_3}    add-to-cart-sauce-labs-bolt-t-shirt
${btn_add_4}    add-to-cart-sauce-labs-fleece-jacket
${btn_add_5}    add-to-cart-sauce-labs-onesie
${btn_add_6}    add-to-cart-test.allthethings()-t-shirt-(red)
# Remove Buttons 
${btn_remove_1}     remove-sauce-labs-backpack
${btn_remove_2}     remove-sauce-labs-bolt-t-shirt
${btn_remove_3}     remove-sauce-labs-bike-light
${btn_remove_4}     remove-sauce-labs-fleece-jacket
${btn_remove_5}     remove-sauce-labs-onesie
${btn_remove_6}     remove-test.allthethings()-t-shirt-(red)
# ทำ list 
@{ALL_ADD_BUTTONS}    ${btn_add_1}    ${btn_add_2}    ${btn_add_3}    ${btn_add_4}    ${btn_add_5}    ${btn_add_6}
@{ALL_REMOVE_BUTTONS}    ${btn_remove_1}    ${btn_remove_2}    ${btn_remove_3}    ${btn_remove_4}    ${btn_remove_5}    ${btn_remove_6}

*** Test Cases *** 
AT_00018 สั่งสินค้าหลายชิ้นและเช็คยอดตะกร้าของ User ID ปกติที่สามารถใช้งานได้
...    standard_user                                    # USERNAME
...    secret_sauce                                     # PASSWORD
AT_0019 สั่งสินค้าหลายชิ้นและเช็คยอดตะกร้าของ User ID ปกติที่สามารถใช้งานได้
...    problem_user                                     # USERNAME
...    secret_sauce                                     # PASSWORD
AT_0020 สั่งสินค้าหลายชิ้นและเช็คยอดตะกร้าของ User ID ปกติที่สามารถใช้งานได้ 
...    performance_glitch_user                          # USERNAME
...    secret_sauce                                     # PASSWORD
AT_0021 สั่งสินค้าหลายชิ้นและเช็คยอดตะกร้าของ User ID ปกติที่สามารถใช้งานได้
...    error_user                                       # USERNAME
...    secret_sauce                                     # PASSWORD
AT_0022 AT_0021 สั่งสินค้าหลายชิ้นและเช็คยอดตะกร้าของ User ID ปกติที่สามารถใช้งานได้

...    visual_user                                      # USERNAME
...    secret_sauce                                     # PASSWORD
*** Keywords ***
ทดสอบระบบ Add to Cart 
    [Arguments]    ${username}    ${password}
    
    Open Browser    ${URL}    ${BROWSER}
    
    # Login เข้าสู่ระบบ
    Input Text      id=user-name    ${username}
    Input Text      id=password     ${password}
    Click Button    id=login-button
    Wait Until Element Is Visible    css:.inventory_list    timeout=2s

    # ตั้งค่าตัวนับตะกร้าที่ 0
    ${cart_count}=    Set Variable    0
    Log To Console    \n
    FOR    ${btn_add}    IN    @{ALL_ADD_BUTTONS}
        
        # แอดสินค้าลงตะกร้าและเพิ่มตัวนับตะกร้า
        Click Button    css:[data-test="${btn_add}"]
        ${cart_count}=    Evaluate    ${cart_count} + 1
        
        # รีเฟรชหน้าเว็บเพื่อเช็คว่าตะกร้าอัปเดตถูกต้องหรือไม่
        Reload Page
        Wait Until Element Is Visible    css:.inventory_list    timeout=2s
        Element Text Should Be    ${CART_BADGE}    ${cart_count}
        
        Log To Console    สินค้าชิ้นที่ ${cart_count} รีเฟรชเว็บแล้วตะกร้ายังอัปเดตเป็น ${cart_count} ชิ้น!
    END
    
    ${total_items}=    Get Length    ${ALL_ADD_BUTTONS}
    Element Text Should Be    ${CART_BADGE}    ${total_items}
    Log To Console    \n
    Log To Console   ตะกร้ามีจำนวนสินค้า ${total_items} ชิ้นครบถ้วน
    Log To Console    \n
    Close Browser