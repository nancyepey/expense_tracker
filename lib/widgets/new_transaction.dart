// import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //const NewTransaction({ Key? key }) : super(key: key);
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      //
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    //
    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    //
    widget.addTx(
      // _titleController.text,
      // double.parse(_amountController.text),
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    //after submitting data above
    //to come out of the modal
    Navigator.of(context).pop();

  }

  //show a date picker
void _presentDatePicker() {
  //
  // showDatePicker return a Future
  // then allows us to do provide a fxn (anonynous fxn) when the user choose a date when it finally returns a value
  showDatePicker(
    context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2022),
    lastDate: DateTime.now(),
    ).then((pickedDate) {
      //
      if(pickedDate == null) {
        //
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
      
    });
}

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    // onChanged: (val) {
                    //   //
                    //   titleInput = val;
                    // },
                    controller: _titleController,
                    onSubmitted: (_) => _submitData(),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Amount',
                    ),
                    // onChanged: (val) => amountInput = val,
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    //onSubmitted: (val) => submitData,
                    onSubmitted: (_) => _submitData(),
                  ),
                  //date picker and text field to output the selected date
                  Container(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedDate == null ?
                            'No Date Chosen' :
                            'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                            ),
                        ),
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          onPressed: _presentDatePicker, 
                         child: Text(
                           'Choose Date',
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                           ),
                         ),

                         ),
                      ],
                    ),
                  ),

                  RaisedButton(
                    onPressed: _submitData,
                    // onPressed: () {
                    //   // print(titleInput);
                    //   // print(amountInput);
    
                    //   print(titleController.text);
                    //   print(amountController.text);
                    //   //
                    // },
                    child: Text('Add Transaction'),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                  )
                ],
              ),
            ),
          );
  }
}