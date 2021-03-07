import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/DoctorRate.dart';
import 'package:giatroo/screens/filtering_screen.dart';
import 'package:giatroo/screens/select_doctor_screen.dart';
import 'package:giatroo/widgets/about_doctor.dart';
import 'package:giatroo/widgets/brief_about_doctor.dart';
import 'package:giatroo/widgets/doctor_services.dart';
import 'package:giatroo/widgets/time_slot.dart';
import 'package:provider/provider.dart';

class DoctorProfileScreen extends StatefulWidget {
  static const routeName = 'doctor-profile-screen';

  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  bool showReview = false;
  List<DoctorRate> doctorRate = [];
  @override
  void initState() {
    super.initState();
    // if (AppProvider.startFrom == 'Offers') {
    //   AppProvider.doctorsInfo.retainWhere((element) {
    //     if (element.doctorId == AppProvider.doctorId) return true;
    //   });
    // }

    // AppProvider.doctorInfo.id = AppProvider.doctorId;

    // AppProvider.doctorsInfo
    //     .retainWhere((element) => element.doctorId == AppProvider.doctorId);
    // Provider.of<AppProvider>(context, listen: false).refreshData();

    API.getDoctorsRates(AppProvider.doctorId).then((value) {
      doctorRate.addAll(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xffE2E5EA),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                if (AppProvider.pushedFrom == 'SearchByArea') {
                  Navigator.pushNamed(context, FilteringScreen.routeName);
                } else {
                  Navigator.pushNamed(context, SelectDoctorScreen.routeName);
                }
              },
            ),
            title: Text('Doctor Profile'),
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: AboutDoctor()),
              SliverToBoxAdapter(child: TimeSlot()),
              if (AppProvider.doctorInfo.detailedInfo.toString().length > 5)
                SliverToBoxAdapter(child: BriefAboutDoctor()),
              if (AppProvider.doctorServices.length > 0)
                SliverToBoxAdapter(child: DoctorServices()),
              //    SliverToBoxAdapter(child: InsuranceCompanies()),
              SliverToBoxAdapter(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showReview = !showReview;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(8),
                        width: size.width,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_half_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Reviews",
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showReview = !showReview;
                                    });
                                  },
                                  child: Text(
                                    'See all',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: size.height * 0.15,
                              child: ListView.builder(
                                itemCount: doctorRate.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  return _CardReview(context, index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ))),
            ],
          ),
        ),
        if (showReview)
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showReview = !showReview;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 8),
                  color: Colors.black.withOpacity(0.8),
                  child: Center(
                      child: SizedBox(
                    child: SizedBox(
                      height: size.height * 0.2,
                      child: ListView.builder(
                        itemCount: doctorRate.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return _CardReview(context, index);
                        },
                      ),
                    ),
                  )),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _CardReview(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.6,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey[200],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: RatingBarIndicator(
              itemCount: doctorRate.length,
              rating: double.parse(doctorRate[index].rating),
              itemBuilder: (context, index) {
                return Icon(
                  Icons.star,
                  color: Colors.amber,
                );
              },
            ),
          ),
          SizedBox(height: 8),
          Text(
            doctorRate[index].comment,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          SizedBox(height: 8),
          doctorRate[index].patient_first_name != null
              ? Text(
                  doctorRate[index].patient_first_name,
                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                )
              : Text(''),
          doctorRate[index].booking_date != null
              ? Text(
                  '02 January 2021',
                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                )
              : Text(''),
        ],
      ),
    );
  }
}
