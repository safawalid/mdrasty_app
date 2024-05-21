import 'package:mdrasty_app/constant/fontstyle.dart';

import 'package:flutter/material.dart';


import 'package:mdrasty_app/style/fontstyle.dart';


import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
    child:AppBar(
  actions: [
    IconButton(
      icon: Image.asset(
          "img/madrsatylogor.jpg", // استبدل هذا بالمسار الصحيح للصورة
        width: MediaQuery.of(context).size.width * 40,
        height: MediaQuery.of(context).size.height * 20,
        
        color: Colors.white,// تعيين ارتفاع الصورة
      ),
      onPressed: () {
        // يمكنك تنفيذ أي عملية هنا عند الضغط على الصورة
      },
    ),
  ],
  title: Text(
    title,
    textAlign: TextAlign.center,
    style: fontappbar.fonttitle,
  ),
  centerTitle: true,
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blue.shade900, Colors.blue.shade700,
                                              Colors.blue.shade700, Colors.blue.shade900
        ],
      ),
    ),
  ),
),

  );
}


  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  }



