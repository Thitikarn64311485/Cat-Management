import 'package:flutter/material.dart';
import 'package:flutter_module_1/database/database_helper.dart';
import 'package:provider/provider.dart';

class MonthlySummaryPage extends StatefulWidget {
  final DatabaseHelper databaseHelper;
  final List<Map<String, dynamic>> transactions;

  const MonthlySummaryPage({
    Key? key,
    required this.databaseHelper,
    required this.transactions,
  }) : super(key: key);

  @override
  _MonthlySummaryPageState createState() => _MonthlySummaryPageState();
}

class _MonthlySummaryPageState extends State<MonthlySummaryPage> {
  int _totalIncome = 0;
  int _totalExpense = 0;
  late List<Map<String, dynamic>> _monthlyIncomeTransactions;
  late List<Map<String, dynamic>> _monthlyExpenseTransactions;

  @override
  void initState() {
    super.initState();
    _calculateTotalAmounts();
    _filterMonthlyTransactions();
    _saveMonthlyTransactions();
  }

  void _calculateTotalAmounts() {
    _totalIncome = 0;
    _totalExpense = 0;
    for (var transaction in widget.transactions) {
      if (transaction['amount'] > 0) {
        _totalIncome += transaction['amount'] as int;
      } else {
        _totalExpense += transaction['amount'] as int;
      }
    }
  }

  void _filterMonthlyTransactions() {
    _monthlyIncomeTransactions = [];
    _monthlyExpenseTransactions = [];
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;
    for (var transaction in widget.transactions) {
      final transactionDate = DateTime.parse(transaction['date']);
      if (transactionDate.year == currentYear &&
          transactionDate.month == currentMonth) {
        if (transaction['amount'] > 0) {
          _monthlyIncomeTransactions.add(transaction);
        } else {
          _monthlyExpenseTransactions.add(transaction);
        }
      }
    }
  }

  void _saveMonthlyTransactions() async {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    final monthlyTransactions = widget.transactions.where((transaction) {
      final transactionDate = DateTime.parse(transaction['date']);
      return transactionDate.month == currentMonth &&
          transactionDate.year == currentYear;
    }).toList();

    await widget.databaseHelper.saveMonthlyTransactions(
        currentYear, currentMonth, monthlyTransactions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สรุปรายรับรายจ่ายในแต่ละเดือน 💵',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Color.fromARGB(255, 255, 190, 227),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'ยอดรวมรายการทั้งหมด :',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 249, 127, 127)),
              ),
              trailing: Text(
                '${_totalIncomeInMonth()} บาท',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 253, 92, 92)),
              ),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                _showMonthlyTransactionsDialog(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 186, 222),
                onPrimary: Colors.white,
              ),
              child: Text(
                'เลือกเดือนที่ต้องการดูข้อมูล 🗓️',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Divider(),
            _buildTransactionTable(
                'รายการทั้งหมด ✨', _monthlyIncomeTransactions),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTable(
      String title, List<Map<String, dynamic>> transactions) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 108, 89, 162),
            ),
          ),
          DataTable(
            columnSpacing:
                10.0, // เพิ่มบรรทัดนี้เพื่อกำหนดระยะห่างระหว่างคอลัมน์
            columns: [
              DataColumn(label: Text('วันที่')),
              DataColumn(label: Text('รายการ')),
              DataColumn(label: Text('จำนวนเงิน')),
            ],
            rows: transactions.map((transaction) {
              return DataRow(cells: [
                DataCell(Text(transaction['date'])),
                DataCell(Text(transaction['description'])),
                DataCell(Text('${transaction['amount']} บาท')),
              ]);
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showMonthlyTransactionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('เลือกเดือน'),
          content: Text('เลือกเดือนที่คุณต้องการดูข้อมูล'),
          actions: [
            for (int i = 1; i <= 12; i++)
              TextButton(
                onPressed: () {
                  _handleMonthSelection(i);
                  Navigator.pop(context);
                },
                child: Text('$i'),
              ),
          ],
        );
      },
    );
  }

  void _handleMonthSelection(int selectedMonth) {
    setState(() {
      _monthlyIncomeTransactions.clear();
      _monthlyExpenseTransactions.clear();
      for (var transaction in widget.transactions) {
        final transactionDate = DateTime.parse(transaction['date']);
        if (transactionDate.month == selectedMonth) {
          if (transaction['amount'] > 0) {
            _monthlyIncomeTransactions.add(transaction);
          } else {
            _monthlyExpenseTransactions.add(transaction);
          }
        }
      }
    });
  }

  int _totalIncomeInMonth() {
    int total = 0;
    for (var transaction in _monthlyIncomeTransactions) {
      total += transaction['amount'] as int;
    }
    return total;
  }
}
