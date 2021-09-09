import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {



  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions , this.deleteTx);

  @override
  Widget build(BuildContext context) {

    return transactions.isEmpty
        ?  LayoutBuilder(builder: ( ctx , constraints) {
            return Column(
              children: [
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset('assets/images/waiting.png'),
                ),
              ],
            );
          })
        : ListView.builder(
          itemBuilder: (ctx , index) {
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8 , horizontal: 5),
              color: Color.fromRGBO(250, 250, 250, 1),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Text('\$${transactions[index].amount}' ,
                    style: TextStyle( color: Colors.white , fontWeight: FontWeight.bold),),
                  backgroundColor: Theme.of(context).accentColor,
                ),
                title: Text('${transactions[index].title}' ,
                style: Theme.of(context).textTheme.title,),
                subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),

                trailing: MediaQuery.of(context).size.width > 500 ? FlatButton.icon
                  (
                    onPressed: () => deleteTx(transactions[index].id),
                    icon: Icon(Icons.delete , color: Theme.of(context).errorColor,) ,
                    label: Text('Delete')
                )

                    :IconButton(
                  icon: Icon(Icons.delete , color: Theme.of(context).errorColor,),
                  onPressed: () => deleteTx(transactions[index].id)
                ),
              ),
            );
          },
          itemCount: transactions.length,

    );

  }
}
