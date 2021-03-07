import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/UserInfo.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditProfile extends StatefulWidget {
  static const routeName = 'Edit-Profile';

  @override
  _EditProfileState createState() => _EditProfileState();
  static GlobalKey<FormState> _registerScreenFormKey = GlobalKey<FormState>();
}

class _EditProfileState extends State<EditProfile> {
  bool _obscureText = true;
  DateTime _selectedDate;
  TextEditingController _textEditingController = TextEditingController();
  String firstName;
  String lastName;
  String phoneNumber;
  String emailAddress = "sam@admin.com";
  UserInfo userInfo = UserInfo();
  int _radioValue = 0;
  @override
  void initState() {
    super.initState();
    userInfo  = AppProvider.userInfo ;
    print(userInfo.firstName ?? 'no data ' ) ;
    firstName = userInfo.firstName ;
    lastName = userInfo.lastName ;
    _textEditingController.text = userInfo.birthDate ;
    _radioValue = userInfo.genderId -1 ;
    print(_radioValue.toString());
    phoneNumber = userInfo.mobile;
    print(phoneNumber);
  }


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
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                key: EditProfile._registerScreenFormKey ,
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
                          SizedBox(height: 8),
                          SizedBox(
                            width: size.width * 0.2,
                            child: Image.asset('assets/images/logo2.png'),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
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
                            onSaved: (newValue) {
                              setState(() {
                                firstName = newValue ??userInfo.firstName;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                firstName = value ??userInfo.firstName;
                              });
                            },
                            initialValue: userInfo.firstName ,
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                'assets/images/user.png',
                                color: Colors.grey[400],
                                scale: 1.4,
                              ),
                              hintText: 'Last Name',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) {
                              setState(() {
                                lastName = newValue  ??userInfo.lastName;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                lastName = value  ??userInfo.lastName;
                              });
                            },
                            initialValue: userInfo.lastName ,
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
                            initialCountryCode: 'PS',
                            onSaved: (newValue) {
                              setState(() {
                                phoneNumber = newValue.completeNumber ?? userInfo.mobile ;
                              });
                            },

                            onChanged: (phone) {
                              setState(() {
                                phoneNumber = phone.number?? userInfo.mobile ;
                              });
                              print(phone.countryCode);

                            },
                            initialValue: userInfo.mobile,
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            initialValue: userInfo.email ??'name@domain.com',
                            cursorColor: Theme.of(context).primaryColor,
                            readOnly: true ,
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
                                emailAddress = newValue ?? userInfo.email;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                emailAddress = value ??userInfo.email;
                              });
                            },

                          ),
                          SizedBox(height: 16),

                          TextFormField(
                           // initialValue: _selectedDate.toString() ,
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
                                    activeColor: Theme.of(context).primaryColor,
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
                                    activeColor: Theme.of(context).primaryColor,
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
                        onPressed: () {

                          if(EditProfile._registerScreenFormKey.currentState.validate())
                            {
                              API.updatePatient(firstName, lastName, phoneNumber, emailAddress, _radioValue+1,
                                  _textEditingController.text).then((value) {
                                    if(value == 201)
                                      {
                                        print('Data has been saved successfully ');
                                        Navigator.pop(context);
                                        setState(() {
                                          AppProvider.getUserInfo() ;
                                        });
                                      }
                                    else
                                      {
                                        print('Data has been failed ');
                                        Navigator.pop(context);
                                        setState(() {

                                        });
                                      }

                              }) ;

                            }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
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
