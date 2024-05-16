import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdrasty_app/manager/attendmanager.dart';
import 'package:mdrasty_app/student/bottomnav.dart';

class SubjectGrade {
  final String subject;
  final String grade;

  SubjectGrade(
    this.subject,
    this.grade,
  );
}

final List<SubjectGrade> grades = [
  SubjectGrade('القران الكريم', "50/50"),
  SubjectGrade('التربية الاسلامية', "50/50"),
  SubjectGrade('القران الكريم', "50/50"),
  SubjectGrade('التربية الاسلامية', "50/50"),
  SubjectGrade('القران الكريم', "50/50"),
];

class Subjectdary {
  final String subject;
  final String title;

  Subjectdary(
    this.subject,
    this.title,
  );

  contains(String query) {}
}

final List<Subjectdary> dary = [
  Subjectdary('القران الكريم', "سورة العلق"),
  Subjectdary('التربية الاسلامية', "الصلاة"),
  Subjectdary('القران الكريم', "سورة الفلق"),
  Subjectdary('التربية الاسلامية', "الوضوء"),
  Subjectdary('القران الكريم', "سورة العلق"),
  Subjectdary('التربية الاسلامية', "الوضوء"),
  Subjectdary('القران الكريم', "سورة العلق"),
  Subjectdary('القران الكريم', "سورة العلق"),
];

class subject {
  final String name;
  final String image;

  subject({
    required this.name,
    required this.image,
  });
}

final List<subject> subj = [
  subject(
    name: 'القران الكريم',
    image: "images/2.jpg",
  ),
  subject(
    name: 'التربية الاسلامية ',
    image: "images/3.jpg",
  ),
  subject(
    name: 'اللغة العربية ',
    image: "images/1.jpg",
  ),
  subject(
    name: 'العلوم ',
    image: "images/4.jpg",
  ),
];

// final Map<String, String> imagesToPages = {
//   'images/2.jpg': 'grads',
//   'images/3.jpg': 'evaluation',
//   "images/1.jpg": 'daryy',
//   "images/4.jpg": 'Profile',
// };
// Widget getWidgetForImage(String image) {
//   switch (image) {
//     case 'images/2.jpg':
//       return WeekCard();

//     case 'images/3.jpg':
//       return WeekCard();
//     case 'images/1.jpg':
//       return WeekCard();
//     case 'images/4.jpg':
//       return WeekCard();
//   }
//   throw Exception('Invalid image name: $image');
// }

class star {
  final String title;
  late int starRating;
  late String ratingText;

  star({
    required this.title,
    required this.starRating,
    required this.ratingText,
  });
}

final List<star> stars = [
  star(title: " الاداء التعليمي", starRating: 0, ratingText: ""),
  star(title: "ايصال المقرر", starRating: 0, ratingText: ""),
  star(title: "التعامل مع الطلاب", starRating: 0, ratingText: ""),
];

class childrens {
  final String name;
  childrens({required this.name});
}

List<childrens> child = [
  childrens(name: "غلا"),
  childrens(name: "حلا"),
  childrens(name: "عبدالله"),
  childrens(name: "اسامه"),
  childrens(name: "مجاهد"),
  childrens(name: "عنود"),
];
final Map<String, String> nameToPage = {
  'غلا': 'TabStudent',
  'حلا': 'evaluation',
  "عبدالله": 'daryy',
  'اسامه': 'grads',
  'مجاهد': 'evaluation',
  "عنود": 'profilep',
}; 

Widget getWidgetForPage(String pageName) {
  switch (pageName) {
    // case 'TabStudent':
    //   return TabStudent(); // Replace with the actual page widget

    // case 'evaluation':
    //   return WeekCard(); // Replace with the actual page widget

    // case 'daryy':
    //   return WeekCard();
    case 'grads':
      return attendmanager(); // Replace with the actual page widget

    case 'evaluation':
      return attendmanager(); // Replace with the actual page widget

    case 'profilep':
      return attendmanager();

    default:
      throw Exception('Invalid page name: $pageName');
  }
}

class notivication {
  final String name;
  final String titile;
  final String content;
  final String data;
  
  notivication({required this.titile, required this.content,required this.name,required this.data});
}

List<notivication> noti = [
  notivication(titile: "حفلة الاوائل", content: "غدا ستقيم المدرسة حفلة تدشين تكريم الاوائل",name: 'غلا بن بشر',data: "2/2/2024"),
  notivication(titile: "jjjjjjjjj", content: "hhhhhhhhhhhhhhhhh",name: 'غلا بن بشر',data: "2/2/2024"),
];
class assigment {
  final String name;
  final String titile;
  final String content;
  final String data;
  final String data2;
  final String grde;
  
  assigment({required this.titile, required this.content,required this.name,required this.data,required this.data2,required this.grde});
}

List<assigment> assig = [
  assigment(titile: "  درس الصلاة", content: " كم عدد الصلوات؟",name: 'غلا بن بشر',data: "2/2/2024",data2: "2/3/2024",grde: "10/10"),
  assigment(titile: "درس الوضوء", content: "عرف الوضوء؟",name: 'غلا بن بشر',data: "2/2/2024",data2: "2/3/2024",grde: "20/20"),
];

