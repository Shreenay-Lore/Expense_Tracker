  import 'package:flutter/material.dart';
  import 'package:uuid/uuid.dart';
  import 'package:intl/intl.dart';

  final formatter = DateFormat.yMd(); //ymd simply creates formater object that used to format date.

  const uuid = Uuid();   //uuid is third party package which generate unquie id dynamically.
  
  enum Category{ food, travel, work, leisure }

  const categoryIcons ={
    Category.food : Icons.lunch_dining,
    Category.travel : Icons.flight_takeoff,
    Category.work : Icons.work,
    Category.leisure : Icons.movie,
    
  };

  class Expense{
   Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.date}): id = uuid.v4(); // Initializer List 

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }

}

class ExpenseBucket{
  ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(List<Expense>allExpenses, this.category) :
   expenses = allExpenses.where((expense) => expense.category == category).toList();

  final List<Expense> expenses;
  final Category category;

  double get totalExpenses{
    double sum = 0;

    for(final expense in expenses){
      sum += expense.amount;
    }
    return sum;

  }
}