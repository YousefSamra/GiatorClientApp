import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/DoctorInfo.dart';
import 'package:giatroo/screens/doctor_profile_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CardSearch extends StatelessWidget {
  CardSearch(this.index);

  final int index;
  AppProvider appProvider = AppProvider();
  _doAnyThing() {
    appProvider.updListDocsIndex();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () async {
        DoctorInfo doctorInfo = DoctorInfo(
            id: AppProvider.doctorsInfo[this.index].doctorId,
            avgDoctorRate: AppProvider.doctorsInfo[this.index].avgDoctorREate,
            fullAddress: AppProvider.doctorsInfo[this.index].fullAddress,
            doctorRegistration: null,
            doctorName: AppProvider.doctorsInfo[this.index].fullName,
            detailedInfo: null,
            detailedTitle: AppProvider.doctorsInfo[this.index].detailedTitle,
            clinicPhone: null,
            viewCount: 0,
            feez: AppProvider.doctorsInfo[this.index].fees,
            picUrl: AppProvider.doctorsInfo[this.index].picUrl);
        AppProvider.doctorInfo = doctorInfo;

        await Provider.of<AppProvider>(context, listen: false)
            .getDocsWorksDays()
            .then((value) {
          Provider.of<AppProvider>(context, listen: false)
              .getDocotrServices()
              .whenComplete(() {
            Navigator.pop(context);
            Navigator.pushNamed(context, DoctorProfileScreen.routeName);
          });
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Column(
          children: [
            Container(
              width: size.width,
              padding: const EdgeInsets.all(8),
              color: Color(0xffF6F6F6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage: AppProvider.doctorsInfo != null
                          ? NetworkImage(
                              AppProvider.doctorsInfo[this.index].picUrl)
                          : AssetImage('assets/images/dr.png'),
                      radius: 28,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        AppProvider.doctorsInfo[this.index].fullName ?? '',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SafeArea(
                        right: true,
                        child: SizedBox(
                          width: size.width * 0.65,
                          child: Text(
                            AppProvider.doctorsInfo[this.index].speciality ??
                                '',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 9,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      RatingBarIndicator(
                        unratedColor: Colors.grey,
                        itemBuilder: (context, index) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        },
                        itemCount: 5,
                        itemSize: 15.0,
                        rating: AppProvider.doctorInfo != null
                            ? AppProvider.doctorInfo.avgDoctorRate != null
                                ? double.parse(AppProvider
                                        .doctorInfo.avgDoctorRate
                                        .toString() ??
                                    '0')
                                : 0.0
                            : 0.0,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppProvider.doctorsInfo[this.index].speciality ?? '',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ],
              ),
            ),
            details(
              context: context,
              icon: 'assets/images/stethoscope.png',
              text: AppProvider.doctorsInfo[this.index].detailedTitle ?? '',
            ),
            details(
              context: context,
              icon: 'assets/images/location.png',
              text: AppProvider.doctorsInfo[this.index].fullAddress ?? '',
            ),
            details(
              context: context,
              icon: 'assets/images/money.png',
              text: AppProvider.doctorsInfo[this.index].fees.toString() + '\$',
            ),
//            details(
//              context: context,
//              icon: 'assets/images/clock.png',
//              text: 'Waiting Time : 38 Minutes',
//            ),
            SizedBox(
              width: size.width,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.75,
                      height: 30,
                      color: Color(0xffF6F6F6),
                      child: Center(
                        child: Text(
                          AppProvider.doctorsInfo[this.index].availability ??
                              '',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: size.width * 0.15,
                        height: 30,
                        color: const Color(0xffDF2329),
                        child: const Center(
                          child: Text(
                            'Book',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget details({BuildContext context, icon, text}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      width: size.width,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                color: Theme.of(context).primaryColor,
                scale: 1.8,
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: size.width * .85,
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
