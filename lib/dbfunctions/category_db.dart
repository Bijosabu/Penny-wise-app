import 'package:moneysaver/models/category/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

const String Db_name = 'category_db';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deletecategory(String CategoryId);
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return instance;
  }
  ValueNotifier<List<CategoryModel>> incomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryList = ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDb = await Hive.openBox<CategoryModel>(Db_name);
    await _categoryDb.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDb = await Hive.openBox<CategoryModel>(Db_name);
    return _categoryDb.values.toList();
  }

  Future<void> refreshUI() async {
    final allcategorylist = await getCategories();
    incomeCategoryList.value.clear();
    expenseCategoryList.value.clear();
    await Future.forEach(
      allcategorylist,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryList.value.add(category);
        } else {
          expenseCategoryList.value.add(category);
        }
      },
    );
    expenseCategoryList.notifyListeners();
    incomeCategoryList.notifyListeners();
  }

  @override
  Future<void> deletecategory(String CategoryId) async {
    final _categoryDb = await Hive.openBox<CategoryModel>(Db_name);
    _categoryDb.delete(CategoryId);
    refreshUI();
  }
}
