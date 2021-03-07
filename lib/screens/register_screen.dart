import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';

import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = 'register-screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _registerScreenFormKey = GlobalKey<FormState>();
  bool _obscureText = true;
  DateTime _selectedDate;
  TextEditingController _textEditingController = TextEditingController();
  String firstName;
  String lastName;
  String phoneNumber;
  String emailAddress;
  String password;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  int _radioValue = 0;
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Builder(
        builder: (context) => SafeArea(
          child: Form(
            key: _registerScreenFormKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: size.width * .9,
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(0, 3)),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 16),
                            SizedBox(
                              width: size.width * 0.4,
                              child: Image.asset(
                                'assets/images/logo2.png',
                                width: 150,
                                height: 150,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: Theme.of(context).primaryColor,
                                    decoration: InputDecoration(
                                      prefixIcon: Image.asset(
                                        'assets/images/user.png',
                                        color: Colors.grey[400],
                                        scale: 1.4,
                                      ),
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      setState(() {
                                        firstName = value;
                                      });
                                    },
                                    onSaved: (newValue) {
                                      setState(() {
                                        firstName = newValue;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: Theme.of(context).primaryColor,
                                    decoration: InputDecoration(
                                      prefixIcon: Image.asset(
                                        'assets/images/user.png',
                                        color: Colors.grey[400],
                                        scale: 1.4,
                                      ),
                                      hintText: 'last Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    keyboardType: TextInputType.text,
                                    onSaved: (newValue) {
                                      setState(() {
                                        lastName = newValue;
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        lastName = value;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 16),
                            IntlPhoneField(
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Image.asset(
                                  'assets/images/phone.png',
                                  color: Colors.grey,
                                  scale: 1.5,
                                ),
                              ),
                              initialCountryCode: 'MY',
                              onChanged: (phone) {
                                setState(() {
                                  phoneNumber = phone.number;
                                });
                                print(phone.completeNumber);
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey[400],
                                ),
                                hintText: 'Email Address',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (newValue) {
                                setState(() {
                                  emailAddress = newValue;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  emailAddress = value;
                                });
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.grey[400],
                                ),
                                suffixIcon: IconButton(
                                  splashRadius: 20,
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: _obscureText,
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              onSaved: (newValue) {
                                setState(() {
                                  password = newValue;
                                });
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              focusNode: AlwaysDisabledFocusNode(),
                              controller: _textEditingController,
                              onTap: () => _selectDate(context),
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                  'assets/images/calendar.png',
                                  color: Colors.grey,
                                  scale: 1.5,
                                ),
                                hintText: 'Birth Date',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              readOnly: true,
                              keyboardType: TextInputType.datetime,
                              onSaved: (newValue) {
                                setState(() {
                                  _textEditingController.text = newValue;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _textEditingController.text = value;
                                });
                              },
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/gender.png',
                                  color: Colors.grey,
                                  scale: 1.5,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Gender',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: 0,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text(
                                      'Male',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: size.width * 0.15,
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: 1,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text(
                                      'Female',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: size.width * .9,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: FlatButton(
                            onPressed: () async {
                              if (_registerScreenFormKey.currentState
                                  .validate()) {
                                // _fcm.getToken().then((token) {
                                //   // print('the token is :' + token);
                                //   API.deviceToken(token);
                                // });

                                await API
                                    .createNewPatient(
                                        firstName,
                                        lastName,
                                        phoneNumber,
                                        emailAddress,
                                        _radioValue + 1,
                                        _textEditingController.text,
                                        password,
                                        350700,
                                        AppProvider.deviceToken ?? "123456")
                                    .then((value) {
                                  if (value.statusCode == 201) {
                                    API
                                        .userLogin(emailAddress, password)
                                        .whenComplete(() {
                                      // Provider.of<AppProvider>(context,
                                      //         listen: false)
                                      //     .generateSearchParamters(
                                      //         'service_id=', 1);
                                      // AppProvider.newUser = 1;
                                      Navigator.pushReplacementNamed(
                                          context, HomeScreen.routeName);
                                    });
                                  } else {
                                    var mydata = jsonDecode(value.body);
                                    if (value.statusCode == 422) {
                                      final snackBar = SnackBar(
                                          content: Text(mydata["errors"]
                                                  ["email"][0] ??
                                              ''.toString()));
                                      _scaffoldKey.currentState
                                          .showSnackBar(snackBar);

                                      print(mydata["error"]);
                                    } else {
                                      final snackBar = SnackBar(
                                          backgroundColor: Colors.blue,
                                          content: Text(mydata["message"] ??
                                              'The given data was invalid.'));
                                      _scaffoldKey.currentState
                                          .showSnackBar(snackBar);
                                    }

                                    //  Scaffold.of(context).showSnackBar("Error");
                                  }
                                });
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat('dd-MM-yyyy').format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
