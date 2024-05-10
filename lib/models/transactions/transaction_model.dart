import 'package:moneysaver/models/category/category_model.dart';
import 'package:hive/hive.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class transactionModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModel category;
  @HiveField(5)
  String? id;

  transactionModel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    String? id,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();
}
