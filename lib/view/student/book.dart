// // import 'package:flutter/material.dart';
// // import 'package:mdrasty_app/student/components/drawer/custom_drawer.dart';
// // import 'package:mdrasty_app/style/appbar.dart';
// // class books extends StatelessWidget {
// //   const books({ Key? key }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Directionality(textDirection: TextDirection.rtl,
// //       child: Scaffold(appBar: CustomAppBar(title: "مدرستي",),
// //       drawer: CustomDrawer(),),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:mdrasty_app/PdfViewerScreen.dart';


// class YourPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('صفحتك'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => PDFViewerScreen(pdfPath: "img/s.pdf"),
//   ),
// );

//           },
//           child: Text('اقرأ الملف'),
//         ),
//       ),
//     );
//   }
// }


// // class PdfScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('عرض PDF'),
// //       ),
// //       body: PDF().cachedFromUrl(
// //         'img/s.pdf', // استبدل هذا برابط ملف PDF
// //         placeholder: (progress) => Center(child: CircularProgressIndicator()),
// //         errorWidget: (error) => Center(child: Text('حدث خطأ أثناء تحميل الملف')),
// //       ),
// //     );
// //   }
// // }

// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:mdrasty_app/style/appbar.dart';
// import 'package:mdrasty_app/style/fontstyle.dart';
// import 'package:page_transition/page_transition.dart';

// import 'components/drawer/custom_drawer.dart';
// class NotificationPage extends StatefulWidget {
//   @override
//   _NotificationPageState createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage> {
//   List<Map<String, dynamic>> notifications = [];
//   String _searchText = '';
//     TextEditingController _searchController = TextEditingController();

//   void _addNotification(Map<String, dynamic> notification) {
//     setState(() {
//       notifications.add(notification);
//     });
//   }

//   void _editNotification(int index, Map<String, dynamic> newNotification) {
//     setState(() {
//       notifications[index] = newNotification;
//     });
//   }

//   void _deleteNotification(int index) {
//     setState(() {
//       notifications.removeAt(index);
//     });
//   }

//   void _showAddNotificationDialog(
//       {Map<String, dynamic>? notification, int? index}) {
//     showModalBottomSheet<void>(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(18),
//       ),
//       builder: (BuildContext context) {
//         return AddNotificationDialog(
//           onSubmit: (notificationData) {
//             if (index == null) {
//               _addNotification(notificationData);
//             } else {
//               _editNotification(index, notificationData);
//             }
//           },
//           notification: notification,
//         );
//       },
//     );
//   }

//   @override
// @override
// Widget build(BuildContext context) {
//   bool isPressed;
//   List<Map<String, dynamic>> filteredNotifications = notifications.where((notification) => notification['title'].contains(_searchText)).toList();
  
//   return Scaffold(
//     appBar: CustomAppBar(title: 'واجبات'),
//     endDrawer: const CustomDrawer(),
//     body: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Card(
//             elevation: 4,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(13.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: TextFormField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search by title',
//                   border: InputBorder.none,
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.clear),
//                     onPressed: () {
//                       _searchController.clear();
//                       // Add any logic here to reset the search results
//                     },
//                   ),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _searchText = value;
//                     // Add logic here to filter the notifications based on the search text
//                   });
//                 },
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: filteredNotifications.isEmpty
//               ? Center(
//                   child: Text(
//                     'لا توجد نتائج',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 )
//               : ListView.builder(
//                   itemCount: filteredNotifications.length,
//                   itemBuilder: (context, index) {
//                     var notification = filteredNotifications[index];
//                     bool isPressed = false;
//                     return Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Material(
//                         elevation: 4,
//                         borderRadius: BorderRadius.circular(13.0),
//                         child: Column(
//                           children: [
//                             ListTile(
//                               leading: const CircleAvatar(
//                                 backgroundImage: AssetImage("img/biology.jpg"),
//                               ),
//                               title: Text(
//                                 ("الاسم هنا"),
//                                 style: fonttitlestyle.fonttitle,
//                               ),
//                               trailing: PopupMenuButton<String>(
//                                 onSelected: (value) {
//                                   if (value == 'edit') {
//                                     _showAddNotificationDialog(
//                                       notification: notification,
//                                       index: index,
//                                     );
//                                   } else if (value == 'delete') {
//                                     _deleteNotification(index);
//                                   }
//                                 },
//                                 itemBuilder: (context) => [
//                                   PopupMenuItem<String>(
//                                     value: 'edit',
//                                     child: Text('Edit'),
//                                   ),
//                                   PopupMenuItem<String>(
//                                     value: 'delete',
//                                     child: Text('Delete'),
//                                   ),
//                                 ],
//                               ),
//                               subtitle: Text(
//                                 DateFormat('HH:mm dd/MM/yyyy ')
//                                     .format(notification['timestamp']),
//                                 style: TextStyle(fontSize: 12),
//                               ),
//                             ),
//                             Card(
//                               elevation: 0,
//                               color: Colors.transparent,
//                               child: Column(
//                                 children: [
//                                   const SizedBox(height: 10),
//                                   Column(
//                                     children: [
//                                       Align(
//                                         alignment: Alignment.center,
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               notification['title'],
//                                               style: const TextStyle(
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             Divider(height: 10, thickness: 2),
//                                             Text(
//                                               notification['content'],
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             SizedBox(height: 40),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//         ),
//       ],
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: () => _showAddNotificationDialog(),
//       tooltip: 'Add Notification',
//       child: Icon(Icons.add),
//       backgroundColor: Colors.blue.shade900,
//     ),
//   );
// }



// }

// class AddNotificationDialog extends StatefulWidget {
//   final Function(Map<String, dynamic>) onSubmit;
//   final Map<String, dynamic>? notification;

//   AddNotificationDialog({required this.onSubmit, this.notification});

//   @override
//   _AddNotificationDialogState createState() => _AddNotificationDialogState();
// }

// class _AddNotificationDialogState extends State<AddNotificationDialog> {
//   final _titleController = TextEditingController();
//   final _contentController = TextEditingController();
//   String _searchText = '';
//     TextEditingController _searchController = TextEditingController();

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.notification != null) {
//       _titleController.text = widget.notification!['title'];
//       _contentController.text = widget.notification!['content'];
    
//     }
//   }

//   void _submit() {
//     final notificationData = {
//       'title': _titleController.text,
//       'content': _contentController.text,
    
//       'timestamp': DateTime.now(),
      
//     };
//     widget.onSubmit(notificationData);
//     Navigator.of(context).pop();
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(30),
//       height: MediaQuery.of(context).size.height * 0.75,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16), color: Colors.white),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: Text(
//               widget.notification == null ? 'واجب جديد' : 'تعديل الواجب',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black),
//             ),
//           ),
//           Expanded(
//             child: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Divider(
//                       thickness: 1.2,
//                       color: Colors.grey.shade200,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Text(
//                       "title",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black),
//                     ),
//                     const SizedBox(
//                       height: 6,
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: TextFormField(
//                         controller: _titleController,
//                         decoration: InputDecoration(
//                           enabledBorder: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           hintText: "Title",
//                         ),
//                         maxLines: 1,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a title';
//                           }
//                           return null; // Input is valid
//                         },
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Text(
//                       "Description",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black),
//                     ),
//                     const SizedBox(
//                       height: 6,
//                     ),
//                     Container(
//                         padding: EdgeInsets.symmetric(horizontal: 20),
//                         decoration: BoxDecoration(
//                             color: Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(8)),
//                         child: TextFormField(
//                           controller: _contentController,
//                           decoration: InputDecoration(
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             hintText: "Description",
//                           ),
//                           maxLines: 5,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter content';
//                             }
//                             return null; // Input is valid
//                           },
//                         )),
                  
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         TextButton(
//                           child: const Text('Cancel'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         TextButton(
//                           child: Text(widget.notification != null
//                               ? 'Edit'
//                               : 'submit'),
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               _submit();
//                             }
//                           },
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:mdrasty_app/parent/note.dart';
// import 'package:mdrasty_app/student/components/drawer/custom_drawer.dart';
// import 'package:mdrasty_app/style/appbar.dart';
// import 'package:mdrasty_app/style/appbarchild.dart';
// import 'package:mdrasty_app/style/fontstyle.dart';
// import 'package:mdrasty_app/style/list.dart';

// class viewnoti extends StatefulWidget {
//   @override
//   _viewnotiState createState() => _viewnotiState();
// }

// class _viewnotiState extends State<viewnoti> {
//   String _searchText = '';
//     TextEditingController _searchController = TextEditingController();

//   void _deleteNotification(int index) {
//     setState(() {
//       noti.removeAt(index);
//     });
//   }
//     @override
//   void dispose() {
//     _searchController.dispose(); // التخلص من متحكم البحث عند التخلص من الصفحة
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Filtered notifications based on search text
//     final filteredNotifications = noti.where((notification) =>
//         _searchText.isEmpty || notification.titile.contains(_searchText)).toList();

//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: appbarchild(title: "مدرستي",),
//         drawer: CustomDrawer(),
            
//         body: GestureDetector(
//           onTap: () {
//             // Hide keyboard when tapping anywhere on the screen
//             FocusScope.of(context).unfocus();
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Card(
//                   elevation: 9,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 6),
//                           child: TextField(
//                             onChanged: (value) {
//                               setState(() {
//                                 _searchText = value;
//                               });
//                             },
//                             controller: _searchController,
//                             decoration: InputDecoration(
                            
//                               hintText: 'ابحث...',
//                               hintStyle: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {});
//                         },
//                         icon: Icon(
//                           Icons.search,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: filteredNotifications.isEmpty // Check if there are no filtered notifications
//                     ? Center(
//                         child: Text(
//                           'لا توجد نتائج',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       )
//                     : ListView.builder(
//                         itemCount: filteredNotifications.length,
//                         itemBuilder: (context, index) {
//                           final notifi = filteredNotifications[index];
//                           return Padding(
//                             padding: const EdgeInsets.all(25.0),
//                             child: Column(
//                               children: [
//                                 Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   elevation: 9,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       ListTile(
//                                         leading: const CircleAvatar(
//                                           backgroundImage: AssetImage("img/biology.jpg"),
//                                         ),
//                                         title: Align(
//                                           alignment: Alignment.topRight,
//                                           child: Text(
//                                             notifi.name,
//                                             style: fonttitlestyle.fonttitle,
//                                           ),
//                                         ),
//                                         subtitle: Align(
//                                           alignment: Alignment.topRight,
//                                           child: Text(
//                                             notifi.data,
//                                           ),
//                                         ),
//                                         trailing: PopupMenuButton<String>(
//                                           onSelected: (value) {
//                                             if (value == 'حذف') {
//                                               _deleteNotification(index);
//                                             }
//                                           },
//                                           itemBuilder: (context) => [
//                                             const PopupMenuItem<String>(
//                                               value: 'حذف',
//                                               child: Center(
//                                                 child: Text(
//                                                   'حذف',
//                                                   style: TextStyle(
//                                                     color: Colors.red,
//                                                     fontSize: 17,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(20),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               notifi.titile,
//                                               style: fontstyle.fontheading,
//                                             ),
//                                             Divider(
//                                               thickness: 2,
//                                               color: Colors.grey.shade300,
//                                               endIndent: 5,
//                                               indent: 5,
//                                             ),
//                                             SizedBox(height: 15),
//                                             Container(
//                                               width: MediaQuery.of(context).size.width,
//                                               decoration: BoxDecoration(
//                                                 gradient: LinearGradient(
//                                                   colors: [
//                                                     Colors.indigo.shade400,
//                                                     Colors.blue.shade400,
//                                                     Colors.indigo.shade800,
//                                                   ],
//                                                 ),
//                                                 shape: BoxShape.rectangle,
//                                                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                                               ),
//                                               child: Card(
//                                                 color: Colors.white,
//                                                 elevation: 4,
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius: BorderRadius.circular(12),
//                                                 ),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Text(
//                                                         notifi.content,
//                                                         style: TextStyle(fontSize: 16),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//               ),
//             ],
//           ),
//         ),
//          floatingActionButton: FloatingActionButton(
//         onPressed: () => AddNotificationDialog(),
//         tooltip: 'Add Notification',
//         child: Icon(Icons.add),
//         backgroundColor: Colors.blue.shade900,
//       ),
//       ),
//     );
//   }
  
// }
 