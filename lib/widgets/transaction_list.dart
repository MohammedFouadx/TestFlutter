import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {



  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 300,
        child: transactions.isEmpty ? Column(children: [
          Text('No transaction added yet!'  , style: Theme.of(context).textTheme.title,),
          Container(
            height: 200,
              child: Image.asset('assets/images/waiting.png'))
        ],) : ListView.builder(
          itemBuilder: (ctx , index) {
            return  Card(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration:
                    BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor)),
                    child: Text('\$${transactions[index].amount}',
                      style: TextStyle(fontSize: 20,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold),),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(transactions[index].title,
                        style: Theme.of(context).textTheme.title),

                      Text(transactions[index].date.toString(), style: TextStyle(fontSize: 15,
                          color: Colors.grey),)
                    ],),
                ],),
            );
          },
          itemCount: transactions.length,
        ),
    );

  }
}
