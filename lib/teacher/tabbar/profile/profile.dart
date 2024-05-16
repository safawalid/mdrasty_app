import 'package:flutter/material.dart';
import 'package:mdrasty_app/style/appbar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _passwordVisible = false;
  String _password = '12345678'; // كلمة المرور الأصلية
  String _originalPassword =
      ''; // لتخزين كلمة المرور الأصلية للعودة إليها عند الإلغاء
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(title: 'صفحه شخصيه'),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.indigo[500]!, // لون بنفسجي
                  Colors.indigo[900]!, // لون بنفسجي غامق
                ],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('img/1.jpg'),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'المدرس',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'كلمة المرور',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            initialValue: _password, // قيمة كلمة المرور الأصلية
                            obscureText: !_passwordVisible,
                            onChanged: (value) {
                              setState(() {
                                _password = value; // تحديث كلمة المرور
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter new password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: IconButton(
                                color: Colors.indigo[900]!,
                                icon: Icon(_passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
    
                            maxLength: 8,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              } else if (value.length != 8 ||
                                  int.tryParse(value) == null) {
                                return 'Password must be 8 digits numeric';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // حفظ التغييرات وعرض الديالوج للتأكيد
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Changes Saved!'),
                                        content: Text(
                                            'Password has been successfully updated.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              // Update the original password and close the dialog
                                              setState(() {
                                                _originalPassword = _password;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.indigo[900]!,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Save',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // حفظ الكلمة الأصلية وعرض الديالوج لتأكيد الإلغاء
                                _originalPassword = _password;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Cancel Changes?'),
                                      content: Text(
                                          'Are you sure you want to cancel the changes?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            // إعادة الكلمة الأصلية وإغلاق الديالوج
                                            setState(() {
                                              _password =
                                                  _originalPassword; // استعادة كلمة المرور الأصلية
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Yes'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('No'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[900]!,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: 18),
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
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfilePage(),
  ));
}
