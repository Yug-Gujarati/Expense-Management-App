// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;
  
  TransactionList(this.transactions , this.deletetx);
  
  @override
  Widget build(BuildContext context) {
    return  Container(
      height:450,
      child: transactions.isEmpty 
         ?Column(
           children: <Widget> [
             Text(
                'No transection added yet!',
                style: Theme.of(context).textTheme.subtitle1,
             ),
             SizedBox(
               height: 70,
             ),
             Container(
               height: 200,
               child: Image.asset(
                 'assets/fonts/images/image.jpg',
                 fit: BoxFit.cover,
                 )),
           ] ,
         )
       : ListView.builder(
        itemBuilder: (ctx , index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text('\RS:${transactions[index].Amount}'),
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].Title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => deletetx(transactions[index].Id),
                ),
              ),
            );
        },
        itemCount: transactions.length,
      ),
    );
  }
}