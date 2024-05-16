

import 'package:flutter/material.dart';
import 'package:mdrasty_app/student/library.dart';

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
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style:fontappbar.fonttitle,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo.shade500,
                Colors.blue.shade300,
                Colors.indigo.shade800,
              ],
            ),
          ),
        ),
        actions: [
          Row(
            children: [
               // Add a spacer to push the IconButton to the right
              IconButton(
                icon: Icon(Icons.menu_book),
                onPressed: () {
                  // عند الضغط على أيقونة "كتب" يتم عرض ديالوج الأنواع
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(child: Text('اختر نوع الكتب',style: fontstyle.fontheading,)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildBookTypeItem(context, 'روايات'),
                            _buildBookTypeItem(context, 'علوم'),
                            _buildBookTypeItem(context, 'تاريخ'),
                            
                            // يمكنك إضافة المزيد من الأنواع هنا
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget _buildBookTypeItem(BuildContext context, String type) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => BooksGridView(type: type),
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade300,
                Colors.indigo.shade400,
                Colors.indigo.shade800,
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                type,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    
  }
}



