import 'package:flutter/material.dart';

import 'profile.dart';



class TeacherEvaluation extends StatefulWidget {
  final String teacherName; // إضافة متغير لاستقبال اسم المعلمة

  TeacherEvaluation({required this.teacherName}); // المُنشئ لتمرير اسم المعلمة

  @override
  _TeacherEvaluationState createState() => _TeacherEvaluationState();
}

class _TeacherEvaluationState extends State<TeacherEvaluation> {
  int _styleRating = 0;
  int _performanceRating = 0;
  int _interactionRating = 0;
  String _styleFeedback = '';
  String _performanceFeedback = '';
  String _interactionFeedback = '';

  void _setStyleRating(int rating) {
    setState(() {
      if (_styleRating == rating) {
        _styleRating = 0;
        _styleFeedback = '';
      } else {
        _styleRating = rating;
        _styleFeedback = _getFeedback(rating);
      }
    });
  }

  void _setPerformanceRating(int rating) {
    setState(() {
      if (_performanceRating == rating) {
        _performanceRating = 0;
        _performanceFeedback = '';
      } else {
        _performanceRating = rating;
        _performanceFeedback = _getFeedback(rating);
      }
    });
  }

  void _setInteractionRating(int rating) {
    setState(() {
      if (_interactionRating == rating) {
        _interactionRating = 0;
        _interactionFeedback = '';
      } else {
        _interactionRating = rating;
        _interactionFeedback = _getFeedback(rating);
      }
    });
  }

  String _getFeedback(int rating) {
    switch (rating) {
      case 1:
        return ' مقبول';
      case 2:
        return 'ضعيف';
      case 3:
        return 'جيد';
      case 4:
        return 'جيدجدا';
      case 5:
        return 'ممتاز';
      default:
        return '';
    }
  }

  void _clearRatings() {
    setState(() {
      _styleRating = 0;
      _performanceRating = 0;
      _interactionRating = 0;
      _styleFeedback = '';
      _performanceFeedback = '';
      _interactionFeedback = '';
    });
  }

  void _saveEvaluation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EvaluationResult(
          teacherName: widget.teacherName, 
          styleRating: _styleRating,
          performanceRating: _performanceRating,
          interactionRating: _interactionRating,
          styleFeedback: _styleFeedback,
          performanceFeedback: _performanceFeedback,
          interactionFeedback: _interactionFeedback,
        ),
      ),
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
                                builder: (context) =>   Profileparent(),));
                }
            ),),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: MediaQuery.of(context).size.height * .70,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        widget.teacherName, 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildRatingBar('الاداء التعليمي', _styleRating, _setStyleRating, _styleFeedback),
                  SizedBox(height: 10),
                  _buildRatingBar('التعامل مع الطلاب', _performanceRating, _setPerformanceRating, _performanceFeedback),
                  SizedBox(height: 10),
                  _buildRatingBar('ايصال المقرر', _interactionRating, _setInteractionRating, _interactionFeedback),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _clearRatings,
                        child: Text('الغاء'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _saveEvaluation,
                        child: Text('حفظ'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBar(String label, int rating, void Function(int) onChanged, String feedback) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                feedback.isNotEmpty ? '$feedback' : '',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  int starRating = index + 1;
                  return IconButton(
                    iconSize: 25,
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: index < rating ? Colors.amber : Colors.grey,
                    ),
                    onPressed: () {
                      onChanged(starRating);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EvaluationResult extends StatelessWidget {
  final String teacherName; 

  final int styleRating;
  final int performanceRating;
  final int interactionRating;
  final String styleFeedback;
  final String performanceFeedback;
  final String interactionFeedback;

  EvaluationResult({
    required this.teacherName,
    required this.styleRating,
    required this.performanceRating,
    required this.interactionRating,
    required this.styleFeedback,
    required this.performanceFeedback,
    required this.interactionFeedback,
  });

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
                                builder: (context) =>   Profileparent(),));
                }
            ),),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: MediaQuery.of(context).size.height * .55,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        teacherName, 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildRatingSection('الاداء التعليمي', styleRating, styleFeedback),
                  SizedBox(height: 20),
                  _buildRatingSection('التعامل مع الطلاب', performanceRating, performanceFeedback),
                  SizedBox(height: 20),
                  _buildRatingSection('ايصال المقرر', interactionRating, interactionFeedback),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingSection(String label, int rating, String feedback) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                feedback.isNotEmpty ? '$feedback' : '',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  int starRating = index + 1;
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: index < rating ? Colors.amber : Colors.grey,
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
