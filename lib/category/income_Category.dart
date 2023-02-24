import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:moneysaver/dbfunctions/category_db.dart';
import 'package:moneysaver/models/category/category_model.dart';
import 'package:lottie/lottie.dart';

class IncomeCategory extends StatelessWidget {
  IncomeCategory({super.key});
  Color color = Colors.white60;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
          height: 200,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(color, BlendMode.modulate),
            child: Lottie.asset(
              'assets/lottie/incomelottie1.json',
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        // Container(
        //   height: 200,
        //   child: Lottie.asset('assets/lottie/incomelottie1.json',
        //       fit: BoxFit.scaleDown),
        // ),
        Padding(
          padding: const EdgeInsets.all(06.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add an income source',
                style: TextStyle(
                    color: Color(0xFF545AA2),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
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
              valueListenable: CategoryDB().incomeCategoryList,
              builder:
                  (BuildContext context, List<CategoryModel> newlist, child) {
                return ListView.separated(
                    padding: EdgeInsets.fromLTRB(22, 22, 22, 0),
                    itemBuilder: (context, index) {
                      final category = newlist[index];
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
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: newlist.length);
              },
            ),
          ),
        )
      ],
    );
  }
}
