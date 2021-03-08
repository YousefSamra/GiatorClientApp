import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/screens/Reset.dart';
import 'package:giatroo/screens/home_screen.dart';
import 'package:giatroo/screens/register_screen.dart';
import 'package:giatroo/widgets/btn_social.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  String username;
  String password;
  GlobalKey<FormState> _loginScreenFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _loginScreenFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8),
                SizedBox(
                  width: size.width * 0.2,
                  child: Image.asset('assets/images/logo2.png'),
                ),
                SizedBox(height: 8),
                BtnSocial(
                  image: 'assets/images/facebook.png',
                  text: 'Connect with Facebook',
                  color: Color(0xff3B5999),
                  onPressed: () {
                    API.doLoginFacebook().then((value) {
                      if (value) {
                        print('login successed');
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      } else
                        print('login failed');
                    });
                  },
                ),
                BtnSocial(
                  image: 'assets/images/twitter.png',
                  text: 'Connect with Twitter',
                  color: Color(0xff26A6D1),
                  onPressed: () {},
                ),
                BtnSocial(
                  image: 'assets/images/google.png',
                  text: 'Connect with Google',
                  color: Color(0xffD0422A),
                  onPressed: () {
                    API.loginWithGoogle().then((value) {
                      if (value) {
                        print('login successed');
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      } else
                        print('login failed');
                    });
                  },
                ),
                SizedBox(height: 8),
                Text(
                  'Or',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: size.width * 0.7,
                  child: OutlineButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Theme.of(context).primaryColor,
                    splashColor:
                        Theme.of(context).primaryColor.withOpacity(0.3),
                    highlightColor:
                        Theme.of(context).primaryColor.withOpacity(0.3),
                    highlightedBorderColor: Theme.of(context).primaryColor,
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    child: Text('Create Account',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ),
                Text(
                  'Be creating an account you agree on the',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                GestureDetector(
                  onTap: () =>
                      launch('https://giatro.my/page/terms-and-conditions'),
                  child: Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField(
                    //   controller: userName,
                    cursorColor: Theme.of(context).primaryColor,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        'assets/images/user.png',
                        color: Colors.grey,
                        scale: 1.4,
                      ),
                      hintText: 'Phone number or Email Address',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    initialValue: null,
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    onSaved: (newValue) {
                      setState(() {
                        username = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField(
                    //  controller: passWord,
                    cursorColor: Theme.of(context).primaryColor,
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
                    textInputAction: TextInputAction.done,
                    obscureText: _obscureText,
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: size.width * 0.7,
                  child: FlatButton(
                    onPressed: () {
                      print('login start');
                      if (_loginScreenFormKey.currentState.validate()) {
                        print('login start in ');
                        API.userLogin(username, password).then((value) {
                          if (value) {
                            print('login successed');
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName);
                          } else
                            print('login failed');
                        });
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Reset.routeName);
                  },
                  child: Text(
                    'Did you forget your Password?',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//  FirebaseMessaging _firebaseMessaging;

}
