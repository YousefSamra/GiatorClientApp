import 'package:flutter/material.dart';
import 'package:giatroo/screens/change_password.dart';
import 'package:giatroo/screens/edit_profile.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = 'settings-screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          Container(
            height: 40,
            width: size.width * 0.95,
            margin: const EdgeInsets.only(top:8,right:8,left:8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProfile.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/user.png',
                        color: Theme.of(context).primaryColor,
                        scale: 1.8,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
           Container(
            height: 40,
            width: size.width * 0.95,
            margin: const EdgeInsets.only(top:8,right:8,left:8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: FlatButton(//ChangePassword
              onPressed: () {
                Navigator.pushNamed(context, ChangePassword.routeName);},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/password.png',
                        color: Theme.of(context).primaryColor,
                        scale: 1.8,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Change Password',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
           Container(
            height: 40,
            width: size.width * 0.95,
            margin: const EdgeInsets.only(top:8,right:8,left:8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: FlatButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/credit-card.png',
                        color: Theme.of(context).primaryColor,
                        scale: 1.8,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Manage Credit Cards',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
