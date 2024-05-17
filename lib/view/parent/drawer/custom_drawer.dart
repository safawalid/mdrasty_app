
import 'package:flutter/material.dart';
import 'package:mdrasty_app/view/parent/attendparent.dart';
import 'package:mdrasty_app/view/parent/drawer/bottom_user_info.dart';
import 'package:mdrasty_app/view/parent/drawer/header.dart';
import 'package:mdrasty_app/view/parent/grads.dart';
import 'package:mdrasty_app/view/parent/note.dart';
import 'package:mdrasty_app/view/parent/rating.dart';



import 'package:page_transition/page_transition.dart';


import 'custom_list_tile.dart';

class Drawerparent extends StatefulWidget {
  const Drawerparent({Key? key}) : super(key: key);

  @override
  State<Drawerparent> createState() => _DrawerparentState();
}

class _DrawerparentState extends State<Drawerparent> {
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
                    icon: Icons.menu_book,
                    title: 'التقرير اليومي',
                    infoCount: 0,
                    onPressed: () {
                      _onTabChanged(0);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: notsparent(),
                      ));
                    },
                    isTabSelected: _selectedTabIndex == 0,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.assignment,
                    title: 'الدرجات',
                    infoCount: 0,
                    onPressed: () {
                      _onTabChanged(1);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: gradparent(),
                      ));
                    },
                    isTabSelected: _currentTabIndex == 1,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.check_box,
                    title: 'التحضير',
                    infoCount: 0,
                  
                    onPressed: () {
                      _onTabChanged(2);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: attendparent(),
                      ));
                    },
                    isTabSelected: _currentTabIndex == 2,
                    activeColor: activeColor, // تحديد اللون النشط هنا
                  ),
                
                  CustomListTile(
                    isCollapsed: _isCollapsed,
                    icon: Icons.star,
                    title: 'التقييم ',
                    infoCount: 0,
                  
                    onPressed: () {
                      _onTabChanged(4);
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(microseconds: 600),
                        child: Ratingparent(),
                      ));
                    },
                    isTabSelected: _currentTabIndex == 4,
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
