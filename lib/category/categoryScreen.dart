import 'package:flutter/material.dart';
import 'package:moneysaver/category/income_Category.dart';
import 'package:moneysaver/dbfunctions/category_db.dart';
import 'package:moneysaver/category/expense_Category.dart';

class categoryScreen extends StatefulWidget {
  const categoryScreen({super.key});

  @override
  State<categoryScreen> createState() => _categoryScreenState();
}

class _categoryScreenState extends State<categoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  @override
  void initState() {
    _tabcontroller = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabcontroller,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(
              text: 'INCOME',
            ),
            Tab(
              text: 'EXPENSE',
            )
          ],
        ),
        Flexible(
          child: TabBarView(
            controller: _tabcontroller,
            children: [
              IncomeCategory(),
              const ExpenseCategory(),
            ],
          ),
        ),
      ],
    );
  }
}
