import 'package:flutter/material.dart';
import 'package:flutter_module_1/database/database_helper.dart';
import 'package:flutter_module_1/NewPage.dart'; // นำเข้า NewPage.dart เข้ามาใช้งาน
import 'package:flutter_module_1/monthly_summary_page.dart';
import 'package:flutter_module_1/manage.dart';
import 'package:flutter_module_1/save.dart';
import 'package:flutter_module_1/how.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  final database = await dbHelper.database;

  runApp(MaterialApp(home: LoadingPage())); // เรียกใช้หน้าโหลดเมื่อเริ่มแอป
  // Delay เปลี่ยนหน้าไปหน้าแอปหลัก 3 วินาที
  Future.delayed(Duration(seconds: 5), () {
    runApp(MyApp());
  });
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
            'assets/images/loading.png'), // ใส่ตำแหน่งรูปภาพของคุณที่นี่
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Management 😼',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(color: Color.fromARGB(255, 249, 104, 193), blurRadius: 2)
            ],
          ),
        ),
      ),
      home: const MyHomePage(title: 'Cat Management '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _totalIncome = 0;
  int _totalExpense = 0;
  DateTime? _dateTime;
  final TextEditingController _expenseController = TextEditingController();
  final dbHelper = DatabaseHelper();
  bool _dataLoaded =
      false; // เพิ่มตัวแปรเพื่อตรวจสอบว่าข้อมูลถูกโหลดแล้วหรือไม่

  @override
  void initState() {
    super.initState();
    if (!_dataLoaded) {
      // เช็คว่าข้อมูลถูกโหลดแล้วหรือไม่
      _loadTotalAmount();
    }
  }

  Future<void> _loadTotalAmount() async {
    final transactions = await dbHelper.getAllTransactions();
    int totalAmount = 0;
    int totalIncome = 0;
    int totalExpense = 0;
    for (var transaction in transactions) {
      totalAmount += transaction['amount'] as int;
      if (transaction['amount'] > 0) {
        totalIncome += transaction['amount'] as int;
      } else {
        totalExpense += transaction['amount'] as int;
      }
    }
    setState(() {
      _counter = totalAmount;
      _totalIncome = totalIncome;
      _totalExpense = totalExpense;
      _dataLoaded = true; // กำหนดว่าข้อมูลถูกโหลดแล้ว
    });
  }

  void _incrementCounter(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int? newValue;
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.attach_money, color: Colors.green),
              const SizedBox(width: 10),
              const Text(
                'กรอกจำนวนเงิน!',
                style: TextStyle(
                  color: Color.fromARGB(255, 253, 126, 210),
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                newValue = int.tryParse(value);
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                if (newValue != null) {
                  final now = DateTime.now();
                  final transaction = {
                    'amount': newValue,
                    'description': 'เพิ่มจำนวนเงิน!',
                    'date': now.toString()
                  };
                  final id = await dbHelper.insertTransaction(transaction);
                  if (id != null) {
                    setState(() {
                      _counter += newValue!;
                      _totalIncome += newValue!;
                      _dateTime = now;
                    });
                  }
                }
                Navigator.of(context).pop();
              },
              child: const Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

  void _decrementCounter(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int? newValue;
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.money_off, color: Colors.red),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'กรอกจำนวนรายจ่าย!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    newValue = int.tryParse(value);
                  });
                },
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _expenseController,
                decoration: const InputDecoration(
                  labelText: 'รายการ',
                  labelStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onChanged: (value) {},
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                if (newValue != null) {
                  final now = DateTime.now();
                  final transaction = {
                    'amount': newValue,
                    'description': _expenseController.text,
                    'date': now.toString()
                  };
                  final id = await dbHelper.insertTransaction(transaction);
                  if (id != null) {
                    setState(() {
                      _counter -= newValue!;
                      _totalExpense -= newValue!;
                      _dateTime = now;
                    });
                  }
                }
                Navigator.of(context).pop();
              },
              child: const Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTransaction(
      BuildContext context, int amount, String description, String date) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: Text('คุณต้องการลบรายการนี้ใช่ไหม'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () async {
                await dbHelper.deleteTransaction(description, date);
                // Calculate whether the deleted amount was income or expense
                int adjustedAmount = amount > 0 ? -amount : amount;
                setState(() {
                  _counter -= adjustedAmount;
                  if (adjustedAmount > 0) {
                    _totalIncome -= adjustedAmount; // Adjust total income
                  } else {
                    _totalExpense -= adjustedAmount;
                  }
                });
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(primary: Colors.red),
              child: const Text('ใช่'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.wallet_giftcard),
            const SizedBox(width: 10),
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                      color: Color.fromARGB(255, 249, 104, 193), blurRadius: 2),
                ],
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 252, 134, 174),
                Color.fromARGB(255, 253, 198, 221),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 254, 177, 215),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 36),
                child: Text(
                  'Cat Management 😼',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Color.fromARGB(255, 249, 104, 193),
                          blurRadius: 2)
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('คู่มือการออมเงิน 📖'),
              onTap: () {
                // เพิ่มโค้ดสำหรับการเปิดหน้าใหม่ที่นี่
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPage()),
                );
              },
            ),
            ListTile(
              title: Text('คู่มือการใช้ ⚙️'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppGuidePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _incrementCounter(context),
                    icon: Icon(Icons.add),
                    label: Text('รายรับของคุณ!',
                        style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 255, 150, 210)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Are you sure?'),
                            content:
                                const Text('"คุณต้องการลบข้อมูลใช่หรือไม่?"'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('ยกเลิก'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await dbHelper.deleteAllTransactions();
                                  _loadTotalAmount(); // Reload total amounts
                                  Navigator.of(context).pop();
                                },
                                style:
                                    TextButton.styleFrom(primary: Colors.red),
                                child: const Text('ใช่!'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('ลบทั้งหมด',
                        style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 255, 150, 210)),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Savenew()), // แทน YourSaveMoneyPage() ด้วยหน้าที่คุณต้องการเปิด
                      );
                    },
                    icon: Icon(
                      Icons.local_atm, // ไอคอนเซฟเงิน
                      color: Color.fromARGB(255, 235, 109, 109),
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            if (_counter > 0)
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                elevation: 5,
                color: const Color.fromARGB(255, 253, 230, 205),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text(
                        'จำนวนเงินของคุณ : $_counter',
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  color: Color.fromARGB(255, 255, 116, 213),
                                  blurRadius: 14)
                            ]),
                      ),
                      if (_dateTime != null) ...[
                        SizedBox(height: 10),
                        Text(
                          'วันที่และเวลา : ${_dateTime.toString()}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _decrementCounter(context),
              child: const Text('รายจ่ายของคุณ! 📉',
                  style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 250, 120, 148)),
              ),
            ),
            if (_expenseController
                .text.isNotEmpty) // ตรวจสอบว่ามีข้อมูลในช่องรายการหรือไม่
              SizedBox(height: 5),
            SizedBox(height: 20),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: dbHelper.getAllTransactions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'ไม่มีข้อมูล',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final transaction = snapshot.data![index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          elevation: 5,
                          color: Color.fromARGB(
                              255, 186, 238, 255), // เปลี่ยนเป็นสีเขียวอ่อน
                          child: ListTile(
                            title: Text(
                              'รายการ: ${transaction['description']} \nจำนวนเงิน: ${transaction['amount']} บาท \nวันที่: ${transaction['date']}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 89, 88, 88)),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteTransaction(
                                  context,
                                  transaction['amount'] as int,
                                  transaction['description'] as String,
                                  transaction['date'] as String,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return SizedBox();
                }
              },
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 30),
              elevation: 5,
              color: Color.fromARGB(255, 253, 230, 205),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'สรุปยอดรายรับและรายจ่าย',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 94, 95, 94),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'รายรับ: $_totalIncome บาท',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'รายจ่าย: ${_totalExpense.abs()} บาท',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Divider(
                      color: const Color.fromARGB(255, 255, 253, 253),
                      thickness: 1,
                    ),
                    Text(
                      'ยอดคงเหลือ 💸: ${_totalIncome + _totalExpense} บาท',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 94, 95, 94),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 0,
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 251, 186,
                228), // เปลี่ยนสีพื้นหลังของ Container เป็นสีชมพู
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(16)), // เพิ่มการทำให้มีกรอบเข้ามา
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewPage()),
                  ); // Navigate to another page
                },
                icon: Icon(
                  Icons.attach_money,
                  color: Color.fromARGB(
                      255, 255, 255, 255), // เปลี่ยนสีไอคอนเป็นสีชมพู
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => managenew()),
                  );
                },
                icon: Icon(
                  Icons.library_books,
                  color: Colors.white, // สีของไอคอน
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final transactions = await dbHelper.getAllTransactions();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MonthlySummaryPage(
                databaseHelper: dbHelper,
                transactions: transactions,
              ),
            ),
          ); // Navigate to another page
        },
        child: Icon(Icons.bar_chart),
        backgroundColor: Color.fromARGB(255, 253, 121, 168),
      ),
    );
  }
}
