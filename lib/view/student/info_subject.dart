import 'package:flutter/material.dart';
import 'package:mdrasty_app/constant/appbar.dart';
import 'package:mdrasty_app/view/student/components/drawer/custom_drawer.dart';

class bookpdf extends StatelessWidget {
  const bookpdf({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "الكتdاب",),
      drawer: CustomDrawer(),
    );
  }
}