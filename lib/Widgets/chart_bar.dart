import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spedingPctOfTotal;
  ChartBar({this.label,this.spedingPctOfTotal,this.spendingAmount});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((ctx, constraints){
      return Column(children:[
      Container(
      height: constraints.maxHeight*0.15,
      child:FittedBox(child:
        Text('\$ ${spendingAmount.toStringAsFixed(0)}'))),
      SizedBox(height:constraints.maxHeight*0.05,),
      Container(
      height: constraints.maxHeight*0.6,
      width: 10,
      child: Stack(children: [
        Container(decoration: BoxDecoration(border: 
        Border.all(color: Colors.grey,
        width: 0.1),
        color: Color.fromRGBO(220,220,220, 1),
        borderRadius: BorderRadius.circular(10),
        ),),
        FractionallySizedBox(
          heightFactor: spedingPctOfTotal,
          child: Container(decoration: 
          BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
            ),),)
      ]),
      //decoration: BoxDecoration,
      ),
      SizedBox(height: constraints.maxHeight*0.05,),
      Container(height: constraints.maxHeight*0.15,
      child: FittedBox(child: Text(label))),
    ]
    );
    }));
    
  }
}