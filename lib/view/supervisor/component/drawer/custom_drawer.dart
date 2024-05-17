
import 'package:flutter/material.dart';
import 'package:mdrasty_app/view/supervisor/component/drawer/bottom_user_info.dart';
import 'package:mdrasty_app/view/supervisor/component/drawer/header.dart';
import 'package:mdrasty_app/view/supervisor/descution.dart';
import 'package:mdrasty_app/view/supervisor/tabs/subjects.dart';
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

                  
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.ac_unit,
                    title: 'الأشعارات',
                    infoCount: 0,
                    onPressed: () {
                      _onTabChanged(0);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: descution(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 0,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.grading_sharp,
                    title: 'الدرجات',
                    infoCount: 0,
                    onPressed: () {
                      _onTabChanged(1);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: Dashboard(),
                      ));
                    },
                    isTabSelected: _currentTabIndex == 1,
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
                        child: Dashboard()
                      ));
                    },
                    isTabSelected: _currentTabIndex == 5,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.event_sharp,
                    title: 'التقيم',
                    infoCount: 0,
                    onPressed: () {
                      _onTabChanged(6);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: Dashboard(),
                      ));
                    },
                    isTabSelected: _currentTabIndex == 6,
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
