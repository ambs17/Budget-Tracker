import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_complete_guide/Models/transcations.dart';
import 'package:flutter_complete_guide/Widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String,Object>> get groupedTranscationValues {
    return List.generate(7, (index) {
      final weekDay= DateTime.now().subtract(
        Duration(days: index),
        );
      var totalSum=0.0;
      for(var i=0;i<recentTransactions.length;i++){
        if(recentTransactions[i].date.day==weekDay.day &&
        recentTransactions[i].date.month==weekDay.month &&
        recentTransactions[i].date.year==weekDay.year ){
          totalSum += recentTransactions[i].amount;

        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(totalSum);
      
      return {'day': DateFormat.E().format(weekDay).substring(0,1),
      'amount': totalSum};
    }).reversed.toList(); //reversed gives iterables therefore convert it into a list using toList()
  }
  double get MaxSpending { //totalSpending used to calculate total spending percentage
    return groupedTranscationValues.fold(0.0, (sum, item){
      return sum+ item['amount'];
    });
  }
  @override
  Widget build(BuildContext context) {
    print(groupedTranscationValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
          groupedTranscationValues.map((data){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spedingPctOfTotal:(
                  MaxSpending ==0.0 ? 0.0 : (data['amount'] as double)/MaxSpending)),
            );
          }).toList(),
        ),
      )
    );
  }
}