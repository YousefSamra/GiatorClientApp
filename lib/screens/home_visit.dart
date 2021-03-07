import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';

import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/Cities.dart';
import 'package:giatroo/Models/Regions.dart';
import 'package:giatroo/Models/Specialities.dart';
import 'package:giatroo/Models/UserInfo.dart';
import 'package:giatroo/screens/thankyou_afterhomevisit.dart';

class HomeVisitScreen extends StatefulWidget {
  static const routeName = 'home-visit-screen';

  @override
  _HomeVisitScreenState createState() => _HomeVisitScreenState();
  static GlobalKey<FormState> _registerScreenFormKey = GlobalKey<FormState>();
}

class _HomeVisitScreenState extends State<HomeVisitScreen> {
  final phoneNumberController = TextEditingController();
//  final specialityController = TextEditingController();
//  final regionController = TextEditingController();
//  final cityController = TextEditingController();

  String _choose = 'Choose Specially';
  String _region = 'Choose Region';
  String _city = 'Choose City';

  UserInfo userInfo = UserInfo();
  List<Specialaties> specialaties;
  List<Regions> regions;
  List<Cities> cities;
  String phoneNumber;
  int speciality_id = 0;
  int region_id = 0;
  int city_id = 0;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    API.getAllRegions().then((value) {
      regions = value;
    });
    API.getAllSpecialities().then((value) {
      specialaties = value;
    });
    userInfo = AppProvider.userInfo;
    // specialaties = AppProvider.allSpecialaties;
    // regions = AppProvider.allRegions;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print('regions  = ' + regions.length.toString());
    return Scaffold(
      backgroundColor: Color(0xffE1E5E8),
      appBar: AppBar(
        title: Text('Book a Home Visit'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 16),
              Image.asset(
                'assets/images/visithome.png',
                width: size.width * 0.6,
                color: Colors.grey[400],
              ),
              Text(
                'We will contact you in minutes',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: size.width * 0.95,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  key: HomeVisitScreen._registerScreenFormKey,
                  children: [
                    Text(
                      'Patient name',
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    TextField(
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        //  counterText: userInfo.firstName,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Phone',
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    TextField(
                      controller: phoneNumberController,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        hintText: 'Phone',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Specially',
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Choose Specially'),
                              content: SizedBox(
                                height: size.height * 0.8,
                                width: size.width * 0.8,
                                child: setupAlertDialoadContainer(),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: size.width * 0.9,
                        height: 30,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _choose,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              Icons.expand_more,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Region',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[700]),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Choose Region'),
                                        content: SizedBox(
                                          height: size.height * 0.8,
                                          width: size.width * 0.8,
                                          child: regionAlertDialoadContainer(),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 30,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _region,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Icon(
                                        Icons.expand_more,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'City',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[700]),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (region_id > 0) {
                                    await AppProvider.getRegionCities(
                                        region_id);
                                    cities = AppProvider.allRegionCities;
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Choose City'),
                                          content: SizedBox(
                                            height: size.height * 0.8,
                                            width: size.width * 0.8,
                                            child: cityAlertDialoadContainer(),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  height: 30,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _city,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Icon(
                                        Icons.expand_more,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              FlatButton(
                color: Color(0xffFF2727),
                height: 40,
                minWidth: size.width * 0.95,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  API
                      .orderHomeVisit(phoneNumberController.text, city_id,
                          region_id, speciality_id)
                      .then((value) {
                    if (value == 202) {
                      Navigator.pushNamed(
                          context, ThankYouAfterHomeVisit.routeName);
                    } else {
                      print('Data has been failed ');
                      Navigator.pop(context);
                      setState(() {});
                    }
                  });
                  //Navigator.pushNamed(context, ThankYouAfterHomeVisit.routeName);
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(
                width: size.width * .95,
                child: Text(
                  'We are just a proxy between you and the best doctors in the country',
                  style: TextStyle(
                    color: Color(0xff2905F8),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget setupAlertDialoadContainer() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: specialaties.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            setState(() {
              _choose = specialaties[index].name;
              speciality_id = specialaties[index].speciality_id;
            });
            Navigator.of(context).pop();
          },
          title: Text(specialaties[index].name),
        );
      },
    );
  }

  Widget regionAlertDialoadContainer() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: regions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            setState(() {
              _region = regions[index].name;
              region_id = regions[index].region_id;
            });
            Navigator.of(context).pop();
          },
          title: Text(regions[index].name),
        );
      },
    );
  }

  Widget cityAlertDialoadContainer() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cities.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            setState(() {
              _city = cities[index].name;
              city_id = cities[index].city_id;
            });
            Navigator.of(context).pop();
          },
          title: Text(cities[index].name),
        );
      },
    );
  }
}
