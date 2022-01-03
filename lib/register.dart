import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'auth/user.dart';

class Register extends StatefulWidget {
  //Register({Key key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");
  String url = "http://192.168.56.1:8085/register";

  Future save(user) async {
    print(user.email);
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}));
    print(res.body);
    if (res.body != null) {
      Navigator.pop(context);
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Register",
                          style: GoogleFonts.asset(fontSize: 20),
                        ),
                        TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                              hintText: "Your email ...",
                              border: OutlineInputBorder(),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            obscureText: true,
                            controller: password,
                            decoration: InputDecoration(
                              hintText: "Your password ...",
                              border: OutlineInputBorder(),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState == null) {}
                              if (_formKey.currentState!.validate()) {
                                save(User(email.text, password.text));
                              }
                            },
                            child: Text("Register"))
                      ],
                    )))));
  }
}
