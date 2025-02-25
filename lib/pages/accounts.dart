import 'package:flutter/material.dart';
import 'package:money_manager/model/transactionData.dart';
import 'package:money_manager/pages/home.dart';
import 'package:money_manager/pages/settings_page.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Accounts",
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 25
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Bank Account",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "${TransactionData.bankAccount}",
                    style: TextStyle(
                      color: (TransactionData.bankAccount > 0 ? Colors.blue : Colors.red),
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Cash",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "${TransactionData.cash}",
                    style: TextStyle(
                      color: (TransactionData.cash > 0 ? Colors.blue : Colors.red),
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[200],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.grey[600],
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            // if (index == 3) {
            //   Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (context) => SettingsPage())
            //   );
            // }
            if (index == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Home())
              );
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined), label: "Transactions"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.stacked_bar_chart), label: "Status"),
            BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on), label: "Accounts"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.more_horiz), label: "more"),
          ],
        ),
      ),
    );
  }
}
