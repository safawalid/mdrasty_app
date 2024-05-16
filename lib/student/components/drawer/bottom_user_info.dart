// import 'package:collasable_drawer/class/tclass.dart';
// import 'package:collasable_drawer/wedgits/class.dart';
import 'package:flutter/material.dart';
import 'package:mdrasty_app/student/subjects/class.dart';
import 'package:mdrasty_app/teacher/class/tclass.dart';
// import 'package:mdrasty_app/teacher/class/tclass.dart';
// import 'package:mdrasty_app/student/wedgits/class.dart';
// import 'package:mdrasty_app/teacher/wedgits/class.dart';

class BottomUserInfo extends StatefulWidget {
 
  final bool isCollapsed;
  

  BottomUserInfo({
    Key? key,
    required this.isCollapsed,
  }) : super(key: key);

  @override
  State<BottomUserInfo> createState() => _BottomUserInfoState();
}

class _BottomUserInfoState extends State<BottomUserInfo> {
  String selectedClassName = '';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child:
                 ClassButtonGrid(teacherClasses,
                ),
              );
            },
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: widget.isCollapsed ? 70 : 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.school, // Use school icon for class
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
                if (widget.isCollapsed) // Show only if not collapsed
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Class', // Replace with your class name
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
