import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mdrasty_app/constant/appbar.dart';
import 'package:mdrasty_app/constant/searchbar.dart';
import 'package:mdrasty_app/view/teacher/components/drawer/custom_drawer.dart';
import 'package:mdrasty_app/constant/fontstyle.dart';

class StudentMarksPage extends StatefulWidget {
  @override
  _StudentMarksPageState createState() => _StudentMarksPageState();
}

class _StudentMarksPageState extends State<StudentMarksPage> {
  late Future<List<Student>> futureStudents;
  TextEditingController searchController = TextEditingController();
  late List<Student> originalStudents;
  List<Student> filteredStudents = [];
  bool showNoResults = false;

  @override
  void initState() {
    super.initState();
    futureStudents = fetchStudents();
  }

  Future<List<Student>> fetchStudents() async {
    final response = await http.get(
        Uri.parse('https://my.api.mockaroo.com/students_marks?key=7bf0ba50'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Student> students =
          jsonData.map((e) => Student.fromJson(e)).toList();
      setState(() {
        originalStudents = students;
        filteredStudents = List.from(originalStudents);
      });
      return students;
    } else {
      throw Exception('Failed to load students');
    }
  }

  void _searchStudents(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredStudents = List.from(originalStudents);
        showNoResults = false;
      } else {
        filteredStudents = originalStudents
            .where((student) =>
                student.firstName.toLowerCase().contains(value.toLowerCase()) ||
                student.lastName.toLowerCase().contains(value.toLowerCase()))
            .toList();
        showNoResults = filteredStudents.isEmpty;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: 'درجات الطلاب',
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            SearchBar(
              controller: searchController,
              onChanged: _searchStudents,
              noResults: showNoResults,
            ),
            Expanded(
              child: FutureBuilder<List<Student>>(
                future: futureStudents,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = filteredStudents[index];

                        return Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    '${student.firstName} ${student.lastName}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text(
                                      ': ختبار الشهر الاول ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'ادخل الدرجه',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      ': ختبار الشهر الثاني ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'ادخل الدرجه',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      ': الامتحان الفصلي',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'ادخل الدرجه',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('لا توجد بيانات'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Student {
  late int id;
  late String firstName;
  late String lastName;
  late double month1;
  late double month2;
  late double finalExam;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.month1,
    required this.month2,
    required this.finalExam,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      month1: json['month1'],
      month2: json['month2'],
      finalExam: json['final'],
    );
  }
}
