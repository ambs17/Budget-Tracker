import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/Models/transcations.dart';
import 'package:flutter_complete_guide/Widgets/chart.dart';
import 'package:flutter_complete_guide/Widgets/new_transaction.dart';
import 'package:flutter_complete_guide/Widgets/transactions_list.dart';
import 'package:intl/intl.dart';
void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]); //to allow the app only on potrait mode
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        errorColor: Colors.red,
        colorScheme: 
        ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.amber),
        /* primarySwatch: Colors.purple,
        accentColor: Colors.amber //deprecated */
        fontFamily: 'OpenSans',
        // textTheme: ThemeData.light().textTheme.copyWith(
        //   titleMedium: TextStyle(
        //     fontFamily: 'OpenSans',
        //     fontSize: 18.0,
        //   )
        // ),
        textTheme: TextTheme(
          headline6: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 18.0,
          ),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle:TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    final List<Transactions> _userTransactions =[
    // Transactions(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 100.00,
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   id: 't2',
    //   title: 'Groceries',
    //   amount: 150.00,
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   id: 't3',
    //   title: 'Shopping',
    //   amount: 200.00,
    //   date: DateTime.now(),
    // ),
  ];

  List <Transactions> get _recentTransactions{
    return _userTransactions.where((tx){
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
          ),
        );
    }).toList();
  }
  void _addNewTransaction(String txTiltle, double txAmount, DateTime chosenDate){
    final txNew= Transactions(
      amount: txAmount,
      title: txTiltle,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(txNew);
    });
  }
  void deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx){
        return tx.id==id;
      });
    });

  }
    void startAddNewTransaction(BuildContext ctx){
      showModalBottomSheet(
        context: ctx, 
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        } );
    }
  bool _showChart= false;

  @override
  Widget build(BuildContext context) {
    final isLandscape=MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar=AppBar(
        title: Text('Budget App'),
        actions: [IconButton(
          onPressed: () {startAddNewTransaction(context);},
          icon: Icon( 
            Icons.add,
            color: Colors.white,)
        )],
      );
    final txListWidget= Container(
            height: (MediaQuery.of(context).size.height -
                     appbar.preferredSize.height-
                     MediaQuery.of(context).padding.top)*0.7,
            child: TransactionList(_userTransactions,deleteTransaction)
      );
    return Scaffold(
      appBar: appbar, 
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget>[
          if(isLandscape) Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Show Chart'),
              Switch(value: _showChart, onChanged: (val){
                setState(() {
                  _showChart=val;
                });
              }),
            ],
          ),
          if(!isLandscape) Container(
            height: (MediaQuery.of(context).size.height -
                     appbar.preferredSize.height -
                     MediaQuery.of(context).padding.top)*0.3,
            child: Chart(_recentTransactions)),
          if(!isLandscape) txListWidget,
          if(isLandscape) _showChart ? Container(
            height: (MediaQuery.of(context).size.height -
                     appbar.preferredSize.height -
                     MediaQuery.of(context).padding.top)*0.65,
            child: Chart(_recentTransactions))
          : txListWidget
        ]
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
        onPressed: () {startAddNewTransaction(context);},
        ),
    );
  }
}
