import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/screens/appoinments_screen.dart';
import 'package:giatroo/screens/more_screen.dart';
import 'package:giatroo/screens/offers_screen.dart';
import 'package:giatroo/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    SearchScreen(),
    OffersScreen(),
    AppoinmentsScreen(),
    MoreScreen(),
  ];
  @override
  void initState() {
    super.initState();
    //  if (AppProvider.newUser != 1) {
    if (AppProvider.userToken != null) AppProvider.getUserInfo();
    // AppProvider.generateSearchParamters('service_id=',2);
    // print(AppProvider.serachUrlValue);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/search.png',
                scale: 1.5,
                color: _selectedIndex == 0
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/offers.png',
                scale: 1.5,
                color: _selectedIndex == 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/appointment.png',
                scale: 1.5,
                color: _selectedIndex == 2
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: 'Appointments',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/more.png',
                scale: 1.5,
                color: _selectedIndex == 3
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: 'More',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() => _selectedIndex = index)),
    );
  }
}
