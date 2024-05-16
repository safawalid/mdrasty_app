import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'profile.dart'; 
class attende extends StatefulWidget {
  @override
  State<attende> createState() => _attendeState();
}

class _attendeState extends State<attende> {
  late List<DateTime> weekDays;
  late int currentIndex;
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
        appBar: AppBar(
        title: Text('مدرستي',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo[900],
        leading:  IconButton(
              icon: Icon(Icons.navigate_next),color: Colors.indigo[900],
                onPressed: () {}
            ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            child: Container(
                            // حاوية الزر السابق
                            decoration: BoxDecoration(
                              color: Colors.white, // لون الزر الأبيض
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
            IconButton(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Icon(Icons.navigate_next,),
              ),color: Colors.indigo[900],
                onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>   Profileparent()));
                }
            ),),
          )
        ],
      ),
      body: Center(
        child: Container(
          height: 180,
          width: 350,
        
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
              
                
                decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
              color: Colors.indigo[900]!,
          ),
              
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //  الزر التالي
                          decoration: BoxDecoration(
                            color: Colors.white, // لون الزر الأبيض
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                  icon: Icon(Icons.navigate_before),
                  onPressed:   moveToNextDay,
                  color: Colors.indigo[900],
                ),
                        ),
                          GestureDetector(
                    onTap: () {
                      showHijriCalendar(context);
                    },
                    child: Text(
                      DateFormat('EEEE, d MMMM yyyy', 'ar').format(weekDays[currentIndex]),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                        Container(
                        
                          decoration: BoxDecoration(
                            color: Colors.white, 
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:  IconButton(
                  icon: Icon(Icons.navigate_next),
                  onPressed:  moveToPreviousDay,
                  color: Colors.indigo[900],
                ),
                        ),
                      ],
                    ),
                  ),
                ),
              
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.grey,),
                        onPressed: () {
                        
                        },
                        child: Text('حاضر'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.grey,),
                        onPressed: () {
                          
                        },
                        child: Text('غائب'),
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

