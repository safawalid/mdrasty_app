// import 'package:flutter/material.dart';
// import 'package:mdrasty_app/data/modles.dart';
// import 'package:mdrasty_app/data/viewmdles.dart';
// import 'package:mdrasty_app/repository/online_repo.dart';
// import 'package:mdrasty_app/style/appbarchild.dart';
// import 'package:mdrasty_app/constant/fontstyle.dart';
// import 'package:mdrasty_app/style/list.dart';
// import 'package:mdrasty_app/utility/endpoints.dart';
// import 'package:provider/provider.dart';

// class Gradst extends StatefulWidget {
//   const Gradst({Key? key}) : super(key: key);

//   @override
//   State<Gradst> createState() => _GradstState();
// }

// class _GradstState extends State<Gradst> {
//   late List<SubjectGrade> subjectsGrades;
//   late TextEditingController _searchController;
//   bool _isBackPressed = false;

//   @override
//   void initState() {
//     super.initState();
    
//     subjectsGrades = [
//       SubjectGrade('القران الكريم', ['90', '80', '70'], ['الشهر الأول', 'الشهر الثاني', 'الشهر النهائي']),
//       SubjectGrade('الاسلامية', ['85', '75', '65'], ['الشهر الأول', 'الشهر الثاني', 'الشهر النهائي']),
//       SubjectGrade('اللغة العربية', ['95', '85', '75'], ['الشهر الأول', 'الشهر الثاني', 'الشهر النهائي']),
//       SubjectGrade('العلوم', ['90', '80', '70'], ['الشهر الأول', 'الشهر الثاني', 'الشهر النهائي']),
//       SubjectGrade('الرياضيات', ['85', '75', '65'], ['الشهر الأول', 'الشهر الثاني', 'الشهر النهائي']),
//       SubjectGrade('الانجليزي', ['95', '85', '75'], ['الشهر الأول', 'الشهر الثاني', 'الشهر النهائي']),
//     ];
//     _searchController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Color(0xFFF2F6FA),
//         appBar: appbarchild(title: "الدراجات"),
//         body: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Card(
//                       elevation: 9,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 6),
//                               child: TextField(
//                                 controller: _searchController,
//                                 style: fontstyle.fontheading,
//                                 onChanged: (value) {
//                                   setState(() {});
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: 'ابحث...',
//                                   hintStyle: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               setState(() {});
//                             },
//                             icon: Icon(
//                               Icons.search,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: _buildSearchResults(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchResults() {
//     final List<SubjectGrade> searchResults = subjectsGrades.where((subject) {
//       final searchText = _searchController.text.trim();
//       return searchText.isEmpty || subject.subject.contains(searchText);
//     }).toList();
 
//     if (searchResults.isEmpty) {
//       return const Center(
//         child: Text('لا توجد نتائج', style: TextStyle(fontSize: 20)),
//       );
//     }

//     return Consumer<Gradvm>(builder: (context, vm, widget) {
//       return FutureBuilder(
//         future:vm.getgrad(OnlineRepo(), source: API_URL.Grads),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.connectionState != ConnectionState.done) {
//             return const SizedBox(
//               height: 30,
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasData) {
//               List<SubjecGrade> grad =vm.allgrad;
//         return ListView.builder(
//               itemCount:  grad.length,
//               itemBuilder: (context, index) {
//                   SubjecGrade g = grad[index];
//                 return _buildSubjectCard(g);
//               },
//             );
//           }
//           else {
//               return const SizedBox(
//                   height: 30,
//                   child: CircularProgressIndicator(),
//                 );
//               }
//         },

//       );
      

      
//     });
//   }

//   Widget _buildSubjectCard(SubjecGrade SubjecGrade) {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       margin: EdgeInsets.only(bottom: 20),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.blue.shade700,
//                     Colors.blue.shade900,
//                   ],
//                 ),
//               ),
//               child: Center(
//                 child: Text(SubjecGrade.lastName??"", style: fontstyle.fontheading),
//               ),
//             ),
//             SizedBox(height: 10),
//             for (int i = 0; i < ; i++)
//               _buildGradeItem(SubjecGrade.email??"hhhh", SubjecGrade.firstName??""),
//             // print(SubjecGrade.toJson() )
//           ],
          
//         ),
//       ),
//     );
//   }

//   Widget _buildGradeItem(String title, String grade) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: fonttitlestyle.fonttitle,
//           ),
//           Text(grade, style: fonttitlestyle.fonttitle),
//         ],
//       ),
//     );
    
//   }
// }

// // class SubjectGrade {
// //   final String subject;
// //   final List<String> grades;
// //   final List<String> months;

// //   SubjectGrade(this.subject, this.grades, this.months);
// // }
