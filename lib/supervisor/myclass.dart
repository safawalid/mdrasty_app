// import 'package:collasable_drawer/supervisor/tabs/profile.dart';
// import 'package:collasable_drawer/tabbar/mnotification/mnotification.dart';
// import 'package:collasable_drawer/tabbar/profile/profile.dart';
// import 'package:collasable_drawer/tabbar/schadule/schadule.dart';
// import 'package:collasable_drawer/tabbar/test.dart';
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mdrasty_app/style/appbar.dart';
import 'package:mdrasty_app/supervisor/component/drawer/custom_drawer.dart';


// import '../wedgits/class.dart';

class myclass extends StatefulWidget {
  const myclass({Key? key}) : super(key: key);

  @override
  myclassState createState() => myclassState();
}

class myclassState extends State<myclass> {
  var currentIndex = 0;

  void onTabChange(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: CustomAppBar(title: 'فصلي'),
          endDrawer: const CustomDrawer(),
          body: IndexedStack(),
        ),
      ),
    );
  }
}
