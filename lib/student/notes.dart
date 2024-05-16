import 'package:flutter/material.dart';
import 'package:mdrasty_app/style/appbarchild.dart';
import 'package:mdrasty_app/style/fontstyle.dart';
import 'package:intl/intl.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
 // استيراد حزمة flutter_datetime_picker
class notes extends StatefulWidget {
  @override
  _notesState createState() => _notesState();
}

class _notesState extends State<notes> {
  late List<DateTime> weekDays;
  late int currentIndex;

  final List<Map<String, String>> subjects = [
    {'name': 'القران الكريم', 'lesson': 'سورة العلق والملك والفاتحه والناس والكوثروالفلق'},
    {'name': 'Science', 'lesson': 'العلق والملك والفاتحه'},
    {'name': 'History', 'lesson': 'World War II'},
    {'name': 'English', 'lesson': 'Grammar'},
    {'name': 'Computer Science', 'lesson': 'Programming'},
    {'name': 'Art', 'lesson': 'Painting'},
    {'name': 'Physical Education', 'lesson': 'Sports'},
  ];

  List<Map<String, String>> filteredSubjects = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    weekDays = generateWeekDays();
    currentIndex = DateTime.now().weekday - 1;
    // filteredSubjects = subjects;
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

  // void filterSubjects(String query) {
  //   List<Map<String, String>> filteredList = [];
  //   if (query.isNotEmpty) {
  //     filteredList = subjects.where((subject) {
  //       final subjectName = subject['name'] ?? '';
  //       final lessonName = subject['lesson'] ?? '';
  //       return subjectName.contains(query) || lessonName.contains(query);
  //     }).toList();
  //   } else {
  //     filteredList = subjects;
  //   }
  //   setState(() {
  //     filteredSubjects = filteredList;
  //   });
  // }

  Future<void> showHijriCalendar(BuildContext context) async {
    final selectedDate = await DatePicker.showDatePicker(
      context,
      locale: LocaleType.ar, // تحديد اللغة كعربي
      currentTime: weekDays[currentIndex],
      onConfirm: (date) {
        if (date != null && date != weekDays[currentIndex]) {
          setState(() {
            weekDays[currentIndex] = date;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarchild(title:"تقرير يومي"),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                              
                              
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            
                            ),
              child: IconButton(
                icon: Icon(Icons.navigate_before),
                onPressed:   moveToNextDay,
                color: Colors.white,
              ),
            ),
                GestureDetector(
                  onTap: () {
                    showHijriCalendar(context);
                  },
                  child: Text(
                    DateFormat('EEEE, d MMMM yyyy', 'ar').format(weekDays[currentIndex]),
                    style: fontstyle.fontheading,
                    textAlign: TextAlign.center,
                  ),
                ),
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
                icon: Icon(Icons.navigate_next),
                onPressed:  moveToPreviousDay,
                color: Colors.white,
              ),
            ),

              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                final subjectName = subject['name']!;
                final lessonName = subject['lesson']!;
                return SubjectListItem(
                  subjectName: subjectName,
                  lessonName: lessonName,
                );
              },
            ),
          ),
        ],
      ),
    
    );
  }
}

class SubjectListItem extends StatefulWidget {
  final String subjectName;
  final String lessonName;

  SubjectListItem({
    required this.subjectName,
    required this.lessonName,
  });

  @override
  _SubjectListItemState createState() => _SubjectListItemState();
}

class _SubjectListItemState extends State<SubjectListItem> {
  bool isCardHighlighted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isCardHighlighted = !isCardHighlighted;
          });
        },
        child: Card(
          elevation: 5,
          // color: Colors.indigo[500],
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
          ),
          
          child: ExpansionTile(
            title: Center(
              child: Text(
                widget.subjectName,
                style:fontstyle.fontheading
              ),
            ),
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.lessonName,
                    style:fonttitlestyle.fonttitle
                  ),
                ),
              ),
            ],
            tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            collapsedTextColor: Colors.black,
            collapsedIconColor: Colors.red[900],
            textColor: Colors.indigo[900],
            iconColor: Colors.indigo[900],
          ),
        ),
      ),
    );
  }
}
