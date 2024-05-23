import 'package:flutter/material.dart';

class Notification {
  final String studentName;
  final String studentAvatarUrl;
  final String date;
  final String body;
  List<String> replies; // Changed to mutable list for storing replies

  Notification({
    required this.studentName,
    required this.studentAvatarUrl,
    required this.date,
    required this.body,
    this.replies = const [], // Initialize with empty list
  });
}

class ViewQuestionClass extends StatefulWidget {
  @override
  _ViewQuestionClassState createState() => _ViewQuestionClassState();
}

class _ViewQuestionClassState extends State<ViewQuestionClass> {
  late List<Notification> originalNotifications;
  List<Notification> filteredNotifications = [];
  late TextEditingController searchController;
  bool showNoResults = false;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    searchController = TextEditingController();
  }

  Future<void> fetchNotifications() async {
    // Simulating fetching notifications from an API
    // In a real-world scenario, replace this with your actual API call
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        originalNotifications = List.generate(
          10,
          (index) => Notification(
            studentName: 'Student $index',
            studentAvatarUrl: 'https://example.com/avatar.png',
            date: '2024-04-01',
            body: 'Notification body $index',
            replies: [], // Initialize with empty list of replies
          ),
        );
        filteredNotifications = List.from(originalNotifications);
      });
    });
  }

  void _showAddReplyDialog(BuildContext context, Notification notification) {
    TextEditingController replyController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Reply'),
          content: TextField(
            controller: replyController,
            decoration: InputDecoration(hintText: "Type your reply here"),
            maxLines: 3,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Send'),
              onPressed: () {
                String reply = replyController.text;
                if (reply.isNotEmpty) {
                  setState(() {
                    notification.replies.add(reply); // Add the reply locally
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Student Questions'),
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
                                hintText: 'Search',
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
                                'No results found',
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
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage:
                                                    NetworkImage(notification.studentAvatarUrl),
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  notification.studentName,
                                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _showAddReplyDialog(context, notification);
                                              },
                                              child: Text('Add Reply'),
                                            ),
                                          ),
                                          if (notification.replies.isNotEmpty)
                                            ...notification.replies.map((reply) => Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          reply,
                                                          textAlign: TextAlign.right,
                                                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
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


