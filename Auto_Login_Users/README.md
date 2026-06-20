### Test Suite: Auto Login Users
หน้านี้คือรายละเอียดการทดสอบระบบเข้าสู่ระบบ (Login) ของเว็บไซต์ SauceDemo 

### จุดประสงค์การทดสอบ (Test Scenario)
เพื่อตรวจสอบว่าระบบสามารถแยกแยะ User ที่มีสิทธิ์เข้าใช้งาน และป้องกัน User ที่ไม่มีสิทธิ์หรือกรอกข้อมูลผิดพลาดได้อย่างถูกต้อง

###  รายละเอียด Test Cases (12 เคส)

**เคสปกติ (Positive):**  ล็อกอินสำเร็จ เข้าสู่หน้าสินค้าได้ (เช่น `standard_user`)
      
**เคสผิดปกติ (Negative):**  กรอกรหัสผิด, ไม่กรอกรหัสผ่าน (ระบบต้องแสดง Error Message)
    
**เคสพิเศษ (Edge Cases):**  ยูสเซอร์ถูกแบน (`locked_out_user`) และ ยูสเซอร์ที่ทำให้เว็บโหลดช้าเกิน 2 วินาที (`performance_glitch_user`)

###  สรุปผลการรันบอท (Test Execution Report)
ดูรูปผลลัพธ์การรัน 11 Passed / 1 Failed จากหน้าจอ Terminal ด้านล่าง

<img width="569" height="547" alt="image" src="https://github.com/user-attachments/assets/c2593585-edd7-4fdc-8105-90d27bd9fe32" />
