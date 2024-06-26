import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mdrasty_app/constant/appbar.dart';
import 'package:mdrasty_app/constant/buttoncolor.dart';
import 'dart:convert';

import 'package:mdrasty_app/view/supervisor/component/drawer/custom_drawer.dart';

class Notification {
  final String studentName;
  final String studentAvatarUrl;
  final String date;
  final String body;
  final List<String> replies; // Added for storing replies

  Notification({
    required this.studentName,
    required this.studentAvatarUrl,
    required this.date,
    required this.body,
    this.replies = const [], // Initialize with empty list
  });
}

class viewquestionclass extends StatefulWidget {
  @override
  _viewquestionclassState createState() => _viewquestionclassState();
}

// داخل _viewquestionclassState
class _viewquestionclassState extends State<viewquestionclass> {
  late List<Notification> originalNotifications;
  List<Notification> filteredNotifications = [];
  late TextEditingController searchController;
  bool showNoResults = false;

  Future<void> fetchNotifications() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        originalNotifications = jsonData.map((item) {
          return Notification(
            studentName: item['title'],
            studentAvatarUrl: 'https://example.com/avatar.png',
            date: '2024-04-01',
            body: item['body'],
            replies: [], // Assuming 'body' is the key for notification body
          );
        }).toList();
        filteredNotifications = List.from(originalNotifications);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    searchController = TextEditingController();
  }

  void _showAddReplyDialog(BuildContext context, Notification notification) {
    TextEditingController replyController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('اضافة رد'),
          content: TextField(
            controller: replyController,
            decoration: InputDecoration(hintText: "اكتب ردك هنا"),
            maxLines: 3,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ارسال'),
              onPressed: () async {
                String reply = replyController.text;
                if (reply.isNotEmpty) {
                  await _sendReply(notification, reply);
                  setState(() {
                    // Update local state to show the reply instantly
                    notification.replies
                        .add(reply); // Add the reply to the notification
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendReply(Notification notification, String reply) async {
    // Simulate sending the reply to a server (optional)
    // This function is used for local update only, no actual API call
    setState(() {
      // Add the reply to the notification
      notification.replies.add(reply);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: 'اسئلة الطلاب',
          ),
          drawer: CustomDrawer(),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    filteredNotifications =
                                        List.from(originalNotifications);
                                    showNoResults = false;
                                  } else {
                                    filteredNotifications =
                                        originalNotifications
                                            .where((notification) =>
                                                notification.studentName
                                                    .contains(value))
                                            .toList();
                                    showNoResults =
                                        filteredNotifications.isEmpty;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'بحث',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (showNoResults)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'لا توجد نتائج',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: filteredNotifications.length,
                              itemBuilder: (context, index) {
                                var notification = filteredNotifications[index];
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Material(
                                                elevation: 5,
                                                shape: CircleBorder(),
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    notification
                                                        .studentAvatarUrl,
                                                  ),
                                                  radius: 30,
                                                  backgroundColor: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  notification.studentName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(notification.date),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(
                                            color: Colors.grey.shade800,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              'Body: ${notification.body}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                "img/biology.jpg"),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.8,
                                                        width: MediaQuery.of(
                                                                    context)
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
                                                    0.2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            child: CustomGradientButton(
                                              buttonText: 'اضافة رد',
                                              onPressed: () {
                                                _showAddReplyDialog(
                                                    context, notification);
                                              },
                                              hasHomework: true,
                                            ),
                                          ),
// تظهر الردود كتعليقات
                                          if (notification.replies.isNotEmpty)
                                            ...notification.replies
                                                .map((reply) => Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5.0,
                                                          horizontal: 20),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              reply,
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                fontSize: 19,
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                              ),
                                                            ),
                                                          ),
                                                          Icon(Icons.comment),
                                                        ],
                                                      ),
                                                    )),
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
