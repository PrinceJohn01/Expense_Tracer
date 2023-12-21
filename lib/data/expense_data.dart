import 'package:expense_tracer/datetime/date_time_helper.dart';

import '../model/expense_item.dart';

class ExpenseDate {
  // list of all expenses
  List<ExpenseItem> overallExpenseList = [];
  //get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
  }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
  }

  // get weekdays
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  //get the date for the start of the week
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //get todays data
    DateTime today = DateTime.now();

    //go backwards from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'sun') {
        startOfWeek = (today.subtract(Duration(days: i)));
      }
    }
    return startOfWeek!;
  }

  //Daily expense
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
