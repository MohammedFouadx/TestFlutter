import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enterdTitle = titleController.text;
    final enterdAmount = double.parse(amountController.text) ;

    if (enterdTitle.isEmpty || enterdAmount <= 0){
      return;
    }
    widget.addTx(
      enterdTitle,
      enterdAmount,
    );
    
    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation : 5 ,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget> [
            TextField(
              decoration: InputDecoration(labelText: 'Title' , labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor)),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount' , labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor)),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text('Add Transaction' , style:
              TextStyle(color: Theme.of(context).primaryColor , fontWeight: FontWeight.bold) ,),
              onPressed: submitData
            ),
          ],),
      ),
    );

  }
}
