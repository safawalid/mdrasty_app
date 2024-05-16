
// import 'package:collasable_drawer/loadpage.dart';
// import 'package:collasable_drawer/screens/home/drawer.dart';
// import 'package:collasable_drawer/tabbar/tabsbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mdrasty_app/student/bottomnav.dart';
import 'package:mdrasty_app/teacher/tabbar/tabsbar.dart';
// import 'package:mdrasty_app/loadpage.dart'; 
// import 'package:mdrasty_app/student/notes.dart';
import 'login.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mdrasty',
      home:
         Directionality(textDirection: TextDirection.rtl, child:tabsbutton ()),
          
    );
  }
}
