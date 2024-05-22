// ignore: file_names
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mdrasty_app/constant/appbar.dart';
import 'package:mdrasty_app/constant/buttoncolor.dart';
import 'package:mdrasty_app/constant/searchbar.dart';
import 'package:mdrasty_app/view/supervisor/component/drawer/custom_drawer.dart';
import 'package:mdrasty_app/view/teacher/tabbar/test.dart';
import 'package:mdrasty_app/view/teacher/tabbar/classtab/homeworknotification/viewhw.dart';

import 'package:page_transition/page_transition.dart';

class descution extends StatefulWidget {
  @override
  _descutionState createState() => _descutionState();
}

class _descutionState extends State<descution> {
  List<Map<String, dynamic>> notifications = [];
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredNames = [];
  bool _isBackPressed = false;

  void _filterNames(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredNames = notifications
            .map((notification) => notification['title'] as String)
            .toList();
      } else {
        _filteredNames = notifications
            .where((notification) => notification['title'].contains(query))
            .map((notification) => notification['title'] as String)
            .toList();
      }
    });
  }

  void _addNotification(Map<String, dynamic> notification) {
    setState(() {
      notifications.add(notification);
      _filteredNames = notifications
          .map((notification) => notification['title'] as String)
          .toList();
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
        appBar: CustomAppBar(title: 'مناقشه'),
        endDrawer: const CustomDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SearchBar(
                  controller: _searchController,
                  onChanged: _filterNames,
                  noResults: _filteredNames.isEmpty &&
                      _searchController.text.isNotEmpty,
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _filteredNames.length,
              itemBuilder: (context, index) {
                var notificationTitle = _filteredNames[index];
                var notification = notifications.firstWhere((notification) =>
                    notification['title'] == notificationTitle);

                return Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4, // Remove card elevation
                        color: Colors.white, // Transparent card background
                        child: Column(
                          children: [
                            ListTile(
                              // Top left corner
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
                              ), // Three dots on the left side

                              // Timestamp on the top left corner
                            ),
                            // Title on the top  corner
                            const SizedBox(
                              height: 10,
                            ),

                            Column(
                              children: [
                                Center(
                                  child: Text(
                                    notification['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05, // Adjust font size
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 8, 30, 8),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                 GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "img/biology.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.8,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        image: AssetImage("img/biology.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width: MediaQuery.of(context).size.width *
                                        0.4, // جعلها أعرض
                                  ),
                                ),

                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: CustomGradientButton(
                                buttonText: 'عرض الحلول',
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
                    ),
                  ],
                );
              },
            )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddNotificationDialog(),
          tooltip: 'اضف نقاش',
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
              widget.notification == null ? 'اشعار جديد' : 'تعديل الاشعار',
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
                    ListTile(
                      title: Text(_attachedFile != null
                          ? 'File attached'
                          : 'Attach file'),
                      trailing: Icon(Icons.attach_file),
                      onTap: _pickFile,
                    ),
                    SizedBox(height: 15),
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
