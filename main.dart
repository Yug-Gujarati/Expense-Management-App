// ignore_for_file: prefer_const_constructors

//import 'package:firstapp/widget/new_transaction.dart';
//import 'package:firstapp/widget/user_transaction.dart';
import 'package:firstapp/widget/transaction_list.dart';
import 'package:flutter/material.dart';
import './widget/transaction_list.dart';
import './widget/new_transaction.dart';
import './models/transaction.dart';
import './widget/chart.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Color.fromARGB(255, 255, 128, 0),
        errorColor: Colors.red,
        fontFamily: 'Quicksand', 
        textTheme: ThemeData.light().textTheme.copyWith(
          subtitle1: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme:AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            subtitle1: TextStyle(
              fontFamily: 'OpenSans', 
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
  //late String titleInput;
  
  final List<Transaction> _userTransactions = [
      //   Transaction(
      //         Id: 'yug', 
      //         Title: 'leptop', 
      //         Amount: 200000, 
      //        date: DateTime.now()
      //     ),
      //   Transaction(
      //         Id: 'yug', 
      //         Title: 'mobile', 
      //         Amount: 100000, 
      //         date: DateTime.now()
      // ), 
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
         Duration(days: 7),
      ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle , double txAmount , DateTime chosenDate){
      final newTx = Transaction( 
        Title: txTitle, 
        Amount: txAmount, 

        date: chosenDate,
        Id: DateTime.now().toString(), 
        );
        
        setState(() {
          _userTransactions.add(newTx); 
        });
    }

  void _startAddNewTransection(BuildContext ctx){
    showModalBottomSheet(
      context: ctx ,
      builder: (_){
      return GestureDetector(
        onTap: () {},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
    },
  );
}

 void _deleteTransaction(String Id) {
   setState(() {
     _userTransactions.removeWhere((tx) => tx.Id == Id  );
   });
 }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Personal Expenses '
        ),
        actions:<Widget>[
          IconButton(icon: Icon(Icons.add),
          onPressed: () =>  _startAddNewTransection(context),
          ),
        ]
        ),
        body: SingleChildScrollView(
          child : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  <Widget>[
          Chart(_recentTransactions),
          TransactionList(_userTransactions , _deleteTransaction),
        ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:FloatingActionButton
      (
        child: Icon(Icons.add), 
        onPressed: () =>  _startAddNewTransection(context),
      ),
    );
  }
}