
import 'package:flutter/material.dart';
import 'package:mdrasty_app/manager/appbarmanager.dart';
import 'package:mdrasty_app/student/components/drawer/custom_drawer.dart';
import 'package:mdrasty_app/style/appbar.dart';
import 'package:mdrasty_app/style/fontstyle.dart';
import 'package:intl/intl.dart';

class notificationmanager extends StatefulWidget {
  @override
  _notificationmanagerState createState() => _notificationmanagerState();
}

class _notificationmanagerState extends State<notificationmanager> {
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
        borderRadius: BorderRadius.circular(18),
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
    bool isPressed;
    return Scaffold(
      appBar: appbarmanager(),
      endDrawer: const CustomDrawer(),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          var notification = notifications[index];
          bool isPressed = false;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage("images/4.jpg"),
                    ),
                    title: const Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'غلا بن بشر',
                        style: fonttitlestyle.fonttitle,
                      ),
                    ),
                    subtitle: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                      ),
                    ),
                    trailing: PopupMenuButton<String>(
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
                        const PopupMenuItem<String>(
                          value: 'تعديل',
                          child: Center(
                              child: Text(
                            'تعديل',
                            style: fonttitlestyle.fonttitle,
                          )),
                        ),
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
                    // Timestamp on the top left corner
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification['العنوان'],
                            style: fontstyle.fontheading),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          notification['الاشعار'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
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
        child: Icon(Icons.add),
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
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime _deadline = DateTime.now();
  String? _attachedFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.notification != null) {
      _titleController.text = widget.notification!['العنوان'];
      _contentController.text = widget.notification!['الاشعار'];
    }
  }

  void _submit() {
    final notificationData = {
      'العنوان': _titleController.text,
      'الاشعار': _contentController.text,
    };
    widget.onSubmit(notificationData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey.shade200,
              Colors.blue.shade800,
              Colors.blue.shade900,
            ],
          ),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
                widget.notification == null ? 'اشعار جديد' : 'تعديل الاشعار',
                textAlign: TextAlign.center,
                style: fontwhite.fonttitle),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Divider(
                      thickness: 1.2,
                      color: Colors.grey.shade200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text("العنوان ", style: fontwhite.fonttitle)),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: _titleController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null; // Input is valid
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text("الاشعار", style: fontwhite.fonttitle),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: _contentController,
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            alignLabelWithHint: true,
                          ),
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null; // Input is valid
                          },
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: const Text('الغاء'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                              widget.notification != null ? 'تعديل' : 'ارسال'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submit();
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
