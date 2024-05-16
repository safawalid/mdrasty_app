import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mdrasty_app/login.dart';
import 'package:mdrasty_app/sharedprefernces.dart';
import 'package:mdrasty_app/student/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class shared extends StatefulWidget {
  @override
  _sharedState createState() => _sharedState();
}

class _sharedState extends State<shared> {
  final authoservice autho = authoservice();
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    bool isLoggedI = await autho.isloggin();
    if (isLoggedI) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => TabStudent()),
      // );
    } 
    // else {
    //   // المستخدم لم يقم بتسجيل دخوله بعد، قم بتوجيهه إلى صفحة تسجيل الدخول
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => MyTabLogin()),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MyTabLogin();
  }
}

// class Log extends StatelessWidget {
//   final authoservice autho = authoservice();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           child: Text('Login'),
//           onPressed: () async {
//             await autho.login();
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage()),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   final authoservice autho = authoservice();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           child: Text('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj'),
//           onPressed: () async {
//             await autho.logout();
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => Log()),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
