import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:mdrasty_app/teacher/tabbar/tabsbar.dart'; // Make sure to import your tabsbar.dart file
import 'package:http/http.dart' as http;


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyTabLogin(),
    );
  }
}
class MyTabLogin extends StatefulWidget {
   MyTabLogin({Key? key}) : super(key: key);
  

  @override
  State<MyTabLogin> createState() => _MyTabLoginState();
}

class _MyTabLoginState extends State<MyTabLogin> {
  final _formKey = GlobalKey<FormState>();
  var x = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade200,
                      Colors.blue.shade300,
                      Colors.blue.shade600,
                      Colors.blue.shade900,
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'مرحبا',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'الرجاء تسجيل الدخول...',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage(
                      //     "img/madrsatylogor.jpg",
                      //   ),
                      //   fit: BoxFit.cover,
                      // ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    height: double.infinity,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.asset(
                              "img/madrsatylogor.jpg",
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  TextFormField(
                                    //  keyboardType: TextInputType.emailAddress,

                                    decoration: InputDecoration(
                                      labelText: "enter your email",
                                      labelStyle: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      prefixIcon: Icon(Icons.email),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue.shade900,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter an email';
                                      }
                                      if (value
                                              .replaceAll(RegExp(r"\s+"), "")
                                              .length <
                                          6) {
                                        return 'Please enter a correct email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  TextFormField(
                                    obscureText: x,
                                    decoration: InputDecoration(
                                      labelText: "enter your password",
                                      labelStyle: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      prefixIcon: IconButton(
                                        icon: x
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            x = !x;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a password';
                                      }
                                      if (value.length < 8) {
                                        return 'Password must be at least 8 characters long';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Container(
                                    width: 300.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => tabsbutton(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.0),
                                        primary: Colors.blue.shade800,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40.0),
                                            bottomRight: Radius.circular(40.0),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
