import 'package:flutter/material.dart';
import 'package:mdrasty_app/manager/appbarmanager.dart';
import 'package:mdrasty_app/style/appbar.dart';
import 'package:mdrasty_app/style/fontstyle.dart';

class attendmanager extends StatefulWidget {
  @override
  _attendmanagerState createState() => _attendmanagerState();
}

class _attendmanagerState extends State<attendmanager> {
  final TextEditingController _searchController = TextEditingController();
  bool _isBackPressed = false;
  List<String> names = ['أحمد', 'فاطمة', 'يوسف'];
  Map<String, bool> checkbox1Status = {};
  Map<String, bool> checkbox2Status = {};
  List<String> _filteredNames = [];

  @override
  void initState() {
    super.initState();
    // Initialize checkbox states
    for (String name in names) {
      checkbox1Status[name] = false;
      checkbox2Status[name] = false;
    }
    _filteredNames = names; // Start with all names displayed
  //   onSaveAttendance = (data) {
  //   // يمكنك هنا تنفيذ العمليات التي ترغب فيها عند حفظ التحضير
  //   // على سبيل المثال، يمكنك إرسال البيانات إلى قاعدة البيانات أو إظهار رسالة تأكيد
  //   // في هذا المثال، سنقوم بطباعة البيانات المحدثة في الـ console
  //   print("تم حفظ الحضور:");
  //   data.forEach((name, isPresent) {
  //     print("$name: $isPresent");
  //   });
  // };
  }

  void _filterNames(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredNames = names; // Show all names if query is empty
      } else {
        _filteredNames = names.where((name) => name.contains(query)).toList();
      }
    });
  }

  void _saveAttendance() {
  // // قم بتحديث البيانات في قاعدة البيانات أو إرسالها إلى الخادم
  // // هنا سنقوم بإرسال البيانات كمعامل لدالة callback

  // // إذا كانت الدالة callback غير معرفة، يجب تعريفها في الوالدين واستخدامها هنا
  // // يمكنك استخدامها لإرسال البيانات المحدثة إلى المكان الذي ترغب فيه
  // // على سبيل المثال، يمكنك استخدام دالة callback لتحديث حالة التحضير في أحد مراقبي الحالة في واجهة المستخدم

  // // هنا سنستخدم دالة callback مثالية لإظهار كيفية استخدامها
  // if (onSaveAttendance != null) {
  //   onSaveAttendance!(checkbox1Status);
  // }
}

// تعريف callback لاستخدامه في حفظ التحضير
// Function(Map<String, bool>)? onSaveAttendance;

// يمكنك استخدامه في الصفحة الرئيسية أو في أي مكان آخر ترغب فيه
// قم بتحديدها في initState() مثلاً
@override



  void _cancelAttendance() {
    
     setState(() {
    for (String name in names) {
      checkbox1Status[name] = false;
      checkbox2Status[name] = false;
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:const appbarmanager(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 10,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: TextField(
                                    controller: _searchController,
                                    style: const TextStyle(color: Colors.white),
                                    onChanged: _filterNames,
                                    decoration:const InputDecoration(
                                      hintText: 'ابحث...',
                                      hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _filterNames(_searchController.text);
                                },
                                icon:const Icon(
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
                  if (_filteredNames.isEmpty &&
                      _searchController.text.isNotEmpty)
                  const  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 90),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'لا توجد نتائج',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredNames.length,
                itemBuilder: (context, index) {
                  String name = _filteredNames[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Card(
                      elevation: 5.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                textAlign: TextAlign.right,
                                style: fonttitlestyle.fonttitle,
                              ),
                            ),
                            Checkbox(
                              value: checkbox1Status[name] ?? false,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkbox1Status[name] = value ?? false;
                                });
                              },
                              activeColor: Colors.green[700],
                              shape: const  RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                            ),
                            Text(
                              'حاضر',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.green[500],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Checkbox(
                              value: checkbox2Status[name] ?? false,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkbox2Status[name] = value ?? false;
                                });
                              },
                              activeColor: Colors.red[900],
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                            ),
                            Text(
                              'غائب',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.red[500],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  _saveAttendance();
                },
                child: Container(
                  padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade500,
                        Colors.blue.shade300,
                        Colors.indigo.shade800,
                      ],
                    ),
                    borderRadius:const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children:const [
                      
                      SizedBox(width: 8),
                      Text(
                        'حفظ',
                        style:fontwhite.fonttitle
                      ),
                      Icon(
                        Icons.download_done,
                        color:icons.iconsapp,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _cancelAttendance();
                },
                child: Container(
                  padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade500,
                        Colors.blue.shade300,
                        Colors.indigo.shade800,
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children:  const[
                      
                      SizedBox(width: 8),
                      Text(
                        'الغاء',
                        style: fontwhite.fonttitle
                      ),
                      Icon(
                        Icons.close,
                        color: icons.iconsapp,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// apppbar|||||||||||||||||||||||||||||||||||||||||||||||||||||

class appbarchild extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const appbarchild({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo.shade500,
                Colors.blue.shade300,
                Colors.indigo.shade800,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
