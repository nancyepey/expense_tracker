import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  //const TransactionList({ Key? key }) : super(key: key);

  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty ? Column(
        children: [
          Text(
            'No transaction added yet!s',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 200,
            child: Image.asset(
              'assets/image/waiting.png',
              fit: BoxFit.cover,
              ),
          ),
        ],
      ) : ListView.builder(
        itemBuilder: (ctx, index) {
          //
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
                    child: Text(
                      '\$${transactions[index].amount}',
                    ),
                  ),
                ),
                ),
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.headline1,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date),
                ),
                trailing: IconButton(
                  onPressed: () => deleteTx(transactions[index].id), 
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  ),
            ),
          );
          //
          // return Card(
          //         child: Row(
          //           children: [
          //             Container(
          //               margin: EdgeInsets.symmetric(
          //                 vertical: 10,
          //                 horizontal: 15,
          //               ),
          //               decoration: BoxDecoration(
          //                   border: Border.all(
          //                 color: Theme.of(context).primaryColor,
          //                 width: 2,
          //               )),
          //               padding: EdgeInsets.all(10),
          //               child: Text(
          //                 // transaction.amount.toString(),
          //                 '\$${transactions[index].amount.toStringAsFixed(2)}',
          //                 //FontWeight is a static property, static property are like enums but don't have numbers but a complex value
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 20,
          //                   color: Theme.of(context).primaryColor,
          //                 ),
          //               ),
          //             ),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   transactions[index].title,
          //                   style: Theme.of(context).textTheme.headline1,
          //                   // style: TextStyle(
          //                   //   fontSize: 16,
          //                   //   fontWeight: FontWeight.bold,
          //                   // ),
          //                 ),
          //                 Text(
          //                   //transaction.date.toString()
          //                   //different format using intl package
          //                   // DateFormat().format(transaction.date),
          //                   // DateFormat('yyyy-MM-dd').format(transaction.date),
          //                   DateFormat.yMMMd().format(transactions[index].date),
          //                   style: TextStyle(
          //                     // fontWeight: FontWeight.bold,
          //                     color: Colors.grey,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       );
        },
        itemCount: transactions.length,
        ),


        //old
      // child: ListView(
      //         children: transactions.map((transaction) {
      //           return Card(
      //             child: Row(
      //               children: [
      //                 Container(
      //                   margin: EdgeInsets.symmetric(
      //                     vertical: 10,
      //                     horizontal: 15,
      //                   ),
      //                   decoration: BoxDecoration(
      //                       border: Border.all(
      //                     color: Colors.purple,
      //                     width: 2,
      //                   )),
      //                   padding: EdgeInsets.all(10),
      //                   child: Text(
      //                     // transaction.amount.toString(),
      //                     '\$${transaction.amount}',
      //                     //FontWeight is a static property, static property are like enums but don't have numbers but a complex value
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 20,
      //                       color: Colors.purple,
      //                     ),
      //                   ),
      //                 ),
      //                 Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       transaction.title,
      //                       style: TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                     Text(
      //                       //transaction.date.toString()
      //                       //different format using intl package
      //                       // DateFormat().format(transaction.date),
      //                       // DateFormat('yyyy-MM-dd').format(transaction.date),
      //                       DateFormat.yMMMd().format(transaction.date),
      //                       style: TextStyle(
      //                         // fontWeight: FontWeight.bold,
      //                         color: Colors.grey,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           );
      //         }).toList(),
      //       ),
    );
  }
}