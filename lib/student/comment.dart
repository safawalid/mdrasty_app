
import 'package:flutter/material.dart';
import 'package:mdrasty_app/style/appbar.dart';
import 'package:mdrasty_app/style/appbarchild.dart';
import 'package:mdrasty_app/style/buttonicon.dart';
import 'package:mdrasty_app/style/fontstyle.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';


// import 'drwer.dart/custom_drawer.dart';



class NotificationPae extends StatefulWidget {
  @override
  _NotificationPaeState createState() => _NotificationPaeState();
}

class _NotificationPaeState extends State<NotificationPae> {
  List<Map<String, dynamic>> notifications = [];

  void _addNotification(Map<String, dynamic> notification) {
    setState(() {
      notifications.add(notification);
    });
  }

  void _editNotification(int index, Map<String, dynamic> newNotification) {
    setState(() {
      notifications[index] = newNotification;
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  void _showAddNotificationDialog(
      {Map<String, dynamic>? notification, int? index}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      builder: (BuildContext context) {
        return AddNotificationDialog(
          onSubmit: (notificationData) {
            if (index == null) {
              _addNotification(notificationData);
            } else {
              _editNotification(index, notificationData);
            }
          },
          notification: notification,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarchild(title:"ملاحظات"),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          var notification = notifications[index];
          bool isPressed = false;
    
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              child: Column(
                children: [
                  ListTile(
                  trailing  : const CircleAvatar(
                    backgroundImage:AssetImage("images/1.jpg"),
                    ),
                    title: const Align(alignment: Alignment.topRight,
                      child: Text(
                        'غلا بن بشر',
                      style: fonttitlestyle.fonttitle,
                      ),
                      
                    ),
                    subtitle:    Align(alignment: Alignment.topRight,
                      child: Text(
                        '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                      ),
                    ),
                  
                    leading: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'تعديل') {
                          _showAddNotificationDialog(
                            notification: notification,
                            index: index,
                          );
                        } else if (value == 'حذف') {
                          _deleteNotification(index);
                        }
                      },
                      itemBuilder: (context) => [
                      const  PopupMenuItem<String>(
                          value: 'تعديل',
                          child: Center(child: Text('تعديل',style: fonttitlestyle.fonttitle,)),
                        ),
                      const  PopupMenuItem<String>(
                          value: 'حذف',
                          child: Center(
                            child: Text('حذف'
                            ,style: TextStyle(color: Colors.red,fontSize: 17,  fontWeight: FontWeight.bold,),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          notification['content'],
                          style: fonttitlestyle.fonttitle,
                        ),
                      
                      
                           Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                            //   Text(
                            //   'موعد التسليم:${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                            // ),
                                InkWell(
          onTap: () {
            // عند الضغط على الزر "عرض"
            // _viewPdf(context); // استدعاء دالة عرض الملف PDF مع تمرير السياق
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigo.shade500,
                  Colors.blue.shade300,
                  Colors.indigo.shade800,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              
                Text(
                  'عرض الرد',
                  style:fontwhite.fonttitle
                ),
              ],
              
            ),
          ),
        ),
                    
                             ],
                           ),
                            //  Text("الدرجة: ${10}")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNotificationDialog(),
        tooltip: 'Add Notification',
        child: Icon(Icons.add,color:icons.iconsapp,),
        backgroundColor: Colors.blue.shade900,
      ),
    );
  }


}


class AddNotificationDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final Map<String, dynamic>? notification;

  AddNotificationDialog({required this.onSubmit, this.notification});

  @override
  _AddNotificationDialogState createState() => _AddNotificationDialogState();
}

class _AddNotificationDialogState extends State<AddNotificationDialog> {
  final TextEditingController _textFieldController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit() {
    final notificationData = {
      
      'content': _textFieldController.text,
    };
    widget.onSubmit(notificationData);
    Navigator.of(context).pop();
  }
    void initState() {
    super.initState();
    if (widget.notification != null) {
      
      _textFieldController.text = widget.notification!['content'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8, // عرض الحوار
        height: MediaQuery.of(context).size.height * 0.3, // ارتفاع الحوار
        child: Form(
            key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(
                //   child: Text(
                //     'أرسال ملاحظة',
                //     style:fontstyle.fontheading,
                //   ),
                // ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _textFieldController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'اكتب هنا',
                    border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '  ';
                                }
                                return null;
                              }, // عدد الأسطر المسموح بها
                ),
                SizedBox(height: 
                25,),
                  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                                  
                            buttoncancle(),
                              InkWell(
          onTap: () {
              if (_formKey.currentState!.validate()) {
                                    _submit();
                                  }},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigo.shade500,
                  Colors.blue.shade300,
                  Colors.indigo.shade800,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              
              
                Text(
                  widget.notification != null ? 'تعديل' : 'أرسال',
                  style:fontwhite.fonttitle
                ),
              ],
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
    
    );
  }


}


