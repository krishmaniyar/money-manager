import 'package:flutter/material.dart';

class AddTrans extends StatefulWidget {
  const AddTrans({super.key});

  @override
  State<AddTrans> createState() => _AddTransState();
}

class _AddTransState extends State<AddTrans> {
  bool isIncome = false;

  final TextEditingController noteController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<String> expenseCategory = ["Food", "Transport", "Shopping", "Bills", "Other"];
  List<String> incomeCategory = ["Allowance", "Petty Cash", "Other"];
  List<String> paymentMode = ["Bank Account", "Cash"];
  String? selectedCategory;
  String? selectedPaymentMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Is this an income?',
              style: TextStyle(
                fontSize: 20
              ),
            ),
            CheckboxListTile(
              title: Text(
                "Income",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              value: isIncome,
              onChanged: (bool? newValue) {
                setState(() {
                  isIncome = newValue!;
                });
              },
            ),
            SizedBox(height: 15),
            TextField(
              controller: noteController,
              decoration: InputDecoration(labelText: 'Note'),
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 20
              ),
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Payment Mode",
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black
              ),
              value: selectedPaymentMode,
              items: paymentMode.map((String mode) {
                return DropdownMenuItem<String>(
                  value: mode,
                  child: Text(mode),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentMode = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                fontSize: 20,
                color: Colors.black
              ),
              value: selectedCategory,
              items: (!isIncome ? expenseCategory : incomeCategory).map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final now = DateTime.now();
                    int day = now.day;
                    Map newTransaction = {
                      "Category": selectedCategory,
                      "Note": noteController.text,
                      "PaymentMode": selectedPaymentMode,
                      "Price": double.parse(priceController.text),
                      "isIncome": isIncome,
                    };
                    Navigator.pop(context, {
                      'day': day,
                      'transaction': newTransaction,
                    });
                  },
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}