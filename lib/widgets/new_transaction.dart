import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enterdTitle = _titleController.text;
    final enterdAmount = double.parse(_amountController.text) ;

    if (enterdTitle.isEmpty || enterdAmount <= 0 || _selectedDate == null){
      return;
    }
    widget.addTx(
      enterdTitle,
      enterdAmount,
      _selectedDate,
    );
    
    Navigator.of(context).pop();

  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2008),
        lastDate: DateTime.now(),
    ).then((pickedDate) {
        if(pickedDate == null){
            return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });

    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation : 5 ,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget> [
              TextField(
                decoration: InputDecoration(labelText: 'Title' , labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor)),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount' , labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor)),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(_selectedDate == null ? 'No Date Chosen!' : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}',)),
                    FlatButton(
                      child: Text('Choose Date' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold,) ),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: (){
                        _presentDatePicker();
                      },
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction' , style:
                TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 15) ,),
                color: Theme.of(context).primaryColor,
                onPressed: _submitData
              ),
            ],),
        ),
      ),
    );

  }
}
