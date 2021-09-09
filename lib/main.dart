import 'package:dayone/widgets/chart.dart';
import 'package:dayone/widgets/new_transaction.dart';
import 'package:dayone/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/transaction.dart';

void main(){
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]
  // );
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

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where( (tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction (String txTitle , double txAmount , DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
    );

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

    void _deleteTransaction(String id) {
        setState(() {
          _userTransactions.removeWhere((tx) => tx.id == id);
        });
    }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandScape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Flutter App' , style: TextStyle(fontFamily: 'OpenSans'),),
      actions: [
        IconButton(icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final txlistWidget = Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) * 0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            if (_isLandScape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart' ),
              Switch.adaptive(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
              }
              ),
            ],),

            if (!_isLandScape) Container(
                height: (
                    mediaQuery.size.height -
                        appBar.preferredSize.height - mediaQuery.padding.top ) * 0.2,
                child: Chart(_recentTransactions)),

            if(!_isLandScape) txlistWidget,



            if(_isLandScape) _showChart ? Container(
              height: (
                  mediaQuery.size.height -
                      appBar.preferredSize.height - mediaQuery.padding.top ) * 0.7,
                child: Chart(_recentTransactions))
                : txlistWidget
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

