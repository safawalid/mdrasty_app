import 'package:flutter/material.dart';

import 'package:mdrasty_app/manager/appbarmanager.dart';
import 'package:mdrasty_app/style/appbar.dart';
import 'package:mdrasty_app/style/fontstyle.dart';

class Profilemanager extends StatefulWidget {
  @override
  State<Profilemanager> createState() => _ProfilemanagerState();
}

class _ProfilemanagerState extends State<Profilemanager> {
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;
  String _password = '12345678'; // Initial password value

  @override
  void initState() {
    super.initState();
    _passwordController.text = _password;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const appbarmanager(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('images/1.jpg'),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    TextFormField(
                      readOnly: true,
                      initialValue: 'عبير برك بن بشر ',
                      decoration: InputDecoration(
                        labelText: 'اسم المستخدم',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        enabled: false,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController, // Use the controller
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        prefixIcon: Icon(
                          Icons.door_back_door,
                          color: Colors.blue.shade900,
                        ),
                        suffixIcon: IconButton(
                          color: Colors.indigo[900]!,
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 8,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'كلمة المرور مطلوبة';
                      //   } else if (value.length != 8 || int.tryParse(value) == null) {
                      //     return 'كلمة المرور ارقام فقط';
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.indigo.shade500,
                                  Colors.blue.shade300,
                                  Colors.indigo.shade800,
                                ],
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                SizedBox(width: 8),
                                Text(
                                  'حفظ',
                                  style: fontwhite.fonttitle,
                                ),
                                Icon(
                                  Icons.download_done,
                                  color: icons.iconsapp,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _passwordController.text =
                                  _password; // Reset to initial password
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.red.shade500,
                                  Colors.red.shade400,
                                  Colors.red.shade900,
                                ],
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                SizedBox(width: 8),
                                Text(
                                  'الغاء',
                                  style: fontwhite.fonttitle,
                                ),
                                Icon(
                                  Icons.close,
                                  color: icons.iconsapp,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}