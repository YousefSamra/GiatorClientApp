import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/screens/book_doctor.dart';
import 'package:giatroo/screens/home_visit.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.4,
                child: Image.asset('assets/images/logo2.png'),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Future of Heathcare',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16),
              containerBtn(
                context: context,
                icon: 'assets/images/stethoscope.png',
                text: 'Book a Doctor Appointment',
                onTap: () {
                  API.getAllSpecialities().then((value) {
                    print(value.length);
                    AppProvider.allSpecialaties = value;
                    AppProvider appProvider = AppProvider();
                    appProvider.refreshData();
                    Navigator.pushNamed(context, BookDoctorScreen.routeName);
                  });
                },
              ),
              SizedBox(height: 16),
              containerBtn(
                context: context,
                icon: 'assets/images/phone.png',
                text: 'Book a Teleconsultation',
                onTap: () {},
              ),
              SizedBox(height: 16),
              containerBtn(
                context: context,
                icon: 'assets/images/icons/surgery.png',
                text: 'Book a Service or Operation',
                onTap: () {},
              ),
              SizedBox(height: 16),
              containerBtn(
                context: context,
                icon: 'assets/images/home.png',
                text: 'Book A Home Visit',
                onTap: () {
                  Navigator.pushNamed(context, HomeVisitScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget containerBtn({onTap, BuildContext context, icon, text}) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 16),
                Image.asset(
                  icon,
                  scale: 1.4,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.chevron_right,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
