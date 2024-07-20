import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      title: 'Expenses',
      home: const MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
          tertiary: Colors.grey,
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleSmall: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 12,
            color: Colors.grey,
          ),
          labelMedium: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't2',
      title: 'Energy Bill',
      amount: 16.53,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't3',
      title: 'New T-Shirt',
      amount: 45.78,
      date: DateTime.now().subtract(const Duration(days: 55)),
    ),
  ];

  // Método Getter
  List<Transaction> get getRecentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  // Método Getter
  List<Transaction> get getTransactions {
    return _transactions;
  }

  // Método Setter
  void addTransaction(String title, double amount) {
    setState(() {
      _transactions.add(Transaction(
        id: const Uuid().v4(),
        title: title,
        amount: amount,
        date: DateTime.now(),
      ));
    });

    Navigator.of(context).pop();
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(setTransaction: addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Expenses'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Chart(recentTransactions: getRecentTransactions),
              TransactionList(transactions: getTransactions),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ),
    );
  }
}
