// import 'package:flutter/material.dart';
// import 'package:mdrasty_app/style/appbarchild.dart';
// import 'package:mdrasty_app/style/buttonicon.dart';
// import 'package:mdrasty_app/style/buttons.dart';
// import 'package:mdrasty_app/style/fontstyle.dart';

// class BooksGridView extends StatelessWidget {
//   final String type;

//   const BooksGridView({required this.type});

//   // Define a nested map to store book titles along with their image paths for each type
//   static const Map<String, Map<String, String>> booksData = {
//     'روايات': {
//       'رائعة الروايات 1': 'images/1.jpg',
//       'قصص مثيرة': 'images/2.jpg',
//       'حكايات شعبية': 'images/3.jpg',
//         'كتاب العلوم 1': 'images/4.jpg',
//           'تاريخ العالم': 'images/3.jpg',
//       'تاريخ الثورات': 'images/4.jpg',
//       'تاريخ الشرق الأوسط': 'images/4.jpg',
//       'علم الفلك': 'images/5.jpg',
//       'البيولوجيا المتقدمة': 'images/2.jpg',
//     },
//     'علوم': {
//       'كتاب العلوم 1': 'images/4.jpg',
//       'علم الفلك': 'images/3.jpg',
//       'البيولوجيا المتقدمة': 'images/4.jpg',
//         'تاريخ العالم': 'images/3.jpg',
//       'تاريخ الثورات': 'images/1.jpg',
//       'تاريخ الشرق الأوسط': 'images/4.jpg',
//       'رائعة الروايات 1': 'images/3.jpg',
//       'قصص مثيرة': 'images/2.jpg',
//       'حكايات شعبية': 'images/3.jpg',
//     },
//     'تاريخ': {
//       'تاريخ العالم': 'images/3.jpg',
//       'تاريخ الثورات': 'images/5.jpg',
//       'تاريخ الشرق الأوسط': 'images/4.jpg',
//         'رائعة الروايات 1': 'images/1.jpg',
//       'قصص مثيرة': 'images/2.jpg',
//       'حكايات شعبية': 'images/3.jpg',
//     },
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: appbarchild(title: "كتب $type"),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 15.0,
//               mainAxisSpacing: 15.0,
//             ),
//             itemCount: _getBookCount(),
//             itemBuilder: (context, index) {
//               return buildBookCard(context, index);
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   int _getBookCount() {
//     // Determine the number of books based on the type
//     return booksData[type]?.length ?? 0;
//   }

//   Widget buildBookCard(BuildContext context, int index) {
//     // Retrieve the book title and image path based on the type and index
//     String bookTitle = booksData[type]?.keys.elementAt(index) ?? '';
//     String bookImage =
//         booksData[type]?.values.elementAt(index) ?? 'images/default.jpg';

//     return Card(
//       elevation: 10,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Stack(
//           children: [
//             InkWell(
//               onTap: () {
//                 print("abeeer");
//               },
//               child: Image.asset(
//                 bookImage,
//                 height: 150,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 padding:const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade900.withOpacity(0.6),
//                   borderRadius:const BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Text(
//               bookTitle  , // You can replace this with the actual book title
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
