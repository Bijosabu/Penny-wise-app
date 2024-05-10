// ignore_for_file: camel_case_types, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:moneysaver/dbfunctions/category_db.dart';
// import 'package:lottie/lottie.dart';
import 'package:moneysaver/dbfunctions/transaction_Db.dart';
import 'package:moneysaver/models/transactions/transaction_model.dart';
import 'package:moneysaver/models/category/category_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class transactionScreen extends StatefulWidget {
  const transactionScreen({super.key});

  @override
  State<transactionScreen> createState() => _transactionScreenState();
}

class _transactionScreenState extends State<transactionScreen> {
  late Box box;
  List<FlSpot> dataSet = [];
  DateTime today = DateTime.now();
  List<transactionModel> items = [];
  @override
  void initState() {
    CategoryDB().refreshUI();
    TransactionDb.instance.refresh();
    _updateTotals();

    // fetch();
    // box = Hive.openBox('Transaction_Db');
    // box = Hive.box('Transaction_Db');
    // datas() async {
    //   await getdata();
    //   getPlotPoints(data);
    // }
    // getPlotPoints(data);
    super.initState();
  }

// to find the total balance and income,expense details

  final ValueNotifier<List<double>> totalsNotifier =
      ValueNotifier<List<double>>([0, 0, 0]);

  void _updateTotals() async {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      _updateTotals();
      totalsNotifier.notifyListeners();
    });

    // final transactions = box.values.toList();
    final transactions =
        Hive.box<transactionModel>('Transaction_Db').values.toList();
    double totalBalance = 0;
    double totalIncome = 0;
    double totalExpense = 0;
    for (final transaction in transactions) {
      if (transaction.type == CategoryType.income) {
        totalIncome += transaction.amount;
      } else if (transaction.type == CategoryType.expense) {
        totalExpense += transaction.amount;
      }
    }
    totalBalance = totalIncome - totalExpense;
    totalsNotifier.value = [totalBalance, totalIncome, totalExpense];
  }

  Future<List<transactionModel>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<transactionModel> items = [];
      box.toMap().values.forEach((element) {
        items.add(
          transactionModel(
            purpose: element['purpose'] as String,
            amount: element['amount'].toDouble(),
            date: element['date'] as DateTime,
            type: element['type'] as CategoryType,
            category: element['category'] as CategoryModel,
            id: element['id'] as String?,
          ),
        );
      });
      print(items);
      return items;
    }
  }

  List<FlSpot> getPlotPoints(List<transactionModel> entireData) {
    dataSet = [];
    List tempdataSet = [];

    for (transactionModel item in entireData) {
      if (item.date.month == today.month && item.type == CategoryType.expense) {
        tempdataSet.add(item);
      }
    }
    //
    // Sorting the list as per the date
    tempdataSet.sort((a, b) => a.date.day.compareTo(b.date.day));
    //
    for (var i = 0; i < tempdataSet.length; i++) {
      dataSet.add(
        FlSpot(
          tempdataSet[i].date.day.toDouble(),
          tempdataSet[i].amount.toDouble(),
        ),
      );
    }
    print(dataSet);
    return dataSet;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      _updateTotals();
      // fetch();
      // getPlotPoints(items);
    });
    return SingleChildScrollView(
      child: Column(
        children: [
          // const SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(
                    IconlyLight.profile,
                    color: Color(0xFF545AA2),
                    size: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        // color: Colors.blueAccent[100],
                        gradient: const SweepGradient(
                            colors: [Colors.white70, Colors.white]),
                        // gradient: const LinearGradient(
                        //     colors: [Colors.blueAccent, Colors.blueGrey]),
                        borderRadius: BorderRadius.circular(8)),
                    // color: Colors.lightBlue,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Welcome!',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BalanceCard(totalsNotifier: totalsNotifier),
          // const SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   children: const [
          //     Padding(
          //       padding: EdgeInsets.only(left: 20, top: 10),
          //       child: Text(
          //         'Expenses',
          //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 2,
          ),
          // dataSet.isEmpty || dataSet.length < 2
          //     ? Container(
          //         decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(12),
          //             boxShadow: [
          //               BoxShadow(
          //                   color: Colors.grey.withOpacity(0.5),
          //                   spreadRadius: 8,
          //                   blurRadius: 6,
          //                   offset: const Offset(4, 4))
          //             ]),
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          //         margin: const EdgeInsets.all(12),
          //         // height: 250,
          //         child: const Text(
          //           'Not enough transactions to plot data',
          //           style: TextStyle(fontWeight: FontWeight.bold),
          //         ))
          //     : Container(
          //         decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(12),
          //             boxShadow: [
          //               BoxShadow(
          //                   color: Colors.grey.withOpacity(0.5),
          //                   spreadRadius: 8,
          //                   blurRadius: 6,
          //                   offset: const Offset(4, 4))
          //             ]),
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          //         margin: const EdgeInsets.all(12),
          //         height: 250,
          //         child: LineChart(LineChartData(
          //           borderData: FlBorderData(show: false),
          //           lineBarsData: [
          //             LineChartBarData(
          //               spots: getPlotPoints(items),
          //               isCurved: false,
          //               barWidth: 2.5,
          //               color: Colors.blueAccent,
          //             )
          //           ],
          //         )),
          //       ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Recent expenses',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: TransactionDb.instance.transactionNotifier,
            builder:
                (BuildContext context, List<transactionModel> newList, child) {
              return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final value = newList[index];

                    return Slidable(
                      endActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
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
                            radius: 30,
                            child: Text(
                              parseDate(value.date),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          title: Text('Rs  ${value.amount}'),
                          subtitle: Text(
                            '${value.purpose}---${value.category.name}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
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
                  itemCount: newList.length);
            },
          )
        ],
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.totalsNotifier,
  });

  final ValueNotifier<List<double>> totalsNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // height: 180,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient:
            const LinearGradient(colors: [Colors.blueAccent, Colors.blueGrey]),
      ),
      child: ValueListenableBuilder<List<double>>(
        valueListenable: totalsNotifier,
        builder: (context, totals, child) {
          double totalBalance = totals[0];
          double totalIncome = totals[1];
          double totalExpense = totals[2];
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Total Balance',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'RS.${totalBalance.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: cardIncome(totalIncome),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                    child: cardExpense(totalExpense),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

String parseDate(DateTime date) {
  final date0 = DateFormat.MMMd().format(date);
  final splitteddate = date0.split(' ');
  return '${splitteddate.last}\n${splitteddate.first}';
  // return '${date.day}\n${date.month}';
}

Widget cardIncome(double value) {
  return Row(
    children: [
      const SizedBox(
        height: 20,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.arrow_upward,
          size: 32,
          color: Colors.green[700],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            const Text(
              'Income',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              value.toString(),
              style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      )
    ],
  );
}

Widget cardExpense(double value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.arrow_downward,
          size: 32,
          color: Colors.red[800],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            const Text(
              'Expense',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              value.toString(),
              style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      )
    ],
  );
}

// class HiveController {
//   static Future<List<transactionModel>> getTransactionsByCategoryType(
//       CategoryType categoryType) async {
//     final box = await Hive.openBox<transactionModel>('Transaction_Db');
//     final transactions = box.values.toList().cast<transactionModel>();

//     return transactions
//         .where((transaction) => transaction.type == categoryType)
//         .toList();
//   }

//   static Future<double> getTotalAmountByCategoryType(
//       CategoryType categoryType) async {
//     final transactions = await getTransactionsByCategoryType(categoryType);
//     final totalAmount =
//         transactions.fold(0.0, (sum, transaction) => sum + transaction.amount);

//     return totalAmount;
//   }
// }
// ignore_for_file: camel_case_types, avoid_unnecessary_containers

 