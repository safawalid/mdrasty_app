import 'package:flutter/material.dart';
import 'package:mdrasty_app/constant/appbarchild.dart';


import 'package:mdrasty_app/style/fontstyle.dart';
import 'package:mdrasty_app/style/list.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mdrasty_app/constant/fontstyle.dart';
import 'package:mdrasty_app/view/student/components/drawer/custom_drawer.dart';
 

class viewassigment extends StatefulWidget {
  @override
  _viewassigmentState createState() => _viewassigmentState();
}

class _viewassigmentState extends State<viewassigment> {
  String _searchText = '';

  void _deleteNotification(int index) {
    setState(() {
      noti.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtered notifications based on search text
    final filteredNotifications = assig.where((notification) =>
        _searchText.isEmpty || notification.titile.contains(_searchText)).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
      appBar:appbarchild(title: "الواجبات"),
      drawer: CustomDrawer(),
        body: GestureDetector(
          onTap: () {
            // Hide keyboard when tapping anywhere on the screen
            FocusScope.of(context).unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 9,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _searchText = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'ابحث...',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
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
              Expanded(
                child: filteredNotifications.isEmpty // Check if there are no filtered notifications
                    ? Center(
                        child: Text(
                          'لا توجد نتائج',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredNotifications.length,
                        itemBuilder: (context, index) {
                          final notifi = filteredNotifications[index];
                          return Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 9,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: const CircleAvatar(
                                          backgroundImage: AssetImage("img/biology.jpg"),
                                        ),
                                        title: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            notifi.name,
                                            style: fonttitlestyle.fonttitle,
                                          ),
                                        ),
                                        subtitle: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            notifi.data,
                                          ),
                                        ),
                                        trailing: PopupMenuButton<String>(
                                          onSelected: (value) {
                                            if (value == 'حذف') {
                                              _deleteNotification(index);
                                            }
                                          },
                                          itemBuilder: (context) => [
                                            const PopupMenuItem<String>(
                                              value: 'حذف',
                                              child: Center(
                                                child: Text(
                                                  'حذف',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              notifi.titile,
                                              style: fontstyle.fontheading,
                                            ),
                                            Divider(
                                              thickness: 2,
                                              color: Colors.grey.shade300,
                                              endIndent: 5,
                                              indent: 5,
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.indigo.shade400,
                                                    Colors.blue.shade400,
                                                    Colors.indigo.shade800,
                                                  ],
                                                ),
                                                shape: BoxShape.rectangle,
                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Card(
                                                color: Colors.white,
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        notifi.content,
                                                        style: fonttitlestyle.fonttitle,
                                                      ),
                                                      
                                                      Text(" موعد التسليم: ${notifi.data2}"),
                                                      SizedBox(height: 10,),
                                                      Text("  درجة الواجب: ${notifi.grde}"),
                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            ElevatedButton.icon(
  style: ElevatedButton.styleFrom(
    primary: Colors.blue.shade700,
  ),
  onPressed: () async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      // هنا يمكنك استخدام الملف المختار كما تشاء
      print('تم اختيار الملف: ${file.name}');
    } else {
      // لم يتم اختيار أي ملف
      print('لم يتم اختيار ملف');
    }
  },
  icon: Icon(
    Icons.attach_file,
    color: Colors.white,
  ),
  label: Text(
    "ادراج ملف",
    style: TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
  ),
),

                                                          ],
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                              SizedBox(height: 20),
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.indigo.shade400,
                                                    Colors.blue.shade400,
                                                    Colors.indigo.shade800,
                                                  ],
                                                ),
                                                shape: BoxShape.rectangle,
                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Card(
                                                color: Colors.white,
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                      "ملاحظات الاستاذ:",
                                                      style: fonttitlestyle.fonttitle,
                                                      ),
                                                      Text(notifi.answer,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          ElevatedButton(
                                                             style: ElevatedButton.styleFrom(
                                                                primary: Colors.blue.shade700,
                                                              ),
                                                            onPressed: (){}, child: Text("الدرجة : ${notifi.grad2}")),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
