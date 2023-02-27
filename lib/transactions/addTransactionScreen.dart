import 'package:flutter/material.dart';
import 'package:moneysaver/models/category/category_model.dart';
import 'package:moneysaver/dbfunctions/category_db.dart';
import 'package:moneysaver/models/transactions/transaction_model.dart';
import 'package:moneysaver/dbfunctions/transaction_Db.dart';

class addTransactionScreen extends StatefulWidget {
  const addTransactionScreen({super.key});

  @override
  State<addTransactionScreen> createState() => _addTransactionScreenState();
}

class _addTransactionScreenState extends State<addTransactionScreen> {
  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  String? dropDownText;
  CategoryModel? selectedCategoryModel;
  final purposeTextController = TextEditingController();
  final amountTextController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    selectedCategoryType = CategoryType.income;
    super.initState();
  }

  // ValueNotifier<CategoryType> selectedCategory =
  // ValueNotifier(CategoryType.income);
/*
Purpose
Date
Amount
Income/Expense
Categorytype 

 */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Form(
          key: formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                      color: Color(0xFF545AA2),
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                //purpose
                child: TextFormField(
                  controller: purposeTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Purpose',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Purpose';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              //sizedbox
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                //purpose
                child: TextFormField(
                  controller: amountTextController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Amount';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              //calender

              TextButton.icon(
                onPressed: () async {
                  final selectedDateTemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 30)),
                      lastDate: DateTime.now());
                  if (selectedDateTemp == null) {
                    return;
                  } else {
                    print(selectedDateTemp.toString());
                    setState(() {
                      selectedDate = selectedDateTemp;
                    });
                  }
                },
                icon: Icon(Icons.calendar_month),
                label: Text(selectedDate == null
                    ? 'Select Date'
                    : selectedDate.toString()),
              ),

              //RadioButton
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        activeColor: Color(0xFF545AA2),
                        value: CategoryType.income,
                        groupValue: selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategoryType = CategoryType.income;
                            dropDownText = null;
                          });
                        },
                      ),
                      Text('Income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategoryType = CategoryType.expense;
                            dropDownText = null;
                          });
                        },
                      ),
                      Text('Expense'),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 50,
              ),
              // dropdownbutton
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    hint: Text('Select Category'),
                    value: dropDownText,
                    items: (selectedCategoryType == CategoryType.income
                            ? CategoryDB().incomeCategoryList
                            : CategoryDB().expenseCategoryList)
                        .value
                        .map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name),
                        onTap: () {
                          print(e.toString());
                          selectedCategoryModel = e;
                        },
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      setState(() {
                        print(selectedValue);
                        dropDownText = selectedValue;
                      });
                    },
                  ),

                  //Submit
                  ElevatedButton(
                    onPressed: () {
                      if (selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text(
                                'Please select the date and fill all fields'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (formkey.currentState!.validate()) {
                        addTransaction();
                      }
                    },
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF545AA2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = purposeTextController.text;
    final _amountText = amountTextController.text;
    if (_purposeText == null) {
      return;
    }
    if (_amountText == null) {
      return;
    }
    // if (dropDownText == null) {
    //   return;
    // }
    if (selectedDate == null) {
      return;
    }
    if (selectedCategoryModel == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }

    final _model = transactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: selectedDate!,
      type: selectedCategoryType!,
      category: selectedCategoryModel!,
    );

    await TransactionDb.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDb.instance.refresh();
  }
}
