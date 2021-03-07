import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/screens/aboutus.dart';
import 'package:giatroo/screens/contactus.dart';
import 'package:giatroo/screens/login_screen.dart';
import 'package:giatroo/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'More',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
            leading: Image.asset(
              'assets/images/settings.png',
              color: Theme.of(context).primaryColor,
              scale: 1.5,
            ),
            title: Text(
              'Settings',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, ContactUs.routeName);
            },
            leading: Image.asset(
              'assets/images/phone.png',
              color: Theme.of(context).primaryColor,
              scale: 1.5,
            ),
            title: Text(
              'Connact Us',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutUs.routeName);
            },
            leading: Image.asset(
              'assets/images/about.png',
              color: Theme.of(context).primaryColor,
              scale: 1.5,
            ),
            title: Text(
              'About Us',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              launch('https://www.facebook.com/Giatro-103795768440498/');
            },
            leading: Image.asset(
              'assets/images/facebook.png',
              // color: Theme.of(context).primaryColor,
              scale: 1.2,
            ),
            title: Text(
              'Chat with us on Facebook',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            // trailing: Icon(
            //   Icons.chevron_right,
            //   color: Theme.of(context).primaryColor,
            // ),
          ),
          Divider(),
          ListTile(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await API.logout().then((value) {
                print('logout ');
                preferences.clear();
                // Navigator.pushNamed(context, LoginScreen.routeName);
                AppProvider.userToken = "";
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
                // Navigator.push(
                //     context,
                //     new MaterialPageRoute(
                //         builder: (context) => new LoginScreen()));
              });
            },
            leading: Image.asset(
              'assets/images/log-out.png',
              color: Theme.of(context).primaryColor,
              scale: 1.5,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
