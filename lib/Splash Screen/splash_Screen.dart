import 'package:flutter/material.dart';
import 'package:moneysaver/home/home_Screen.dart';
import 'package:lottie/lottie.dart';

// class AnimatedSplashScreen extends StatefulWidget {
//   @override
//   _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
// }

// class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     );
//     _controller.forward();
//     Future.delayed(Duration(seconds: 3), () {
//       Navigator.pushReplacement(context, MaterialPageRoute(
//         builder: (context) {
//           return HomeScreen();
//         },
//       ));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Container(
//             decoration: BoxDecoration(color: Colors.blueGrey),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.blueGrey,
//                 radius: 90.0,
//                 child: ClipOval(
//                   child: Image.asset(
//                     'assets/images/walletgifrdcd.gif',
//                     width: 180.0,
//                     height: 180.0,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10.0),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'WalletHub',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 4),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/moneybag.json',
          ),
          const SizedBox(height: 16),
          // ignore: prefer_const_constructors
          Text(
            'Penny Wise',
            style: TextStyle(
              color: const Color(0xFF545AA2),
              fontSize: 26,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ));
  }
}
