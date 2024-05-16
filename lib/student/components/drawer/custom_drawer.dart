// import 'package:collasable_drawer/components/drawer/bottom_user_info.dart';
// import 'package:collasable_drawer/components/drawer/header.dart';
// import 'package:collasable_drawer/tabbar/classtab/diary/diary.dart';
// import 'package:collasable_drawer/wedgits/class.dart';
// import 'package:collasable_drawer/tabbar/classtab/grads/subjects.dart';
// import 'package:collasable_drawer/tabbar/classtab/homeworknotification/Homework_tab.dart';
// import 'package:collasable_drawer/tabbar/test.dart';
import 'package:flutter/material.dart';
import 'package:mdrasty_app/student/components/drawer/bottom_user_info.dart';
import 'package:mdrasty_app/student/components/drawer/header.dart';
import 'package:mdrasty_app/student/questions.dart';
import 'package:mdrasty_app/student/viewassigment.dart';
import 'package:mdrasty_app/student/viewnotification.dart';


import 'package:mdrasty_app/teacher/tabbar/classtab/homeworknotification/Homework_tab.dart';
import 'package:page_transition/page_transition.dart';

import 'custom_list_tile.dart';
// import 'drawer/bottom_user_info.dart';
// import 'drawer/header.dart';
// import 'tabbar/classtab/class.dart';
// import 'tabbar/classtab/homeworknotification/Homework_tab.dart';
// import 'tabbar/test.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCollapsed = false;
  int _currentTabIndex = 0;
  int _selectedTabIndex = 0;

  // Add the class names here

  String _selectedClass = 'Class one'; // Default selected class

  void _onTabChanged(int newIndex) {
    setState(() {
      _currentTabIndex = newIndex;
      _selectedTabIndex = newIndex;
    });
  }

  void _resetSelectedTabIndex() {
    setState(() {
      _selectedTabIndex = _currentTabIndex;
    });
  }

  Color activeColor = Colors.blue; // تحديد اللون النشط هنا

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: GestureDetector(
          child: AnimatedContainer(
            curve: Curves.easeInOutCubic,
            duration: const Duration(milliseconds: 500),
            width: _isCollapsed ? 300 : 70,
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: Color.fromRGBO(20, 20, 20, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomDrawerHeader(isColapsed: _isCollapsed),
                  const Divider(
                    color: Colors.grey,
                  ),

                  // CustomListTile(
                  //   isCollapsed: _isCollapsed,
                  //   icon: Icons.school_outlined,
                  //   title: 'الصفوف',
                  //   infoCount: 4,
                  //   doHaveMoreOptions: Icons.arrow_forward_ios,
                  //   onPressed: () {
                  //     _onTabChanged(4);
                  //     Navigator.of(context).push(PageTransition(
                  //       type: PageTransitionType.leftToRight,
                  //       duration: Duration(milliseconds: 600),
                  //       reverseDuration: Duration(microseconds: 600),
                  //       child: teacherclass(),
                  //     ));
                  //   },
                  //   isTabSelected: _selectedTabIndex == 0,
                  //   activeColor: activeColor, // تحديد اللون النشط هنا
                  // ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.ac_unit,
                    title: 'الكتاب',
                    infoCount: 0,
                    onPressed: () {
                      _onTabChanged(0);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: NotificationPage(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 0,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.grading_sharp,
                    title: 'الواجبات',
                    infoCount: 0,
                    onPressed: () {
                      _onTabChanged(1);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: viewassigment(),
                      ));
                    },
                    isTabSelected: _currentTabIndex == 1,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.book_sharp,
                    title: 'الاشعارات',
                    infoCount: 0,
                    doHaveMoreOptions: Icons.arrow_forward_ios,
                    onPressed: () {
                      _onTabChanged(2);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: viewnotification(),
                      ));
                    },
                    isTabSelected: _currentTabIndex == 2,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.note_alt_rounded,
                    title: ' التقييم',
                    infoCount: 8,
                    onPressed: () {
                      _onTabChanged(3);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: NotificationPage(),
                      ));
                    },
                    isTabSelected: _currentTabIndex == 3,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.note,
                    title: 'الشروحات',
                    infoCount: 0,
                    doHaveMoreOptions: Icons.arrow_forward_ios,
                    onPressed: () {
                      _onTabChanged(4);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: NotificationPage(),
                      ));
                    },
                    isTabSelected: _currentTabIndex == 4,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.question_answer,
                    title: 'الاسئله',
                    infoCount: 2,
                    onPressed: () {
                      _onTabChanged(5);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: questions(),
                      ));
                    },
                    isTabSelected: _currentTabIndex == 5,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  BottomUserInfo(isCollapsed: _isCollapsed),
                  Align(
                    alignment: _isCollapsed
                        ? Alignment.bottomLeft
                        : Alignment.bottomCenter,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      icon: Icon(
                        _isCollapsed
                            ? Icons.arrow_back_ios
                            : Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          _isCollapsed = !_isCollapsed;
                          _resetSelectedTabIndex();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
