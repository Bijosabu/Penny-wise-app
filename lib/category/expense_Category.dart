import 'package:flutter/material.dart';
import 'package:moneysaver/dbfunctions/category_db.dart';
import 'package:moneysaver/models/category/category_model.dart';
import 'package:lottie/lottie.dart';

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 40,
          ),
          child: Container(
            height: 180,
            color: Colors.grey[200],
            child: Lottie.asset(
              'assets/lottie/expenseslottie.json',
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add any expenses',
                style: TextStyle(
                    color: Color(0xFF545AA2),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.blueGrey,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: ValueListenableBuilder(
              valueListenable: CategoryDB().expenseCategoryList,
              builder: (BuildContext context, List<CategoryModel> expenselist,
                  child) {
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(22, 22, 22, 0),
                  itemBuilder: (context, index) {
                    final category = expenselist[index];
                    return Card(
                      elevation: 30,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: Text(category.name),
                        trailing: IconButton(
                          onPressed: () {
                            CategoryDB().deletecategory(category.id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Padding(padding: EdgeInsets.all(05));
                  },
                  itemCount: expenselist.length,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
// ListView.separated(
//               padding: EdgeInsets.all(22),
//               itemBuilder: (context, index) {
//                 return Card(
//                   elevation: 30,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: ListTile(
//                     title: Text('Expense Category $index'),
//                     trailing: IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.delete,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               separatorBuilder: (context, index) {
//                 return const SizedBox(
//                   height: 10,
//                 );
//               },
//               itemCount: 05),