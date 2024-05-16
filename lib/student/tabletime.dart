import 'package:flutter/material.dart';
import 'package:mdrasty_app/student/components/drawer/custom_drawer.dart';
import 'package:mdrasty_app/style/appbar.dart';
import 'package:mdrasty_app/style/fontstyle.dart';

class ClassSchedule extends StatefulWidget {
  @override
  _ClassScheduleState createState() => _ClassScheduleState();
}

class _ClassScheduleState extends State<ClassSchedule> {
  int _currentDayIndex = 0; // يمثل اليوم الأول (الأحد) كافتراضيًا

  final List<String> days = [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس'
  ];

  final Map<String, List<String>> dayToSubjects = {
    'الأحد': ['رياضيات', 'علوم', 'لغة عربية', 'تاريخ', 'جغرافيا', 'فيزياء','قران'],
    'الاثنين': ['تاريخ', 'جغرافيا', 'فيزياء'],
    'الثلاثاء': ['علوم', 'لغة عربية', 'كيمياء'],
    'الأربعاء': ['رياضيات', 'تاريخ', 'فيزياء'],
    'الخميس': ['جغرافيا', 'لغة عربية', 'كيمياء'],
  };

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: " مدرستي",),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            // Row for navigation buttons
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Back button
                  Container(
                      decoration: BoxDecoration(
                              gradient: LinearGradient(
              colors: [
                Colors.indigo.shade400,
                Colors.blue.shade400,
                Colors.indigo.shade800,
              ],
            ),
                              shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              
                            ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (_currentDayIndex > 0) {
                            _currentDayIndex--;
                          }
                        });
                      },
                      icon: Icon(Icons.navigate_before,color: Colors.white),
                    ),
                  ),
                
                  Text(
                    days[_currentDayIndex],
                    style: fontstyle.fontheading
                  ),
                  // Forward button
                  Container(
                      decoration: BoxDecoration(
                                gradient: LinearGradient(
              colors: [
                Colors.indigo.shade400,
                Colors.blue.shade400,
                Colors.indigo.shade800,
              ],
            ),
                              shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            
                            ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (_currentDayIndex < days.length - 1) {
                            _currentDayIndex++;
                          }
                        });
                      },
                    icon: Icon(Icons.navigate_next,color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            // Day's schedule inside a Card
            Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
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
                                borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),),
                  child: Card(
                    elevation: 6, // تغيير ارتفاع الظل ليكون أكثر بروزًا
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // List of subjects using ListTile for better organization
                          ...dayToSubjects[days[_currentDayIndex]]!.map(
                            (subject) => Container(  decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade400),
        ),   
        padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                              child: 
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  
                                  children: [ Text(
                                  subject,
                                  style:fonttitlestyle.fonttitle
                                ),
                                 Text(
                                  _getSessionNumber(
                                    dayToSubjects[days[_currentDayIndex]]!.indexOf(subject) + 1,
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo.shade900,
                                  ),)],)
                                
                              ),
                            ),
                          
                        ],
                      ),
                    ),
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


