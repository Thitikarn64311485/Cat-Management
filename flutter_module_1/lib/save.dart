import 'package:flutter/material.dart';
import 'package:flutter_module_1/database/DatabaseHelper1.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Savenew());
}

class Savenew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '"Let\'s save money" 😼',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(color: Color.fromARGB(255, 255, 89, 169), blurRadius: 3)
              ],
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Color.fromARGB(255, 255, 190, 212),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SavingsPage(),
        ),
      ),
    );
  }
}

class SavingsPage extends StatefulWidget {
  @override
  _SavingsPageState createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  final dbHelper = DatabaseHelper();
  final SharedPreferencesHelper sharedPreferencesHelper =
      SharedPreferencesHelper();

  double _targetAmount = 0;
  double _currentAmount = 0;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _targetAmount = prefs.getDouble('targetAmount') ?? 0;
      _currentAmount = prefs.getDouble('currentAmount') ?? 0;
      _progress = prefs.getDouble('progress') ?? 0;
    });
  }

  void _updateProgress() {
    setState(() {
      _progress = (_currentAmount / _targetAmount) * 100;
      if (_progress >= 100) {
        _showGoalReachedDialog();
      }
    });
  }

  Future<void> _saveToDatabase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('targetAmount', _targetAmount);
    prefs.setDouble('currentAmount', _currentAmount);
    prefs.setDouble('progress', _progress);
  }

  void _showGoalReachedDialog() {
    // Calculate duration
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();
    int totalDays = endDate.difference(startDate).inDays;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations! 🎉'),
          content: Text(
              'ภารกิจสำเร็จแล้ว 🥳\nเก่งมากคุณใช้เวลาการออมไปแค่: $totalDays วัน ✨'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _addCurrentAmount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double newAmount = 0;
        return AlertDialog(
          title: Text('เพิ่มเงินเก็บ💰'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              newAmount = double.tryParse(value) ?? 0;
            },
            decoration: InputDecoration(labelText: 'ตรวจสอบข้อมูลให้ถูกต้อง'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _currentAmount += newAmount;
                  _updateProgress();
                  _saveToDatabase();
                  if (_progress >= 100) {
                    _showGoalReachedDialog();
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('บันทึก'),
            ),
          ],
        );
      },
    );
  }

  void _setTargetAmount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('เพิ่มเป้าหมาย 📈'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _targetAmount = double.tryParse(value) ?? 0;
              });
            },
            decoration: InputDecoration(labelText: 'ตรวจสอบให้ถูกต้อง'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _saveToDatabase();
              },
              child: Text('บันทึก'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('targetAmount');
    prefs.remove('currentAmount');
    prefs.remove('progress');
    setState(() {
      _targetAmount = 0;
      _currentAmount = 0;
      _progress = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 254, 175, 236),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'เป้าหมาย 😻: $_targetAmount Baht',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          LinearProgressIndicator(
            value: _progress / 100,
            minHeight: 20,
            backgroundColor: Color.fromARGB(255, 215, 214, 214),
            valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 255, 161, 239)),
          ),
          SizedBox(height: 20),
          Text(
            '" ออมเงินให้ถึงเป้าหมายเพื่อช่วยให้น้องแมวกลับบ้าน 🐈 "',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 183, 197),
              border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'เงินทั้งหมดของคุณ 💸: ${_currentAmount.toStringAsFixed(2)} Baht',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 251, 253, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 5 && _progress < 10)
            Image.asset(
              'assets/images/cat1.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 10 && _progress < 15)
            Image.asset(
              'assets/images/cat2.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 15 && _progress < 20)
            Image.asset(
              'assets/images/cat3.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 20 && _progress < 25)
            Image.asset(
              'assets/images/cat4.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 25 && _progress < 30)
            Image.asset(
              'assets/images/cat5.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 30 && _progress < 35)
            Image.asset(
              'assets/images/cat6.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 35 && _progress < 40)
            Image.asset(
              'assets/images/cat7.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 40 && _progress < 45)
            Image.asset(
              'assets/images/cat8.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 45 && _progress < 50)
            Image.asset(
              'assets/images/cat9.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 50 && _progress < 55)
            Image.asset(
              'assets/images/cat10.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 55 && _progress < 60)
            Image.asset(
              'assets/images/cat11.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 60 && _progress < 65)
            Image.asset(
              'assets/images/cat12.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 65 && _progress < 70)
            Image.asset(
              'assets/images/cat13.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 70 && _progress < 75)
            Image.asset(
              'assets/images/cat14.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 75 && _progress < 80)
            Image.asset(
              'assets/images/cat15.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 80 && _progress < 85)
            Image.asset(
              'assets/images/cat16.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 85 && _progress < 90)
            Image.asset(
              'assets/images/cat17.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 90 && _progress < 95)
            Image.asset(
              'assets/images/cat18.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเพิ่มขึ้น
          if (_progress >= 95 && _progress < 100)
            Image.asset(
              'assets/images/cat19.png',
              width: 200,
              height: 200,
            ),
          // รายการภาพเพิ่มเติมเมื่อความคืบหน้าเต็ม 100%
          if (_progress >= 100)
            Image.asset(
              'assets/images/cat20.png',
              width: 200,
              height: 200,
            ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _addCurrentAmount,
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 178, 174, 255),
                ),
                child: Text(
                  'เพิ่มเงินเก็บ 🐱',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 58, 57, 57),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _setTargetAmount,
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 178, 174, 255),
                ),
                child: Text(
                  'ระบุเป้าหมาย 💰',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 69, 68, 68),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _deleteAllData,
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 178, 174, 255),
            ),
            child: Text(
              'ลบทั้งหมด',
              style: TextStyle(
                color: Color.fromARGB(255, 59, 59, 59),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SharedPreferencesHelper {
  Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
