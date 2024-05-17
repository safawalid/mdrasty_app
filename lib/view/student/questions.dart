import 'package:flutter/material.dart';
import 'package:mdrasty_app/constant/appbarchild.dart';


import 'package:mdrasty_app/constant/fontstyle.dart';
import 'package:mdrasty_app/view/student/components/drawer/custom_drawer.dart';

class questions extends StatefulWidget {
  @override
  _questionsState createState() => _questionsState();
}

class _questionsState extends State<questions> {
  List<Comment> replies = []; // List to store the replies

  TextEditingController _replyController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  void _sendReply() {
    String reply = _replyController.text;
    if (reply.isNotEmpty) {
      setState(() {
        replies.add(Comment(
          text: reply,
          userName: 'حلا بن بشر',
          avatarUrl: 'img/arabic.jpg', // URL for the user's avatar
          date: DateTime.now(),
        )); // Add the reply to the list
        _replyController.clear(); // Clear the text field
      });
    }
  }

  void _editReply(int index) {
    String editedReply = replies[index].text; // Get the reply to edit
    _replyController.text = editedReply; // Set the reply in the text field
    _replyController.selection = TextSelection.fromPosition(TextPosition(
        offset: editedReply.length)); // Move cursor to the end of the text
    setState(() {
      replies.removeAt(index); // Remove the original reply from the list
    });
  }

  void _deleteReply(int index) {
    setState(() {
      replies.removeAt(index); // Remove the reply from the list
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _replyController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      // Hide keyboard when focus is lost
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(title: "اقتراحاتي"),
        drawer: CustomDrawer(),
        body: GestureDetector(
          onTap: () {
            // Hide keyboard when tapping outside the text field
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _replyController,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: 'اكتب سؤالك هنا...',
                            border: UnderlineInputBorder(), // Remove borders
                          ),
                          textDirection:
                              TextDirection.rtl, // Set text direction
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue.shade700,
                              ),
                              onPressed: () {
                                _sendReply();
                              },
                              child: Text('إرسال'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue.shade700,
                              ),
                              onPressed: () {
                                _replyController.clear();
                              },
                              child: Text('إلغاء'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: replies.length,
                  itemBuilder: (context, index) {
                    final comment = replies[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: CommentWidget(
                        comment: comment,
                        onEdit: () => _editReply(index),
                        onDelete: () => _deleteReply(index),
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

class Comment {
  final String userName;
  final String avatarUrl;
  final String text;
  final DateTime date;

  Comment({
    required this.userName,
    required this.avatarUrl,
    required this.text,
    required this.date,
  });
}

class CommentWidget extends StatelessWidget {
  final Comment comment;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CommentWidget({
    required this.comment,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                comment.userName,
                style: fontstyle.fontheading,
              ),
              subtitle: Text(
                comment.date.toString(), // Format the date as needed
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage(comment.avatarUrl),
                radius: 20,
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      title: Text(
                        'تعديل',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        onEdit();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      title: Text('حذف',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )),
                      onTap: () {
                        onDelete();
                          Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(comment.text, style: fontstyle.fontheading),
            SizedBox(height: 10),
            Divider(
              thickness: 2,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade900,
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
                        'الجواب:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'محتوى الكارد',
                        style: TextStyle(fontSize: 16),
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
