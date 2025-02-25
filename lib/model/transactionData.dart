import 'package:intl/intl.dart';

class TransactionData {
  static Map transactions = {
    2025: {
      2: {
        1: [
          "Sat",
          {
            "Category": "Transport",
            "Note": "To BBQ",
            "PaymentMode": "Cash",
            "Price": 100.0,
            "isIncome": true,
          },
          {
            "Category": "Other",
            "Note": "Home",
            "PaymentMode": "Bank Account",
            "Price": 2500.0,
            "isIncome": false,
          },
          {
            "Category": "Transport",
            "Note": "To BBQ",
            "PaymentMode": "Bank Account",
            "Price": 100.0,
            "isIncome": false,
          },
        ],
        2: [
          "Sun",
          {
            "Category": "Other",
            "Note": "Home",
            "PaymentMode": "Bank Account",
            "Price": 2500.0,
            "isIncome": true,
          },
          {
            "Category": "Transport",
            "Note": "To BBQ",
            "PaymentMode": "Bank Account",
            "Price": 100.0,
            "isIncome": false,
          },
        ],
        3: [
          "Mon",
          {
            "Category": "Other",
            "Note": "Home",
            "PaymentMode": "Bank Account",
            "Price": 2500.0,
            "isIncome": false,
          },
          {
            "Category": "Other",
            "Note": "Home",
            "PaymentMode": "Bank Account",
            "Price": 2500.0,
            "isIncome": false,
          },
        ],
      }
    }
  };

  static double bankAccount = 0.0;
  static double cash = 0.0;
  static double totalExpense = 0.0;
  static double totalIncome = 0.0;

  static Map getTransaction(int year, int month) {
    return transactions[year]?[month] ?? {};
  }

  static void calculateBalance() {
    bankAccount = 0;
    cash = 0;
    totalExpense = 0;
    totalIncome = 0;
    for (var yearEntry in transactions.entries) {
      for (var monthEntry in yearEntry.value.entries) {
        for (var dayEntry in monthEntry.value.entries) {
          if (dayEntry.key is int) {
            List transactionsList = dayEntry.value;
            for (var transaction in transactionsList) {
              if (transaction is Map) {
                double price = transaction["Price"] ?? 0.0;
                if (transaction["isIncome"] == true && transaction["PaymentMode"] == "Bank Account") {
                  bankAccount += price;
                }
                else if(transaction["isIncome"] == false && transaction["PaymentMode"] == "Bank Account"){
                  bankAccount -= price;
                }
                if (transaction["isIncome"] == true && transaction["PaymentMode"] == "Cash") {
                  cash += price;
                }
                else if(transaction["isIncome"] == false && transaction["PaymentMode"] == "Cash"){
                  cash -= price;
                }
                if(transaction["isIncome"] == false) {
                  totalExpense += price;
                }
                else {
                  totalIncome += price;
                }
              }
            }
          }
        }
      }
    }
  }

  static Map<String, double> calculateDay(List dayTransactions) {
    double totalExpense = 0.0;
    double totalIncome = 0.0;

    for (var transaction in dayTransactions) {
      if (transaction is Map) {
        double price = transaction["Price"] ?? 0.0;
        if (transaction["isIncome"] == true) {
          totalIncome += price;
        } else {
          totalExpense += price;
        }
      }
    }

    return {
      "income": totalIncome,
      "expense": totalExpense,
    };
  }

  static void addTransaction(int year, int month, int day, Map transaction) {
    if (!transactions.containsKey(year)) {
      transactions[year] = {};
    }

    if (!transactions[year]!.containsKey(month)) {
      transactions[year]![month] = {};
    }

    if (!transactions[year]![month]!.containsKey(day)) {
      transactions[year]![month][day] = [].cast<Object>();
    }

    final now = DateTime.now();
    final dayOfWeek = DateFormat('EEE').format(now);

    if (!transactions[year]![month]![day]!.contains(dayOfWeek)) {
      transactions[year]![month]![day]!.add(dayOfWeek);
    }

    transactions[year]![month]![day]!.add(transaction);
  }

  static void modifyTransaction(int year, int month, int day, int index, Map newTransaction) {
    transactions[year]?[month]?[day]?[index] = newTransaction;
  }
}
