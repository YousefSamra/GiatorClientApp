import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/screens/choose_specialty_screen.dart';
import 'package:giatroo/screens/select_doctor_screen.dart';
import 'package:provider/provider.dart';

class BookDoctorScreen extends StatelessWidget {
  static const routeName = 'book-doctor-screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
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
              GestureDetector(
                onTap: () {
                  Provider.of<AppProvider>(context, listen: false)
                      .generateSearchParamters('service_id=', 1);
                  AppProvider.regionId = null;
                  AppProvider.cityId = null;
                  Navigator.pushNamed(context, ChooseSpecialtyScreen.routeName);
                },
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
                            'assets/images/stethoscope.png',
                            scale: 1.5,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Choose by Specialty and Area',
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
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Provider.of<AppProvider>(context, listen: false)
                      .generateSearchParamters('service_id=', 1);
                  Navigator.pushNamed(context, SelectDoctorScreen.routeName);
                },
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
                            'assets/images/nurse.png',
                            scale: 1.4,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Search by Doctor Name',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
