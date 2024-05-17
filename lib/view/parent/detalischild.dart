import 'package:flutter/material.dart';
import 'package:mdrasty_app/constant/appbar.dart';
import 'package:mdrasty_app/view/parent/drawer/custom_drawer.dart';


class detalischild extends StatelessWidget {
  const detalischild({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(appBar: CustomAppBar(title: "مدرستي",),
      drawer: Drawerparent(),),
    );
  }
}