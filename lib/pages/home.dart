import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/model/transactionData.dart';
import 'package:money_manager/pages/accounts.dart';
import 'package:money_manager/pages/add_trans.dart';
import 'package:money_manager/pages/settings_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  double font_size = 25;
  double icon_size = 25;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TransactionData.calculateBalance();
    Map trans = TransactionData.transactions;
    Map month = TransactionData.getTransaction(2025, 2);

    return Scaffold(
      appBar: AppBar(
        // leading: Icon(
        //   Icons.search,
        //   size: icon_size,
        // ),
        centerTitle: true,
        title: Center(
          child: Text(
            'Money Manager',
            style: TextStyle(
              fontSize: font_size,
            ),
          ),
        ),
        // actions: [
        //   Row(
        //     children: [
        //       Icon(
        //         CupertinoIcons.star,
        //         size: icon_size,
        //       ),
        //       SizedBox(width: 20,),
        //       Icon(
        //         CupertinoIcons.slider_horizontal_3,
        //         size: icon_size,
        //       ),
        //       // SizedBox(width: 20,),
        //     ],
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.navigate_before,
                    size: icon_size,
                  ),
                  Text(
                    "${trans[trans.keys.last].keys.last} ${trans.keys.last}",
                    style: TextStyle(
                      fontSize: font_size - 8,
                    ),
                  ),
                  Icon(
                    Icons.navigate_next,
                    size: icon_size,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Daily",
                  style: TextStyle(
                    fontSize: font_size - 10,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "Calendar",
                  style: TextStyle(
                    fontSize: font_size - 10,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "Monthly",
                  style: TextStyle(
                    fontSize: font_size - 10,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "Summary",
                  style: TextStyle(
                    fontSize: font_size - 10,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: font_size - 10,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Income",
                      style: TextStyle(
                        fontSize: font_size - 10,
                      ),
                    ),
                    Text(
                      "${TransactionData.totalIncome}",
                      style: TextStyle(
                        fontSize: font_size - 10,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Exp.",
                      style: TextStyle(
                        fontSize: font_size - 10,
                      ),
                    ),
                    Text(
                      "${TransactionData.totalExpense}",
                      style: TextStyle(
                        fontSize: font_size - 10,
                        color: Colors.red[800],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: font_size - 10,
                      ),
                    ),
                    Text(
                      "${TransactionData.totalExpense - TransactionData.totalIncome}",
                      style: TextStyle(
                        fontSize: font_size - 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            _buildList(month),
          ]
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.red[400],
        ),
        child: IconButton(
          padding: EdgeInsets.all(10),
          color: Colors.white, onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTrans()),
          );
          final now = DateTime.now();
          int mon = now.month;
          int year = now.year;
          if (result != null) {
            setState(() {
              TransactionData.addTransaction(
                  year, mon, result['day'], result['transaction']);
            });
          }
        },
          icon: Icon(
            CupertinoIcons.add,
            size: icon_size + 5,
          ),
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
            setState(() {

            });
            // if (index == 3) {
            //   Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (context) => SettingsPage())
            //   );
            // }
            if (index == 1) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Accounts())
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
  Widget _buildList(Map month) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: ListView.builder(
          itemCount: month.length,
          padding: EdgeInsets.only(bottom: 10),
          itemBuilder: (BuildContext context, int index) {
            List dayTrans = month.values.elementAt(month.length - index - 1);
            var result = TransactionData.calculateDay(dayTrans);
            double? income = result['income'];
            double? expense = result['expense'];
            return Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${month.keys.elementAt(month.length - index - 1)} ",
                              style: TextStyle(
                                fontSize: font_size - 8,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Text(
                                "${dayTrans[0]}",
                                style: TextStyle(
                                  // backgroundColor: Colors.grey[600],
                                  fontSize: font_size - 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "₹ ${income}",
                              style: TextStyle(
                                fontSize: font_size - 8,
                                color: Colors.blue[800],
                              ),
                            ),
                            SizedBox(width: 20,),
                            Text(
                              "₹ ${expense}",
                              style: TextStyle(
                                fontSize: font_size - 8,
                                color: Colors.red[800],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: dayTrans.length - 1,
                          itemBuilder: (BuildContext context, int index) {
                            Map transaction = dayTrans[dayTrans.length - index - 1];
                            return Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              (transaction["Category"] ==
                                                  "Food") ? Icons
                                                  .emoji_food_beverage :
                                              (transaction["Category"] ==
                                                  "Transport") ? Icons
                                                  .local_taxi :
                                              (transaction["Category"] ==
                                                  "Shopping")
                                                  ? Icons
                                                  .shopping_cart_outlined
                                                  :
                                              (transaction["Category"] ==
                                                  "Bills") ? Icons
                                                  .library_books_sharp :
                                              Icons.attach_money_sharp,
                                              size: icon_size - 8,
                                              color: Colors.grey[600],
                                            ),
                                            Text(
                                              " ${transaction["Category"]}",
                                              style: TextStyle(
                                                fontSize: font_size -
                                                    10,
                                                color: Colors.grey[600],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          "${transaction["Note"]}",
                                          style: TextStyle(
                                            fontSize: font_size - 8,
                                          ),
                                        ),
                                        Text(
                                          "${transaction["PaymentMode"]}",
                                          style: TextStyle(
                                            fontSize: font_size - 10,
                                            color: Colors.grey[600],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "₹ ${transaction["Price"]}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: font_size - 8,
                                        color: transaction["isIncome"]
                                            ? Colors.blue[800]
                                            : Colors.red[800],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}