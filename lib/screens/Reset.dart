import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';

class Reset extends StatefulWidget {
  static const routeName = 'reset-password';

  @override
  _ResetState createState() => _ResetState();
  static GlobalKey<FormState> _changePassScreenFormKey = GlobalKey<FormState>();
}

class _ResetState extends State<Reset> {
  String email;
  String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Form(
        key: Reset._changePassScreenFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Image.asset(
                'assets/images/lock.png',
                color: Colors.grey[300],
                scale: 1.1,
              ),
              const SizedBox(height: 16),
              Text(
                'Reset  Password',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please, enter your email address',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey[400],
                          ),
                          hintText: 'Email',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        keyboardType: TextInputType.text,
                        // obscureText: _obscureText,
                        onSaved: (newValue) {
                          setState(() {
                            email = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    FlatButton(
                      onPressed: () {
                        if (Reset._changePassScreenFormKey.currentState
                            .validate()) {
                          API.resetPassword(email).then((value) {
                            if (value.statusCode == 200 ||
                                value.statusCode == 201 ||
                                value.statusCode == 202) {
                              var responseData = jsonDecode(value.body);
                              setState(() {
                                message = responseData["message"];
                              });

                              print(responseData["message"]);
                            } else
                              setState(() {
                                message = 'Error in reset mail ..';
                              });
                          });
                        }
                      },
                      height: 30,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      minWidth: MediaQuery.of(context).size.width * 0.3,
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Send',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Center(child: Text(message ?? ''))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
