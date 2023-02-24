import 'package:flutter/material.dart';
import 'package:moneysaver/dbfunctions/category_db.dart';
import 'package:lottie/lottie.dart';
import 'package:moneysaver/dbfunctions/transaction_Db.dart';
import 'package:moneysaver/models/transactions/transaction_model.dart';
import 'package:moneysaver/models/category/category_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class transactionScreen extends StatefulWidget {
  const transactionScreen({super.key});

  @override
  State<transactionScreen> createState() => _transactionScreenState();
}

class _transactionScreenState extends State<transactionScreen> {
  @override
  void initState() {
    CategoryDB().refreshUI();
    TransactionDb.instance.refresh();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          // height: 150, width: double.infinity,
          child: Lottie.asset(
            'assets/lottie/TransactionLottie.json',
          ),

          // child: Image.asset(
          //   'assets/images/wallet3.gif',
          //   // color: Colors.deepPurpleAccent,
          //   height: 70,
          // ),
        ),
        // Card(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(10),
        //     child: Image(
        //       image: AssetImage(
        //         'assets/images/moneysaver_transactions.jpg',
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            'Transactions',
            style: TextStyle(
                color: Color(0xFF545AA2),
                fontSize: 23,
                fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ValueListenableBuilder(
          valueListenable: TransactionDb.instance.transactionNotifier,
          builder:
              (BuildContext context, List<transactionModel> newList, child) {
            return Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final value = newList[index];

                    return Slidable(
                      endActionPane:
                          ActionPane(motion: ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (context) {
                            TransactionDb.instance.deleteTransaction(value.id!);
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                        ),
                      ]),
                      key: Key(value.id!),
                      child: Card(
                        elevation: 22,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: value.type == CategoryType.income
                                ? Colors.green
                                : Colors.red,
                            child: Text(
                              parseDate(value.date),
                              textAlign: TextAlign.center,
                            ),
                            radius: 30,
                          ),
                          title: Text('Rs  ${value.amount}'),
                          subtitle: Text(
                            '${value.purpose}---${value.category.name}',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 05,
                    );
                  },
                  itemCount: newList.length),
            );
          },
        ),
      ],
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitteddate = _date.split(' ');
    return '${_splitteddate.last}\n${_splitteddate.first}';
    // return '${date.day}\n${date.month}';
  }
}
