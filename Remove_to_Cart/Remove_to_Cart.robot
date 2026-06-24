*** Settings ***
Library          SeleniumLibrary
Test Template    ทดสอบระบบ Remove from Cart 

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

AT_00023 ลบสินค้าหลายชิ้นและเช็คยอดตะกร้าของ User ID ปกติที่สามารถใช้งานได้
...    standard_user                                    # USERNAME
...    secret_sauce                                     # PASSWORD
AT_0024 ลบสินค้าหลายชิ้นและเช็คยอดตะกร้าของ User ID ปกติที่สามารถใช้งานได้
...    problem_user                                     # USERNAME
...    secret_sauce                                     # PASSWORD
AT_0025 ลบสินค้าหลายชิ้นและเช็คยอดตะกร้าของ User ID ปกติที่สามารถใช้งานได้ 
...    performance_glitch_user                          # USERNAME
...    secret_sauce                                     # PASSWORD
AT_0026 ลบสินค้าหลายชิ้นและเช็คยอดตะกร้าของ User ID ปกติที่สามารถใช้งานได้
...    error_user                                       # USERNAME
...    secret_sauce                                     # PASSWORD
AT_0027 ลบสินค้าหลายชิ้นและเช็คยอดตะกร้าของ User ID ปกติที่สามารถใช้งานได้

...    visual_user                                      # USERNAME
...    secret_sauce                                     # PASSWORD

*** Keywords ***
ทดสอบระบบ Remove from Cart
    [Arguments]    ${username}    ${password}
    Open Browser    ${URL}    ${BROWSER}
    
    # Login เข้าสู่ระบบ
    Input Text      id=user-name    ${username}
    Input Text      id=password     ${password}
    Click Button    id=login-button
    Wait Until Element Is Visible    css:.inventory_list    timeout=2s

    Log To Console    \n

    # Add สินค้าทุกชิ้นใส่ตะกร้า
    FOR    ${btn_add}    IN    @{ALL_ADD_BUTTONS}
        Click Button    css:[data-test="${btn_add}"]
    END
    
    # เช็คว่าตะกร้ามี 6 ชิ้นเต็ม
    ${total_items}=    Get Length    ${ALL_ADD_BUTTONS}
    Element Text Should Be    ${CART_BADGE}    ${total_items}
    Log To Console    ตะกร้าเริ่มต้นมีสินค้า ${total_items} ชิ้น ครบถ้วน!

    # ลูป REMOVE ลบสินค้าออกทีละชิ้น
    ${cart_count}=    Set Variable    ${total_items}

    FOR    ${btn_remove}    IN    @{ALL_REMOVE_BUTTONS}
        
        # กดปุ่มลบสินค้า
        Click Button    css:[data-test="${btn_remove}"]
        
        # ลดตัวนับลงทีละ 1 
        ${cart_count}=    Evaluate    ${cart_count} - 1
        
        # เช็คตะกร้า 
        IF    ${cart_count} > 0
            Element Text Should Be   ${CART_BADGE}    ${cart_count}
            Log To Console    ลบสินค้า 1 ชิ้น -> ตะกร้าเหลือ ${cart_count} ชิ้น!
        ELSE
            # ถ้าเหลือ 0 ชิ้น ป้ายแดงต้องไม่ปรากฏ
            Page Should Not Contain Element    ${CART_BADGE}
            Log To Console    ลบสินค้าทุกตัวในตะกร้าเสร็จสิ้น
        END
        
    END
    
    Close Browser