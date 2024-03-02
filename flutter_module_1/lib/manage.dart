import 'package:flutter/material.dart';

class managenew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'สูตรบริหารเงิน 50-30-20',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  shadows: [
                    Shadow(
                      blurRadius: 1,
                      color: Colors.black,
                      offset: Offset(0.5, 0),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.account_balance_wallet, color: Colors.white),
            ],
          ),
          backgroundColor: Colors.pink[100],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: BudgetCalculator(),
        ),
      ),
    );
  }
}

class BudgetCalculator extends StatefulWidget {
  @override
  _BudgetCalculatorState createState() => _BudgetCalculatorState();
}

class _BudgetCalculatorState extends State<BudgetCalculator> {
  final TextEditingController _incomeController = TextEditingController();
  double _totalIncome = 0;
  double _savings = 0;
  double _foodExpense = 0;
  double _accommodationExpense = 0;

  void _calculateBudget() {
    setState(() {
      _totalIncome = double.tryParse(_incomeController.text) ?? 0;
      _savings = _totalIncome * 0.5;
      _foodExpense = _totalIncome * 0.3;
      _accommodationExpense = _totalIncome * 0.2;
    });
  }

  void _clearData() {
    setState(() {
      _incomeController.clear();
      _totalIncome = 0;
      _savings = 0;
      _foodExpense = 0;
      _accommodationExpense = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _incomeController,
            decoration: InputDecoration(
              labelText: 'กรอกจำนวนเงิน ✨',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.pinkAccent),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _calculateBudget();
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 177, 235, 255)),
                child: Text('บริหารเงินกันเถอะ !'),
              ),
              ElevatedButton(
                onPressed: () {
                  _clearData();
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 170, 164)),
                child: Text('ลบทั้งหมด'),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildExpenseRows(),
          SizedBox(height: 20),
          _buildSubExpenseRows(),
        ],
      ),
    );
  }

  Widget _buildSubExpenseRows() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildExpenseRow(
            'ใช้เพื่อสร้างความสุข', _foodExpense), // Call _buildExpenseRow
        SizedBox(height: 20),
        Text(
          '* แนะนำรายการสำหรับ"ใช้จ่ายเพื่อสร้างความสุข"',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20), // Add a SizedBox for spacing
        _buildSubExpenseRow('ค่ากิจกรรมส่วนตัว', 0.5 * _foodExpense),
        _buildSubExpenseRow('ค่าช้อปปิ้ง', 0.3 * _foodExpense),
        _buildSubExpenseRow('ค่าท่องเที่ยว', 0.2 * _foodExpense),
        SizedBox(height: 20),
        _buildExpenseRow('เงินเก็บ', _accommodationExpense),
      ],
    );
  }

  Widget _buildExpenseRows() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildExpenseRow('ใช้จ่ายประจำเดือน', _savings),
        SizedBox(height: 20),
        Text(
          '* แนะนำรายการสำหรับ"ใช้จ่ายประจำเดือน"',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20), // Add a SizedBox for spacing
        _buildSubExpenseRow('ค่าเช่าหรือค่าผ่อน', 0.6 * _savings),
        _buildSubExpenseRow('ค่าอาหาร', 0.3 * _savings),
        _buildSubExpenseRow('ค่าอื่น ๆ', 0.1 * _savings),
      ],
    );
  }

  Widget _buildExpenseRow(String label, double amount) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.monetization_on,
                  color: Color.fromARGB(255, 132, 250, 138)),
              SizedBox(width: 8.0),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 95, 196),
                ),
              ),
            ],
          ),
          Text(
            '\฿ $amount',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 2.0,
                  color: Colors.black,
                  offset: Offset(0, 1.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubExpenseRow(String label, double amount) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          Text(
            '\฿ $amount',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(managenew());
}
