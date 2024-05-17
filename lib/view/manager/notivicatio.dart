import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mdrasty_app/constant/appbar.dart';
import 'package:mdrasty_app/constant/searchbar.dart';

import 'package:mdrasty_app/style/fontstyle.dart';

import 'package:mdrasty_app/constant/fontstyle.dart';

class notificationmanagers extends StatefulWidget {
  @override
  _notificationmanagersState createState() => _notificationmanagersState();
}

class _notificationmanagersState extends State<notificationmanagers> {
  late StreamController<List<Map<String, dynamic>>> _notificationsStreamController;
  late List<Map<String, dynamic>> notifications;
  late List<Map<String, dynamic>> filteredNotifications;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    notifications = []; // يمكنك استبدال هذه القائمة بالبيانات الافتراضية أو ببيانات مسترجعة من السحابة
    filteredNotifications = notifications;

    _notificationsStreamController = StreamController<List<Map<String, dynamic>>>.broadcast();
    _notificationsStreamController.add(filteredNotifications);
    _searchController.addListener(() {
      _filterNotifications(_searchController.text);
    });
  }

  @override
  void dispose() {
    _notificationsStreamController.close();
    _searchController.dispose();
    super.dispose();
  }

  void _addNotification(Map<String, dynamic> notification) {
    notifications.add(notification);
    _filterNotifications('');
    _notificationsStreamController.add(filteredNotifications.toList());
  }

  void _editNotification(int index, Map<String, dynamic> newNotification) {
    notifications[index] = newNotification;
    _filterNotifications('');
    _notificationsStreamController.add(filteredNotifications.toList());
  }

  void _deleteNotification(int index) {
    notifications.removeAt(index);
    _filterNotifications('');
    _notificationsStreamController.add(filteredNotifications.toList());
  }

  void _filterNotifications(String query) {
    setState(() {
      filteredNotifications = notifications.where((notification) {
        final title = notification['العنوان'].toString().toLowerCase();
        final content = notification['الاشعار'].toString().toLowerCase();
        return title.contains(query.toLowerCase()) || content.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showAddNotificationDialog({Map<String, dynamic>? notification, int? index}) {
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
    return Scaffold(
      appBar: CustomAppBar(title: "مدرستي",),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notificationsStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SearchBar(
                  controller: _searchController,
                  onChanged: (value) => _filterNotifications(value),
                  noResults: filteredNotifications.isEmpty,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredNotifications.length,
                    itemBuilder: (context, index) {
                      var notification = filteredNotifications[index];
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
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage("img/quran.jpg"),
                                ),
                                title: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'غلا بن بشر',
                                    //style: fonttitlestyle.fonttitle,
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
                                    PopupMenuItem<String>(
                                      value: 'تعديل',
                                      child: Center(child: Text('تعديل')),
                                    ),
                                    PopupMenuItem<String>(
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
                                    Text(notification['العنوان']),
                                    Divider(
                                      thickness: 2,
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
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("خطأ في جلب البيانات"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: const EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                widget.notification == null ? 'اشعار جديد' : 'تعديل الاشعار',
                textAlign: TextAlign.center,
                //style: fontwhite.fonttitle
              ),
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
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text("العنوان "),
                      ),
                      SizedBox(height: 6),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text("الاشعار"),
                      ),
                      SizedBox(height: 6),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: _contentController,
                          decoration: InputDecoration(
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
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.white, Colors.blue.shade900],
                                ),
                              ),
                              child: Center(
                                child: Text('الغاء'),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _submit();
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.white, Colors.blue.shade900],
                                ),
                              ),
                              child: Center(
                                child: Text(widget.notification != null ? 'تعديل' : 'ارسال'),
                              ),
                            ),
                          ),
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
    );
  }
}

