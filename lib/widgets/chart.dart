import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  //const Chart({ Key? key }) : super(key: key);

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  //creating a getter
  List <Map<String, Object>> get groupedTransactionValues {
    //
    return List.generate(
      7, (index) {
        //getting the weekday
        final weekDay = DateTime.now().subtract(
          Duration(days: index)
        );
        var totalSum = 0.0;

        //calculating the amount
        for (var i=0; i < recentTransactions.length; i++) {
          //check if the transaction happened today
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) 
          {
            //
            totalSum += recentTransactions[i].amount;
          }
        }

        print(DateFormat.E().format(weekDay));
        print(totalSum);


        //returning a map
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1), //for the symbol of the week day
          'amount': totalSum,
        };
      }).reversed.toList();
  }

  //total spending for the week
  //getter
  double get totalSpending {
    //
    return groupedTransactionValues.fold(0.0, (previousValue, item) {
      //
      return previousValue + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            //
            //return Text('${data['data']}: ${data['amount']}');
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'], 
                data['amount'], 
                totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
          ),
      ),
    );
  }
}