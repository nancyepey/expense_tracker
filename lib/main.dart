import 'package:flutter/material.dart';


import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

//import './widgets/user_transactions.dart';





void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        // errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText2: TextStyle(),
          //headline6: TextStyle(
          headline1: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
            //fontStyle: FontStyle.italic,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              //fontWeight: FontWeight.bold,
              ),
          )
        ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //to store input data
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  //
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  //getter to get recent transactions
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      //getting the transactions in the next
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    //
    final newTx = Transaction(
      title: txTitle, 
      amount: txAmount,
      //date:DateTime.now(),
      date: chosenDate,
      id: DateTime.now().toString(),
      );
    //

     setState(() {
      _userTransactions.add(newTx);
    });


  }

  //to create a modal
  void _startAddNewTransaction(BuildContext ctx){
    //it starts the process of creating a new transaction
    showModalBottomSheet(
      context: ctx, 
      builder: (_) {
      //builder: (bCtx) {
        // it own context in the builder
        return GestureDetector(
          onTap: () {
            //do nothing
            print('do nothing');
          },
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
          );
      },
      );
  }


  void _deleteTransaction(String id) {
    //
    setState(() {
      _userTransactions.removeWhere((tx) =>  tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          // style: TextStyle(
          //   fontFamily: 'OpenSans'
          // ),
          ),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context), 
            icon: Icon(Icons.add),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            //UserTransactions(),
            TransactionList(
              _userTransactions, 
              _deleteTransaction),
            
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
        ),
    );
  }
}
