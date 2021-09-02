import 'package:dayone/widgets/new_transaction.dart';
import 'package:dayone/widgets/transaction_list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main(){
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App",
      theme: ThemeData(
        primarySwatch: Colors.brown,
        accentColor: Colors.indigo,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(title:
            TextStyle(fontFamily: 'Quicksand' , fontSize: 20 , fontWeight: FontWeight.bold ,
                ))
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions =[
  //   Transaction(id: 't1' , title: 'Coach' , amount: 30.0 , date: DateTime.now()),
  //   Transaction(id: 't1' , title: 'Coach' , amount: 30.0 , date: DateTime.now()),
  //   Transaction(id: 't1' , title: 'Coach' , amount: 30.0 , date: DateTime.now()),
  ];

  void _addNewTransaction (String txTitle , double txAmount) {
    final newTx = Transaction(id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

    void _startAddNewTransaction(BuildContext ctx){
      showModalBottomSheet(context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          ) ;
      },);
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App' , style: TextStyle(fontFamily: 'OpenSans'),),
        actions: [
          IconButton(icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            Container(
              width: double.infinity,
              child: Card(
                color: Theme.of(context).accentColor,
                elevation: 5,
                child: Text('CHART',
                  style: TextStyle(
                      color: Colors.white, fontSize: 20),),
              ),
            ),
            TransactionList(_userTransactions),

          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
  }

