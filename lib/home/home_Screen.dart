import 'package:flutter/material.dart';
import 'package:moneysaver/home/widgets/bottomNavigation.dart';
import 'package:moneysaver/transactions/transactionScreen.dart';
import 'package:moneysaver/category/categoryScreen.dart';
import 'package:moneysaver/category/category_add_popup.dart';
import 'package:moneysaver/transactions/addTransactionScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [
    transactionScreen(),
    categoryScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Penny Wise',
          style: TextStyle(color: Color(0xFF545AA2), fontSize: 22),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const moneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updateIndex, child) {
            return _pages[updateIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF545AA2),
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const addTransactionScreen();
              },
            ));
          } else {
            showcategorypopup(context);
            // print('add category');
            // final _sample = CategoryModel(
            //     id: DateTime.now().millisecondsSinceEpoch.toString(),
            //     name: 'Expense',
            //     type: CategoryType.expense);
            // CategoryDB().insertCategory(_sample);
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
