
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mdrasty_app/view/teacher/tabbar/tabsbar.dart';






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
