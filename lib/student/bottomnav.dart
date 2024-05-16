// import 'package:collasable_drawer/tabbar/mnotification/mnotification.dart';
// import 'package:collasable_drawer/tabbar/profile/profile.dart';
// import 'package:collasable_drawer/tabbar/schadule/schadule.dart';
// import 'package:collasable_drawer/tabbar/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mdrasty_app/student/profile.dart';
import 'package:mdrasty_app/student/subjects/class.dart';
import 'package:mdrasty_app/student/tabletime.dart';

// import 'package:mdrasty_app/teacher/wedgits/class.dart';


class TabStudent extends StatefulWidget {
  @override
  TabStudentState createState() =>TabStudentState();
}

class TabStudentState extends State<TabStudent> {
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
        textDirection: TextDirection.rtl,
        child: WillPopScope(
          onWillPop: () async {
            // Navigate to a different screen (e.g., home screen) instead of login screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TabStudent()),
            );
            return false; // Prevent default back navigation
          },
          child: Scaffold(
            // appBar:AppBar(title: Text("notification")),
            
            body: IndexedStack(
              index: currentIndex,
              children: [
                // Page 1 content
                ClassSchedule(),
                terms(),
                Profilestudent()
                // ViewNotification(),
              ],
            ),
            bottomNavigationBar: Container(
              margin: EdgeInsets.all(displayWidth * .05),
              height: displayWidth * .155,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    onTabChange(index); // Call the custom onTabChange method
                    HapticFeedback.lightImpact();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == currentIndex
                            ? displayWidth * .32
                            : displayWidth * .18,
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: index == currentIndex ? displayWidth * .12 : 0,
                          width: index == currentIndex ? displayWidth * .32 : 0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.blue.shade900,
                                Colors.blue.shade600,
                                Colors.blue.shade300,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == currentIndex
                            ? displayWidth * .31
                            : displayWidth * .18,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == currentIndex
                                      ? displayWidth * .13
                                      : 0,
                                ),
                                AnimatedOpacity(
                                  opacity: index == currentIndex ? 1 : 0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Text(
                                    index == currentIndex
                                        ? '${listOfStrings[index]}'
                                        : '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == currentIndex
                                      ? displayWidth * .03
                                      : 20,
                                ),
                                Icon(
                                  listOfIcons[index],
                                  size: displayWidth * .076,
                                  color: index == currentIndex
                                      ? Colors.white
                                      : Colors.black26,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.person,
    Icons.schedule_outlined,
    Icons.class_,
    Icons.notifications,
  ];

  List<String> listOfStrings = [
    ' حسابي',
    'جدولي',
    'الفصول',
    'الاشعارات',
  ];
}
