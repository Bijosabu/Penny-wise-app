import 'package:flutter/material.dart';
import 'package:moneysaver/models/category/category_model.dart';
import 'package:moneysaver/dbfunctions/category_db.dart';

ValueNotifier<CategoryType> selectedTypeNotifier =
    ValueNotifier(CategoryType.expense);

Future<void> showcategorypopup(BuildContext context) async {
  final namecontroller = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text('Add Category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: namecontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Category name'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ), // Change background color here
              ),
              onPressed: () {
                final name = namecontroller.text;

                if (name.isEmpty) {
                  return;
                }
                final type = selectedTypeNotifier.value;
                final category = CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: name,
                    type: type);
                CategoryDB().insertCategory(category);
                Navigator.of(ctx).pop();
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  // final SelectedCategoryType;
  const RadioButton({
    super.key,
    required this.title,
    required this.type,
  });
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedTypeNotifier,
      builder: (ctx, CategoryType newvalue, child) {
        return Row(
          children: [
            Radio<CategoryType>(
                value: type,
                groupValue: newvalue,
                onChanged: ((value) {
                  if (value == null) {
                    return;
                  }
                  selectedTypeNotifier.value = value;
                  selectedTypeNotifier.notifyListeners();
                })),
            Text(title),
          ],
        );
      },
    );
  }
}
