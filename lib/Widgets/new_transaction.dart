
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController= TextEditingController();
  final _amountController= TextEditingController();
  DateTime _selectedDate;

  void _submitData(){
    final enteredTitle= _titleController.text;
    final enteredAmount=double.parse(_amountController.text);
    if(enteredTitle.isEmpty ||enteredAmount<=0 || _selectedDate==null){
      return;
    }
    widget.addtx(
          enteredTitle,
          enteredAmount, 
          _selectedDate,
    );
    Navigator.of(context).pop(); //to close our modal bottom sheet
  }
  void _presentDatePicker(){
    showDatePicker(context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
      ).then((pickedDate) {
        if (pickedDate == null){
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
      child: Card(child: Container(
            padding:EdgeInsets.only(
              top: 10,
              left: 10,
              right:10,
              bottom: MediaQuery.of(context).viewInsets.bottom+10,
            ),
            child:Column(crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText:'Title'),
                controller: _titleController,
                onSubmitted: (_)=>_submitData(),
                /*onChanged:(val){
                  titleInput=val;
                },*/
                ),
              TextField(
                decoration: InputDecoration(
                  labelText:'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_)=>_submitData(),//you need to pass an String argument here even if you dont plan to use it otherwise it shows error 
                //here _ indicates that you get the argument but dont care about it or dont use it
                /*onChanged:(val){
                  amountInput=val;
                },*/
                ),
              Container(
                height: 70,
                child: Row(
                  children: [
                  Expanded(
                    child: Text(_selectedDate==null?'No Date Choosen!' 
                    : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  //now expanded widget takes as much space it has after the TextButton takes the space it requiers.
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text('Choose Date',
                    style: TextStyle(
                      color:Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,  
                    ),))
                ]),
              ),
              ElevatedButton(
                onPressed:_submitData,
                child: Text('Add transaction',
                ),
              )
              ],
            )
          ),
          ),
    );
  }
}