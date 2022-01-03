import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'auth/Dashboard.dart';
import 'auth/user.dart';

class Login extends StatefulWidget {
  //const Login({required Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");
  String url = "http://192.168.56.1:8085/login";

  Future save() async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}));
    print(res.body);
    if (res.body != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 570.0,
                            width: 340.0,
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      "Login",
                                      style: GoogleFonts.asset(fontSize: 20),
                                    ),
                                    TextFormField(
                                        controller: TextEditingController(
                                            text: user.email),
                                        decoration: InputDecoration(
                                          hintText: "Your email ...",
                                          border: OutlineInputBorder(),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                        obscureText: true,
                                        controller: TextEditingController(
                                            text: user.password),
                                        decoration: InputDecoration(
                                          hintText: "Your password ...",
                                          border: OutlineInputBorder(),
                                        )),
                                  ],
                                )),
                          ),
                          Container(
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState == null) {}
                                if (_formKey.currentState!.validate()) {
                                  save();
                                }
                              },
                              child: Icon(Icons.arrow_forward),
                            ),
                          )
/*new TextField(
decoration: new InputDecoration(hintText: "enter your password",labelText:"Email"),
validator: (text) => text.isEmpty ? 'User Name is required' : '',
),
new TextField(
decoration: new InputDecoration(hintText: "enter your password",labelText:"Email"),
validator: (text) => text.isEmpty ? 'User Name is required' : '',
)*/
                        ])))));
  }
}
