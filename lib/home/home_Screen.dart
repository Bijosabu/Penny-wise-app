import 'package:flutter/material.dart';
import 'package:moneysaver/home/widgets/bottomNavigation.dart';
import 'package:moneysaver/transactions/transactionScreen.dart';
import 'package:moneysaver/category/categoryScreen.dart';
import 'package:moneysaver/dbfunctions/category_db.dart';
import 'package:moneysaver/models/category/category_model.dart';
import 'package:moneysaver/category/category_add_popup.dart';
import 'package:moneysaver/transactions/addTransactionScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [
    categoryScreen(),
    transactionScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Penny Wise',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: moneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updateIndex, child) {
            return _pages[updateIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF545AA2),
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            showcategorypopup(context);
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return addTransactionScreen();
              },
            ));

            // print('add category');
            // final _sample = CategoryModel(
            //     id: DateTime.now().millisecondsSinceEpoch.toString(),
            //     name: 'Expense',
            //     type: CategoryType.expense);
            // CategoryDB().insertCategory(_sample);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
