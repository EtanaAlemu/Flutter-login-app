
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:login/components/ForgetPasswordPage.dart';
import 'package:login/components/LoginPage.dart';

import 'HomePage.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
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
                      /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                      child: Image.asset('asset/images/flutter.png')),
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 15),

                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length<4) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
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
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => const Login()));
                    }
                  },
                  child: const Text( 'Signup',
                    style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              ),
              const SizedBox(
                height: 130,
              ),

              Center(
                child: TextButton(
                  onPressed: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => const Login()));

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
}