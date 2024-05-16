import 'package:flutter/material.dart';
import 'package:mdrasty_app/style/fontstyle.dart';

class appbarchild extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const appbarchild({Key? key, required this.title}) : super(key: key);

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
          style: fontappbar.fonttitle,
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
      
      
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
