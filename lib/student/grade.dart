import 'package:flutter/material.dart';

import 'package:mdrasty_app/style/appbar.dart';
import 'package:mdrasty_app/style/appbarchild.dart';
import 'package:mdrasty_app/style/fontstyle.dart';

import 'bottomnav.dart';

class Grads extends StatefulWidget {
  const Grads({Key? key}) : super(key: key);

  @override
  State<Grads> createState() => _GradsState();
}

class _GradsState extends State<Grads> {
  late List<SubjectGrade> subjectsGrades;
  late TextEditingController _searchController;
  bool _isBackPressed = false;

  @override
  void initState() {
    super.initState();
    // Initialize subjects and grades for all buttons
    subjectsGrades = [
      SubjectGrade('القران الكريم', '90', '80', '70'),
      SubjectGrade('الاسلامية', '85', '75', '65'),
      SubjectGrade('اللغة العربية', '95', '85', '75'),
      SubjectGrade('العلوم', '90', '80', '70'),
      SubjectGrade('الرياضيات', '85', '75', '65'),
      SubjectGrade(' الانجليزي', '95', '85', '75'),
    ];
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF2F6FA), 
        appBar: appbarchild(title:"الدرجات"),

        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                     
                      elevation: 9,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: TextField(
                                controller: _searchController,
                                style:fonttitlestyle.fonttitle,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'ابحث...',
                                  hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: _buildSearchResults(),
              ),
            ],
          ),
        ),
        
      ),
    );
  }

  Widget _buildSearchResults() {
    final List<SubjectGrade> searchResults = subjectsGrades.where((subject) {
      final searchText = _searchController.text.trim();
      return searchText.isEmpty ||
          subject.subject.contains(searchText);
    }).toList();

    if (searchResults.isEmpty) {
      return const Center(
        child: Text(
          'لا توجد نتائج',
          style: fontstyle.fontheading
        ),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return _buildSubjectCard(searchResults[index]);
      },
    );
  }

  Widget _buildSubjectCard(SubjectGrade subjectGrade) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
            
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                              
                              
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                                gradient: LinearGradient(
              colors: [
                Colors.indigo.shade400,
                Colors.blue.shade400,
                Colors.indigo.shade800,
              ],
              
            ),),
              child: Center(
                child: Text(
                  subjectGrade.subject,
                  style: fontwhite.fonttitle
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildGradeItem('الشهر الاول', subjectGrade.grade1),
            _buildGradeItem('الشهر الثاني', subjectGrade.grade2),
            _buildGradeItem('النهائي', subjectGrade.grade3),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeItem(String title, String grade) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: fonttitlestyle.fonttitle
          ),
          Text(
            grade,
            style: fonttitlestyle.fonttitle
          ),
        ],
      ),
    );
  }
}

class SubjectGrade {
  final String subject;
  final String grade1;
  final String grade2;
  final String grade3;

  SubjectGrade(
    this.subject,
    this.grade1,
    this.grade2,
    this.grade3,
  );
}

