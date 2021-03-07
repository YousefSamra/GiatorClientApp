import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = 'change-password';

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
  static GlobalKey<FormState> _changePassScreenFormKey = GlobalKey<FormState>();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureText = true;
  String newPass ;
  String oldPass ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Form(
        key: ChangePassword._changePassScreenFormKey,
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
              'Change Password',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please, enter the new password',
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
                        hintText: 'Old Password',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: _obscureText,
                      onSaved: (newValue) {
                        setState(() {
                          oldPass= newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextFormField(
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
                        hintText: 'New Password',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: _obscureText,
                      onSaved: (newValue) {
                        setState(() {
                          newPass= newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  FlatButton(
                    onPressed: () {

                     if(ChangePassword._changePassScreenFormKey.currentState.validate())
                       {
                         API.changePassword(oldPass, newPass).then((value) {
                           print('password has been changes successfully ');
                         });
                       }
                    },
                    height: 30,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    minWidth: MediaQuery.of(context).size.width * 0.3,
                    color: Theme.of(context).primaryColor,

                    child: Text(
                      'Confirm',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
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
