import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class s extends StatefulWidget {
  @override
  _sState createState() => _sState();
}

class _sState extends State<s> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final prefs = await SharedPreferences.getInstance();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // تحقق من صحة اسم المستخدم وكلمة المرور (استبدل هذا بالتحقق الفعلي)
    if (username == "example" && password == "password") {
      // حفظ حالة تسجيل الدخول
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('username', username);

      // انتقل إلى الصفحة الرئيسية
    Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => HomePage()),
);

    } else {
      // عرض رسالة خطأ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('اسم المستخدم أو كلمة المرور غير صحيحة'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل الدخول'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'اسم المستخدم',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'من فضلك أدخل اسم المستخدم';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
              
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'من فضلك أدخل كلمة المرور';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                },
                child: Text('تسجيل الدخول'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الصفحة الرئيسية'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('مرحبًا بك في التطبيق!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/logout');
              },
              child: Text('تسجيل الخروج'),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutPage extends StatefulWidget {
  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  void _logout() async {
    final prefs = await SharedPreferences.getInstance();

    // محو بيانات تسجيل الدخول من Shared Preferences
    await prefs.remove('is_logged_in');
    await prefs.remove('username');

    // انتقل إلى صفحة تسجيل الدخول
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل الخروج'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('هل تريد تسجيل الخروج؟'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _logout,
              child: Text('تسجيل الخروج'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // العودة إلى الصفحة السابقة
              },
              child: Text('إلغاء'),
            ),
          ],
        ),
      ),
    );
  }
}
