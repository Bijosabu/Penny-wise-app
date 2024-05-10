import 'package:flutter/material.dart';
import 'package:moneysaver/home/home_Screen.dart';

class moneyManagerBottomNavigation extends StatelessWidget {
  const moneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
          selectedItemColor: const Color(0xFF545AA2),
          unselectedItemColor: Colors.grey,
          currentIndex: updatedIndex,
          onTap: (newIndex) {
            HomeScreen.selectedIndexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: ' Transactions'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categories'),
          ],
        );
      },
    );
  }
}
