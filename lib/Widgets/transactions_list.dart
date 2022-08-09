import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Models/transcations.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  List<Transactions> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty? LayoutBuilder(builder: (ctx, constraints){
      return  Column(children: <Widget>[
      Text('No transactions added yet',
      style: Theme.of(context).textTheme.headline6,),
      SizedBox(height: 20,),
      Container(
        height: constraints.maxHeight*0.6,
        child: Image.asset('lib/assets/images/waiting.png',
        fit: BoxFit.cover),
      ),
    ],);
    })
    :Container(
      child: ListView.builder(
        itemBuilder: (context,index){
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(leading:
            CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(child:
                 Text('\$ ${transactions[index].amount}')),
              ),
              ),
            title:Text('${transactions[index].title}',
                  style: Theme.of(context).textTheme.headline6
              ),
            subtitle: Text(
              DateFormat.yMMMd().format(transactions[index].date),),
            trailing: MediaQuery.of(context).size.width>460 
            ?TextButton.icon(
              onPressed:(){deleteTx(transactions[index].id);}, 
              icon: Icon(
                Icons.delete,
                /*color: Colors.red,*/),
              label: Text('Delete Item', style: TextStyle(color: Theme.of(context).primaryColor),),)  
            :IconButton(
              icon: Icon(Icons.delete), 
              color: Theme.of(context).errorColor,
              onPressed: (){deleteTx(transactions[index].id);},
              ),
            ),
          );
          // Card(
          //     child:Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: Row(mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //         Container(
          //           child:Text('₹ ${transactions[index].amount.toStringAsFixed(2)}',
          //             style:TextStyle(
          //             color: Theme.of(context).primaryColor,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20.0)
          //             ),
          //           decoration: BoxDecoration(border: Border.all(
          //             color:Theme.of(context).primaryColor,
          //             width: 2,
          //             ),
          //           ),
          //           padding: EdgeInsets.all(10.0),
          //         ),
          //         Container(
          //           child: Column(crossAxisAlignment:CrossAxisAlignment.start,
          //             children: [
          //             Text(transactions[index].title, 
          //             style:Theme.of(context).textTheme.headline6,
          //             ),
          //             Text(DateFormat.yMMMd().format(transactions[index].date), //or DateFormat('yyyy-MM-dd').format(tx.date)
          //             style:TextStyle(color: Colors.grey.shade700,
          //             fontSize: 12.0)),
          //           ],),
          //           padding: EdgeInsets.all(10.0),
          //         )
          //       ],
          //       ),
          //       )
          //       );
        },
        itemCount: transactions.length,
      ),
      );
  }
}