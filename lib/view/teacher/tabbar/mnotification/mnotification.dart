import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Notification {
  final String studentName;
  final String studentAvatarUrl;
  final String date;
  final String body;

  Notification({
    required this.studentName,
    required this.studentAvatarUrl,
    required this.date,
    required this.body,
  });
}

class ViewNotification extends StatefulWidget {
  @override
  _ViewNotificationState createState() => _ViewNotificationState();
}

class _ViewNotificationState extends State<ViewNotification> {
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
            body: item[
                'body'], // Assuming 'body' is the key for notification body
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 10,
            
            centerTitle: true,
            title: const Text(
              'الاشعارات المدرسية',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            flexibleSpace: Container(
              
              decoration: BoxDecoration(
                
                  gradient: LinearGradient(colors: [
                Colors.blueGrey.shade400,
                Colors.blue.shade500,
                Colors.blueGrey.shade800,
              ])),
            ),
          ),
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
                                hintText: 'بحث  ',
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
