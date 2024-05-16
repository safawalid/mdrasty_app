
// import 'package:collasable_drawer/components/drawer/custom_drawer.dart';
// import 'package:collasable_drawer/tabbar/classtab/homeworknotification/viewhw.dart';
// import 'package:collasable_drawer/tabbar/test.dart';
// import 'package:collasable_drawer/wedgits/appbar.dart';
// import 'package:collasable_drawer/wedgits/textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mdrasty_app/teacher/components/drawer/custom_drawer.dart';
// import 'package:mdrasty_app/student/components/drawer/custom_drawer.dart';
// import 'package:mdrasty_app/teacher/components/drawer/custom_drawer.dart';
import 'package:mdrasty_app/teacher/tabbar/classtab/homeworknotification/viewhw.dart';
import 'package:mdrasty_app/teacher/tabbar/test.dart';
import 'package:mdrasty_app/teacher/wedgits/appbar.dart';
import 'package:page_transition/page_transition.dart';

import '../../../wedgits/buttoncolor.dart';

class diary extends StatefulWidget {
  @override
  _diaryState createState() => _diaryState();
}

class _diaryState extends State<diary> {
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(title: 'الشروحات'),
        endDrawer: const CustomDrawer(),
        body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            var notification = notifications[index];
            bool isPressed = false;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Material(
                    elevation: 9, // Add elevation for a shadow effect
                    borderRadius:
                        BorderRadius.circular(13.0), // Rounded corners
                    child: Column(
                      children: [
                        ListTile(
                          // Top left corner
                          // Three dots on the left side
                          title: Center(
                            // Title centered in the same row
                            child: Text(
                              notification['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.05, // Adjust font size
                              ),
                            ),
                          ),
                          leading: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showAddNotificationDialog(
                                  notification: notification,
                                  index: index,
                                );
                              } else if (value == 'delete') {
                                _deleteNotification(index);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem<String>(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                          // Timestamp on the top left corner
                        ),
                        Card(
                          elevation: 0, // Remove card elevation
                          color:
                              Colors.transparent, // Transparent card background
                          child: Column(
                            children: [
                              // Title on the top  corner
                              const SizedBox(
                                height: 10,
                              ),

                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 8, 30, 8),
                                          child: Divider(
                                            color: Colors.grey.shade700,
                                            height: 5,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          notification['content'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: CustomGradientButton(
                                  buttonText: ' عرض اسئلة الطلاب',
                                  onPressed: () {
                                    Navigator.of(context).push(PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      duration: Duration(milliseconds: 600),
                                      reverseDuration:
                                          Duration(microseconds: 600),
                                      child: ViewHomeworkTab(),
                                    ));
                                  },
                                  hasHomework: true,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          // alignment: Alignment.bottomLeft,
                          child: Text(
                            DateFormat(' dd/MM/yyyy ')
                                .format(notification['timestamp']),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          // alignment: Alignment.bottomRight,
                          child: Text(
                            DateFormat(' HH:MM ')
                                .format(notification['timestamp']),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
      ),
    );
  }

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Grads()),
    );
    return false;
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
      _titleController.text = widget.notification!['title'];
      _contentController.text = widget.notification!['content'];
      _deadline = widget.notification!['deadline'];
      _attachedFile = widget.notification!['file'];
    }
  }

  void _submit() {
    final notificationData = {
      'title': _titleController.text,
      'content': _contentController.text,
      'deadline': _deadline,
      'timestamp': DateTime.now(),
      'file': _attachedFile,
    };
    widget.onSubmit(notificationData);
    Navigator.of(context).pop();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _attachedFile = result.files.single.path;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _deadline) {
      setState(() {
        _deadline = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_deadline),
    );
    if (picked != null) {
      setState(() {
        _deadline = DateTime(
          _deadline.year,
          _deadline.month,
          _deadline.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              widget.notification == null ? 'واجب جديد' : 'تعديل الواجب',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Divider(
                      thickness: 1.2,
                      color: Colors.grey.shade200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "title",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
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
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Title",
                        ),
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null; // Input is valid
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Description",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
                          controller: _contentController,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Description",
                          ),
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter content';
                            }
                            return null; // Input is valid
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_attachedFile != null
                                ? 'File attached'
                                : 'Attach file'),
                            // Add some space between the text and the icon
                            Icon(Icons.attach_file),
                          ],
                        ),
                        onTap: _pickFile,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomGradientButton(
                          buttonText: 'Cancel',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          // hasHomework:
                          //     false, // Set hasHomework to false for the Cancel button
                        ),
                        CustomGradientButton(
                          buttonText:
                              widget.notification != null ? 'Edit' : 'Submit',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submit();
                            }
                          },
                          hasHomework:
                              true, // Assuming the Edit/Submit button has homework
                        ),
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
