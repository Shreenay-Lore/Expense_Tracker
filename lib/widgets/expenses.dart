import 'package:expense_tracker/widgets/add_new_expense.dart';
import 'package:expense_tracker/widgets/charts/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> _registeredExpenses = [

    Expense(
      title: 'Dominos',
      amount: 500,
      category: Category.food, 
      date: DateTime.now()),

      Expense(
      title: 'NewYork',
      amount: 50000,
      category: Category.travel, 
      date: DateTime.now()),

  ];

  void _openAddExpenseOverley() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true ,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense,),
    );
  }

  void _addExpense(Expense expense) { 
    setState(() {
      _registeredExpenses.add(expense);
    });
  }


  void _removeExpense(Expense expense){

    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
       duration: const Duration(seconds: 3),
       content: const Text('Expense deleted.'),
       action: SnackBarAction(
        label: 'Undo', 
        onPressed: (){
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          },);
        },),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(child: Text('No expense found. Start adding some!'),);
    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(
            expenses: _registeredExpenses,
            onRemoveExpense: _removeExpense);
    } 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'), actions: [
        IconButton(
          onPressed: _openAddExpenseOverley,
          icon: const Icon(Icons.add),
        ),
      ]),
      body: width < 600 
      ? Column(
        children: [
        Chart(expenses: _registeredExpenses),

        Expanded(
          child: mainContent,
          ),
        ]) 
      : Row(
        children: [
          Expanded(
            child: Chart(expenses: _registeredExpenses)),

          Expanded(
            child: mainContent,
          ),

        ],)
    );
  }
}
