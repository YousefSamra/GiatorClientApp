import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:giatroo/Models/AppProvider.dart';

class PatientWidget extends StatefulWidget {
  @override
  _PatientWidgetState createState() => _PatientWidgetState();
}

class _PatientWidgetState extends State<PatientWidget> {
  bool _checkbox = false;
  TextEditingController _addressController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  GlobalKey<FormState> _patientBookKey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _patientBookKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _patientBookKey,
      child: Container(
        width: size.width * 0.95,
        margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/user.png',
                    color: Theme.of(context).primaryColor,
                    scale: 1.2,
                  ),
                  Container(
                    width: 0.4,
                    color: Colors.black,
                    margin: const EdgeInsets.only(right: 8, left: 8),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _checkbox,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (value) {
                              setState(() {
                                _checkbox = value;
                                AppProvider.isPatient =
                                    _checkbox == true ? 1 : 0;
                              });
                            },
                          ),
                          SizedBox(
                            width: size.width * 0.6,
                            child: Text(
                              'I am booking on behalf of another patient',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.35,
                            child: TextFormField(
                              //   controller: _firstNameController,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                  'assets/images/user.png',
                                  color: Colors.grey,
                                  scale: 1.4,
                                ),
                                hintText: 'First Name',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                AppProvider.patientFirstName = value;
                              },
                              onSaved: (newValue) {
                                setState(() {
                                  //_firstNameController.text = newValue;
                                  AppProvider.patientFirstName = newValue;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.35,
                            child: TextFormField(
                              // controller: _lastNameController,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                  'assets/images/user.png',
                                  color: Colors.grey,
                                  scale: 1.4,
                                ),
                                hintText: 'Last Name',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                AppProvider.patientLastName = value;
                              },
                              onSaved: (newValue) {
                                setState(() {
                                  //  _lastNameController.text = newValue;
                                  AppProvider.patientFirstName = newValue;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            hintText: ' Address ',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            prefixIcon: Image.asset(
                              'assets/images/location.png',
                              color: Colors.grey,
                              scale: 1.5,
                            ),
                          ),
                          onChanged: (value) {
                            AppProvider.patientAddress = value;
                          },
                          onSaved: (newValue) {
                            setState(() {
                              _addressController.text = newValue;
                              AppProvider.patientAddress = newValue;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
