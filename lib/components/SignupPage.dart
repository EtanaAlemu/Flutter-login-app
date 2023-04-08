import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:login/components/LoginPage.dart';

import 'Utils.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Signup Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset('asset/images/flutter.png')),
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 15),

                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'Please enter a valid username';
                    }
                    return null;
                  },
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter valid username'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  // validator: (value) {
                  //   if (value == null || value.isEmpty || value.length<4) {
                  //     return 'Please enter a valid password';
                  //   }
                  //   return null;
                  // },
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      _signup(
                          email: _emailController.text.toString(),
                          username: _usernameController.text.toString(),
                          password: _passwordController.text.toString());
                    }
                  },
                  child: const Text(
                    'Signup',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const Text(
                      'Do you have account? Login',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                      textAlign: TextAlign.right,
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

  void _signup({required String email, username, password}) async {
    try {
      List<String> role = [];
      role.add('user');
      Map<String, String> requestHeaders = {'Content-type': 'application/json'};
      String body = json.encode({
        'username': username,
        'email': email,
        'password': password,
        'roles': role
      });

      print(body);
      // Response response = await post(
      //     Uri.parse('http://192.168.219.2:8080/api/auth/signup'),
      //     body: {
      //       'username': username,
      //       'email': email,
      //       'password': password,
      //       'roles': role
      //     },
      //     headers: requestHeaders);
      var response = await http
          .post(Uri.http('192.168.219.2:8080', 'api/auth/signup'), body: {
        'username': username,
        'email': email,
        'password': password
      });
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        showSnack('Signup successfully', context);
        Navigator.pop(context);
      } else {
        showSnack(data['message'], context);
      }
    } catch (e) {
      print(e.toString());
      showSnack(e.toString(), context);
    }
  }
}
