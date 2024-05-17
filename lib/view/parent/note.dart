import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mdrasty_app/constant/appbarchild.dart';


import 'package:mdrasty_app/constant/fontstyle.dart';
import 'package:mdrasty_app/view/parent/drawer/custom_drawer.dart';

class notsparent extends StatefulWidget {
  @override
  _notsparentState createState() => _notsparentState();
}

class _notsparentState extends State<notsparent> {
  late List<DateTime> weekDays;
  late int currentIndex;

  final List<Map<String, String>> subjects = [
    {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
    {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
      {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
      {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
    {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
    {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
      {'name': 'القران الكريم', 'lesson': 'سورة العلق'},
  ];

  List<Map<String, String>> filteredSubjects = [];

  @override
  void initState() {
    super.initState();
    weekDays = generateWeekDays();
    currentIndex = DateTime.now().weekday - 1;
  }

  List<DateTime> generateWeekDays() {
    DateTime now = DateTime.now();
    int todayIndex = now.weekday;
    List<DateTime> days = [];

    for (int i = 1; i <= 7; i++) {
      days.add(now.subtract(Duration(days: todayIndex - i)));
    }

    return days;
  }

  void moveToNextDay() {
    if (currentIndex < 6) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void moveToPreviousDay() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  appbarchild(title: "التقييم"),
        endDrawer: Drawerparent(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          
              height: MediaQuery.of(context).size.height * .74,
                decoration: BoxDecoration(
                            gradient: LinearGradient(
            colors: [
            Colors.blue.shade900, Colors.blue.shade700,
                                            Colors.blue.shade700, Colors.blue.shade900
            ],
          ),
                            shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(Radius.circular(10))
                            
                          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: moveToNextDay,
                      icon: Icon(Icons.arrow_back_ios,
                      color: Colors.white,),
                    ),
                    Text(
                      DateFormat('EEEE, d MMMM yyyy', 'ar').format(weekDays[currentIndex]),
                      style: fontwhite.fonttitle
                    ),
                    IconButton(
                      onPressed: moveToPreviousDay,
                      icon: Icon(Icons.arrow_forward_ios,
                      color: Colors.white,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      final subject = subjects[index];
                      final subjectName = subject['name']!;
                      final lessonName = subject['lesson']!;
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          title: Align(alignment: Alignment.topRight,
                            child: Text(
                              subjectName,
                              style: fontstyle.fontheading,
                              
                            ),
                          ),
                          subtitle: Align(alignment: Alignment.topRight,
                            child: Text(
                              lessonName,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
