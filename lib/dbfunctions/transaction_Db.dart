import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:moneysaver/models/transactions/transaction_model.dart';

const Transaction_Db_Name = 'Transaction_Db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(transactionModel value);
  Future<List<transactionModel>> getTransaction();
  Future<void> deleteTransaction(String id);
}

class TransactionDb implements TransactionDbFunctions {
  TransactionDb.internal();
  static TransactionDb instance = TransactionDb.internal();
  factory TransactionDb() {
    return instance;
  }
  ValueNotifier<List<transactionModel>> transactionNotifier = ValueNotifier([]);
  @override
  Future<void> addTransaction(transactionModel value) async {
    final dbTransaction =
        await Hive.openBox<transactionModel>(Transaction_Db_Name);
    await dbTransaction.put(value.id, value);
  }

  Future<void> refresh() async {
    final _list = await getTransaction();
    _list.sort(
      (first, second) => second.date.compareTo(first.date),
    );
    transactionNotifier.value.clear();
    transactionNotifier.value.addAll(_list);
    transactionNotifier.notifyListeners();
  }

  @override
  Future<List<transactionModel>> getTransaction() async {
    final dbTransaction =
        await Hive.openBox<transactionModel>(Transaction_Db_Name);
    return dbTransaction.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final dbTransaction =
        await Hive.openBox<transactionModel>(Transaction_Db_Name);
    await dbTransaction.delete(id);
    refresh();
  }
}
