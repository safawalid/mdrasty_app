// // import 'package:collasable_drawer/class/tclass.dart';
// // import 'package:collasable_drawer/screens/home/drawer.dart';
// // import 'package:collasable_drawer/tabbar/classtab/homeworknotification/Homework_tab.dart';
// import 'package:flutter/material.dart';
// import 'package:mdrasty_app/student/subjects/subjects.dart';
// import 'package:mdrasty_app/teacher/class/tclass.dart';
// import 'package:mdrasty_app/teacher/tabbar/classtab/grads/subjects.dart';
// import 'package:mdrasty_app/teacher/tabbar/classtab/homeworknotification/Homework_tab.dart';
// import 'package:mdrasty_app/teacher/wedgits/buttoncolor.dart';
// import 'package:page_transition/page_transition.dart';

// // import 'buttoncolor.dart';
// // import '../tabbar/test.dart';

// void main() {
//   runApp(terms());
// }

// class terms extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Teacher Classes',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Teacher Classes')),
//         body: ClassButtonGrid(teacherClasses),
//       ),
//     );
//   }
// }

// class ClassButtonGrid extends StatelessWidget {
//   final List<TeacherClass> teacherClasses;

//   ClassButtonGrid(this.teacherClasses);

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1,
//         childAspectRatio: 3, // Adjust this value to control button height
//       ),
//       itemCount: teacherClasses.length,
//       itemBuilder: (context, index) {
//         final teacherClass = teacherClasses[index];
//         return Padding(
//           padding: const EdgeInsets.all(10.0), // Added horizontal padding
//           child: CustomGradientButton(
//             buttonText: teacherClass.className,
//             onPressed: () {
//               Navigator.pop(context, teacherClass.className); // Pass class name back to caller
//             },
//           ),
//         );
//       },
//     );
//   }
// }
// import 'package:collasable_drawer/class/tclass.dart';
// import 'package:collasable_drawer/screens/home/drawer.dart';
// import 'package:collasable_drawer/tabbar/classtab/homeworknotification/Homework_tab.dart';
import 'package:flutter/material.dart';
import 'package:mdrasty_app/student/subjects/subjects.dart';
import 'package:mdrasty_app/teacher/class/tclass.dart';
import 'package:mdrasty_app/teacher/tabbar/classtab/grads/subjects.dart';
import 'package:mdrasty_app/teacher/tabbar/classtab/homeworknotification/Homework_tab.dart';
import 'package:mdrasty_app/teacher/wedgits/buttoncolor.dart';
import 'package:page_transition/page_transition.dart';

// import 'buttoncolor.dart';
// import '../tabbar/test.dart';

void main() {
  runApp(terms());
}

class terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teacher Classes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Teacher Classes')),
        body: ClassButtonGrid(teacherClasses),
      ),
    );
  }
}

class ClassButtonGrid extends StatelessWidget {
  final List<TeacherClass> teacherClasses;

  ClassButtonGrid(this.teacherClasses);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3, // Adjust this value to control button height
      ),
      itemCount: teacherClasses.length,
      itemBuilder: (context, index) {
        final teacherClass = teacherClasses[index];
        return Padding(
          padding: const EdgeInsets.all(10.0), // Added horizontal padding

          child: CustomGradientButton(
            buttonText: teacherClass.className,
            onPressed: () {
              Navigator.of(context).push(PageTransition(
                type: PageTransitionType.leftToRight,
                childCurrent: this,
                duration: Duration(milliseconds: 600),
                reverseDuration: Duration(microseconds: 600),
                child: subject(),
              ));
            },
          ),
        );
      },
    );
  }
}
