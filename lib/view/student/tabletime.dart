// قم بتحسين عرض المواد والحصص باستخدام ListTile
// استخدم ListView لعرض الأيام بشكل أفضل
import 'package:flutter/material.dart';
import 'package:mdrasty_app/constant/appbar.dart';

import 'package:mdrasty_app/style/fontstyle.dart';
import 'package:mdrasty_app/style/list.dart';
import 'package:mdrasty_app/constant/fontstyle.dart';

class ClassSchedule extends StatefulWidget {
  @override
  _ClassScheduleState createState() => _ClassScheduleState();
}

class _ClassScheduleState extends State<ClassSchedule> {
  int _currentDayIndex = 0; // يمثل اليوم الأول (الأحد) كافتراضيًا

  

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: "مدرستي",),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigo.shade400,
                      Colors.blue.shade400,
                      Colors.indigo.shade800,
                    ],
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (_currentDayIndex > 0) {
                                    _currentDayIndex--;
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_back_ios),
                              color: Colors.blue.shade900,
                            ),
                            Text(
                              days[_currentDayIndex],
                              style: fontstyle.fontheading,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (_currentDayIndex < days.length - 1) {
                                    _currentDayIndex++;
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_forward_ios),
                              color: Colors.blue.shade900,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          
                          children: [
                            // List of subjects using ListTile for better organization
                            ...dayToSubjects[days[_currentDayIndex]]!.map(
                              (subject) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                    subject,
                                    style: fonttitlestyle.fonttitle,
                                  ),
                                  trailing: Text(
                                    _getSessionNumber(
                                      dayToSubjects[days[_currentDayIndex]]!.indexOf(subject) + 1,
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo.shade900,
                                    ),
                                  ),
                                  tileColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.grey.shade400),
                                  ),
                                  
                            
                                  
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
          ],
        ),
        
      ),
    );
  }

  String _getSessionNumber(int sessionIndex) {
    List<String> sessionNames = [
      'الأولى',
      'الثانية',
      'الثالثة',
      'الرابعة',
      'الخامسة',
      'السادسة',
      'السابعة'
    ];
    if (sessionIndex >= 1 && sessionIndex <= sessionNames.length) {
      return 'الحصة ${sessionNames[sessionIndex - 1]}';
    }
    return '';
  }
}
