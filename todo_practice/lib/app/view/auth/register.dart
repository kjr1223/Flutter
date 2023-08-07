<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/app/service/auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State {
  late FirebaseAuth auth;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _userNameController;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'password'),
              obscureText: true,
            ),
            TextFormField(
              controller: _userNameController,
              decoration: InputDecoration(labelText: 'User Name'),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                registerWithEmail(
                    auth,
                    _emailController.text,
                    _passwordController.text,
                    _userNameController.text,
                    context);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
=======
// TODO Implement this library.
>>>>>>> 4603d33e82c384cf65da806022be1c61b7294f52
