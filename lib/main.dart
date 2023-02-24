import 'package:flutter/material.dart';
import 'package:moneysaver/home/home_Screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneysaver/models/category/category_model.dart';
import 'package:moneysaver/Splash Screen/splash_Screen.dart';
import 'package:moneysaver/models/transactions/transaction_model.dart';
import 'package:moneysaver/colorPallete/pallete.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(transactionModelAdapter().typeId)) {
    Hive.registerAdapter(transactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: const MaterialColor(
            0xFF545AA2,
            {
              50: Color(0xFFF2F3F7),
              100: Color(0xFFDEE0EB),
              200: Color(0xFFC9CBD9),
              300: Color(0xFFAFAFC1),
              400: Color(0xFF545AA2),
              500: Color(0xFF81829B),
              600: Color(0xFF6B6C89),
              700: Color(0xFF5A5B76),
              800: Color(0xFF484864),
              900: Color(0xFF2E2F3F),
            },
          ),
          brightness: Brightness.light),
      home: const AnimatedSplashScreen(),
    );
  }
}
