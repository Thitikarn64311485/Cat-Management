import 'package:flutter/material.dart';

class AppGuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'คู่มือการใช้งาน ⚙️',
          style: TextStyle(
            color: Colors.white, // เปลี่ยนสีของตัวหนังสือเป็นสีขาว
            fontSize: 20, // เปลี่ยนขนาดตัวอักษร
          ),
        ),
        backgroundColor:
            Color.fromARGB(255, 255, 165, 218), // เปลี่ยนสีแถบบาร์เป็นสีชมพู
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical, // ตั้งค่าเพื่อให้เลื่อนได้ตามแนวดิ่ง
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '" Meow ยินดีต้อนรับสู่แอปพลิเคชันของเรา! 😺 "',
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 193, 137, 220),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'คู่มือการใช้งาน:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 134, 134),
                  decoration: TextDecoration.underline, // เพิ่มการขีดเส้นใต้
                  decorationColor:
                      Color.fromARGB(255, 253, 91, 228), // สีของเส้นใต้
                ),
              ),
              SizedBox(height: 10),
              Text(
                '1. ข้อแนะนำเบื้องต้น 1 ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '    หน้า Home คือหน้าคำนวนการเงินของคุณโดยจะคำนวนรายรับ รายจ่าย และยอดเงินคงเหลือของคุณ ซึ่งในหน้านี้ " คุณจะไม่สามารถลบจำนวนเงินที่เพิ่มเข้ามาได้ " ดังนั้นกรุณาตรวจสอบยอดรายการรับเงินของคุณให้ถูกต้อง ',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '2. ข้อแนะนำฟังก์ชั่นการใช้งาน 🐱‍👓 ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '    " หน้าสูตรบริหารเงิน 50-30-20 " ซึ่งเป็นสูตร่ได้รับความนิยมในการใช้ยริหารเงินโดยในหน้านี้เมื่อคุณกรอกข้อมูลจำนวนเงินรายรับเข้าไประบบจะคำนวนตามสูตรให้ว่าคุณควรใช้จ่ายเท่าใดและอย่างไรบ้าง',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '     " หน้าคู่มือการออมเงิน " คุณสามารถอ่านวิธีการออมเงินได้จากบทความของระบบ',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '     " หน้าดูสรุปรายรัยและรายจ่ายรายเดือน " ซึ่งผู้ใช้สามารถดูรายการ วันที่ และจำนวนเงินที่กรอกลงไปในเดือนนั้นๆโดยจะสรุปออกมาเป็นตารางเพื่อให้ดูอย่างสะดวก',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '     " หน้า Let\s Save Money " ซึ่งผู้ใช้สามารถกรอกเป้าหมายจำนวนเงินที่ต้องการเก็บได้ โดยมีฟังก์ชั่นให้เล่นคือถ้าหากคุณออมเงินจนครบคุณจะสามารถพาน้องแมวหลงทางกลับบ้านได้ โดยระบบจะทำการคำนวนเป็นเปอร์เซนต์ของรายการที่คุณกรอกเพื่อเก็บเงิน เช่น 5% 10% เป็นต้นโดยระบบจะทำการเปลี่ยนเหตุการณ์น้องแมวไปเรื่อยๆตามจำนวนเงินของคุณยิ่งใกล้ครบมากเท่าไหร่น้องแมวก็จะได้กลับบ้านเร็วเท่านั้น',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              SizedBox(height: 10),
              Text(
                '       " ขอบคุณที่ใช้บริการ Meowwww 😽 "',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 134, 134),
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/images/meow.png',
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // เพิ่มการกดปุ่มย้อนกลับ
        },
        child: Icon(Icons.arrow_back),
        backgroundColor:
            const Color.fromARGB(255, 253, 158, 190), // เปลี่ยนสีปุ่มเป็นสีชมพู
      ),
    );
  }
}
