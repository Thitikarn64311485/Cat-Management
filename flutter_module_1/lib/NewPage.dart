import 'dart:async';
import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  List<Color> _backgroundColors = [
    Color.fromARGB(255, 254, 191, 211),
    Color.fromARGB(255, 178, 220, 255),
    Color.fromARGB(255, 245, 146, 176),
    Color.fromARGB(255, 195, 199, 255),
    Color.fromARGB(255, 243, 197, 251)
  ];
  int _currentColorIndex = 0;
  late Timer _timer;

  double _savingsAmount = 0.0; // ออมทันที

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const duration = const Duration(seconds: 2);
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        _currentColorIndex =
            (_currentColorIndex + 1) % _backgroundColors.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _backgroundColors[_currentColorIndex],
        title: Text(
          'คู่มือการออมเงิน 💰',
          style: TextStyle(
            color: Colors.white,
            shadows: [
              Shadow(
                color: const Color.fromARGB(255, 138, 138, 138),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '" 8 สูตรการออมเงินสำหรับคนยุคใหม่ 😻 "',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 248, 122, 122),
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 14, 14, 14),
                            blurRadius: 0.5,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 252, 222, 222)
                                      .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(
                                    0,
                                    4,
                                  ),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/M1.png',
                              width: 300,
                              height: 250,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Text(
                '1. ออมทันที เมื่อมีรายรับเข้ามา',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '     " การออมเงินสูตรแรก เป็นการหักออมทันทีเมื่อมีรายได้เข้ามา โดยวันที่มียอดเงินโอนเข้ามาในบัญชี ให้คุณหักเก็บทันทีตามจำนวนที่ต้องการ เพื่อจะได้เฉลี่ยเงินที่เหลือได้ว่า ในแต่ละวันจะเหลือเงินเท่าไหร่ ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      '      สำหรับสูตรการออมเงิน คุณสามารถใช้วิธีเทคนิคแบบเดียวกับการซื้อหุ้นที่เรียกว่า DCA (Dollar Cost Averaging) ที่เป็นการซื้อสินทรัพย์สม่ำเสมอทุกเดือนในจำนวนที่เท่ากัน ซึ่งถ้าปรับมาใช้กับการออมเงิน ก็จะเป็นการหักเก็บในจำนวนที่เท่ากันทุกเดือนไปเรื่อยๆ ถือเป็นการสร้างวินัยการออมที่ดี เพื่อให้คุณมีเงินออมในบัญชีอย่างสม่ำเสมอ "',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/M2.png', // เปลี่ยนเป็นชื่อไฟล์ภาพของคุณ
                width: 300, // ปรับขนาดภาพตามที่ต้องการ
                height: 300,
              ),
              Text(
                '2. ออมเงินในบัญชีที่แยกกับบัญชีใช้จ่าย',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 75, 169, 106),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '      " การใช้วิธีออมเงินแยกกับบัญชีที่ใช้จ่ายจะช่วยให้เงินออมปลอดภัยจากการถูกนำมาใช้จ่ายมากขึ้นและยังทำให้คุณสะดวกในการจัดการค่าใช้จ่ายต่างๆโดยให้คุณเลือกเปิดบัญชีออมเงินที่เป็นรูปแบบฝากประจำก็จะทำให้เงินออมที่อยู่ในบัญชีนั้นงอกเงยได้จากอัตราดอกเบี้ยเงินฝากด้วย ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    Text(
                      '      ข้อสำคัญสำหรับการมีบัญชีเงินออม คือ ไม่ควรถอนเงินออกมาใช้บ่อยหากไม่มีเหตุฉุกเฉินหรือความจำเป็นจริงๆเพราะจะทำให้ขาดวินัยการออมไปได้ง่ายๆและหากเลือกเปิดบัญชีเงินออมก็มองหาบัญชีที่มีข้อจำกัดการถอนรายเดือน หรือบัญชีแบบไม่มีบัตรก็จะช่วยให้การหยิบเงินออมออกมาใช้จ่ายยากขึ้น "',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/M3.png', // เปลี่ยนเป็นชื่อไฟล์ภาพของคุณ
                width: 300, // ปรับขนาดภาพตามที่ต้องการ
                height: 300,
              ),
              Text(
                '3. ออมเงินตามเป้าหมายที่ตั้งไว้',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 155, 118, 211),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '      " สำหรับเงินออมตามเป้าหมาย จะเป็นก้อนเงินออมที่แยกออกมาจากก้อนหลัก แต่ก้อนนี้จะเป็นก้อนที่ไม่ใหญ่มาก และมีจุดประสงค์ของการใช้ตามเป้าหมายที่ตั้งเอาไว้ชัดเจน เช่น ออมเงินสำหรับไปเที่ยวต่างประเทศ ออมเงินสำหรับดาวน์รถ หรือกิจกรรมอื่นๆ ที่ต้องใช้เงินก้อน  ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    Text(
                      '      หากตั้งเป้าหมายได้แล้ว คุณจะรู้ว่าต้องหักเก็บเดือนละเท่าไหร่ดี เพราะเงินก้อนนี้จะเป็นเหมือนการสร้างแรงฮึดที่ทำให้คุณต้องรีบเก็บให้ได้ บางคนอาจมีการหารายได้เสริมในระยะเวลาสั้นๆ เพื่อสามารถเก็บเงินก้อนนี้ได้ทันเวลาที่ตั้งไว้ และไม่กระทบกับเงินออมก้อนหลักที่มีการเก็บเป็นประจำอยู่แล้ว "',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/M4.png', // เปลี่ยนเป็นชื่อไฟล์ภาพของคุณ
                width: 300, // ปรับขนาดภาพตามที่ต้องการ
                height: 300,
              ),
              Text(
                '4. ออมแบงค์ 50 บาทผลลัพธ์เกินคาด',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 212, 184, 91),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '      " สำหรับวิธีการออมแบงค์ คือ การเก็บทันทีเมื่อได้รับแบงค์ 50 บาทมา ที่บ่อยครั้งอาจจะได้รับมาในรูปแบบของเงินทอน โดยให้นำมาเก็บไว้ในกล่องหรือกระเป๋าที่แยกจากกระเป๋าเงินที่ใช้อยู่เป็นประจำ   ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    Text(
                      '      ถ้าคำนวณคร่าวๆ หากได้รับแบงค์ 50 บาท ทุกวันและมีการเก็บเพียงวันละ 1 ใบ จะได้เงินออมเมื่อคบ 1 ปี อยู่ที่ประมาณ 50 x 365 = 18,250 บาท ซึ่งถือว่าเป็นเงินก้อนที่คุ้มเลยทีเดียว "',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/M5.png', // เปลี่ยนเป็นชื่อไฟล์ภาพของคุณ
                width: 300, // ปรับขนาดภาพตามที่ต้องการ
                height: 300,
              ),
              Text(
                '5. ออมเงินด้วยการซื้อสลากออมทรัพย์',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 251, 144, 233),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '      " หากว่าคุณสนใจในการออมเงินระยะสั้น ที่ได้รับผลตอบแทนเป็นดอกเบี้ย และในระหว่างนั้นก็ยังมีสิทธิ์ลุ้นรางวัลใหญ่เหมือนกับซื้อหวยทุกเดือน การซื้อสลากออมทรัพย์ จะเป็นทางเลือกที่ตอบโจทย์เป็นอย่างมาก    ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    Text(
                      '      ที่สำคัญเมื่อออมไว้จนครบตามอายุสลากแล้ว เงินต้นที่ฝากไว้ก็จะได้รับกลับคืนมาเต็มจำนวน พร้อมกับผลตอบแทนตามที่สลากออมทรัพย์กำหนดด้วย และที่สำคัญหากว่าคุณถูกรางวัลที่ 1 ก็จะได้รับเงินเพิ่มมาอีก สูงสุดเป็นหลักล้านบาทเลยทีเดียว "',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/M6.png', // เปลี่ยนเป็นชื่อไฟล์ภาพของคุณ
                width: 300, // ปรับขนาดภาพตามที่ต้องการ
                height: 300,
              ),
              Text(
                '6. ออมเงินกับประกันชีวิตแบบสะสมทรัพย์',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 165, 144, 251),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '      " การออมเงินกับประกันชีวิตแบบสะสมทรัพย์ เป็นอีกหนึ่งทางเลือกที่ได้ทำให้ผู้ออมเงินได้รับทั้งความคุ้มค่าและการคุ้มครองในระยะยาว เมื่อถึงช่วงเวลาที่กำหนด ก็สามารถถอนเงินก้อนใหญ่ออกมาใช้ได้ในช่วงเกษียณ    ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    Text(
                      '      สำหรับการออมเงินด้วยวิธีนี้ จะเป็นรูปแบบของการทำประกันชีวิตที่จะมีกำหนดให้คุณชำระเบี้ยเป็นงวดๆ เป็นระยะเวลาติดต่อกันตามข้อกำหนด ซึ่งเงินจากการชำระเบี้ยนี้เองจะเป็นเงินออมที่ไปสะสมจะเป็นเงินก้อนใหญ่ได้ในอนาคต และนอกจากเรื่องของการออมแล้ว เจ้าของกรมธรรม์ยังได้สิทธิ์ในการคุ้มครองชีวิตอีกด้วย  "',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/M7.png', // เปลี่ยนเป็นชื่อไฟล์ภาพของคุณ
                width: 300, // ปรับขนาดภาพตามที่ต้องการ
                height: 300,
              ),
              Text(
                '7. ออมเงินจากการสร้างวินัยที่ดี',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 115, 191, 219),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '      " สูตรนี้ถือว่าเป็นเรื่องที่วางแผนได้ง่าย แต่ทำได้ยากสำหรับหลายคน ด้วยการปรับวินัยของการใช้เงินในแต่ละเดือนใหม่ จากตอนแรกที่มีการหักเก็บ 10% ของเงินเดือนอย่างเดียว ก็สร้างวินัยทางการเงินใหม่ที่ทำให้ค่าใช้จ่ายต่อเดือนลดลง เช่น ช้อปปิงน้อยลง ลดมื้ออาหาราคาแพง ยกเลิกค่าสมาชิกรายเดือนที่ไม่ได้ใช้งานบ่อย     ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    Text(
                      '      ซึ่งถ้าหากว่ายิ่งลดค่าใช้จ่ายได้เยอะ ช่วงสิ้นเดือนคุณจะเหลือยอดเงินในบัญชีมากขึ้น และสามารถนำไปออมทบเข้าไปอีก จะช่วยให้การออมเงินของคุณสามารถไปถึงเป้าหมายได้เร็วยิ่งขึ้น  "',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/M8.png', // เปลี่ยนเป็นชื่อไฟล์ภาพของคุณ
                width: 300, // ปรับขนาดภาพตามที่ต้องการ
                height: 300,
              ),
              Text(
                '8. ออมเงินด้วยการซื้อกองทุนรวม',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 128, 128),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '      " การซื้อกองทุนรวม (Mutual Fund) ถือว่าเป็นอีกหนึ่งทางเลือกที่ไม่ต้องติดตามกระแสอยู่ตลอด เพราะจะมีผู้จัดการกองทุนเป็นคนบริหารจัดการให้ทั้งหมด ด้วยการนำเงินไปลงทุนกับกองทุนต่างๆ ที่มีนโยบายการลงทุนแตกต่างกันออกไป เช่น หุ้นในประเทศ หุ้นต่างประเทศ ตราสารหนี้ รวมถึงสินทรัพย์อื่นๆ     ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    Text(
                      '      สำหรับผลตอบแทนของการซื้อกองทุนรวมจะขึ้นอยู่กับความเสี่ยงที่แตกต่างกันตามประเภทของกองทุน หากต้องการลงทุนในกองทุนรวมควรศึกษาข้อมูล และทดสอบความเสี่ยงที่รับได้ก่อนตัดสินใจ  "',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 70, 70, 70),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/M9.png', // เปลี่ยนเป็นชื่อไฟล์ภาพของคุณ
                width: 300, // ปรับขนาดภาพตามที่ต้องการ
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
