import 'package:flutter/material.dart';
import 'package:giatroo/screens/doctor_profile_screen.dart';
import 'package:giatroo/screens/filter_screen.dart';
import 'package:giatroo/screens/filtering_screen.dart';
import 'package:giatroo/screens/home_screen.dart';
import 'package:giatroo/screens/thankyou_screen.dart';
import 'package:giatroo/widgets/choose_insurance_widget.dart';
import 'package:giatroo/widgets/choose_time.dart';
import 'package:giatroo/widgets/patient_widget.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';

class ConfirmationScreen extends StatelessWidget {
  static const routeName = 'confirmation-screen';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffE2E5EA),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Confirmation'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _NameAndPhoto(context, AppProvider.doctorInfo.picUrl),
          ),
          SliverToBoxAdapter(child: PatientWidget()),
          SliverToBoxAdapter(
            child: Container(
              width: size.width * 0.95,
              margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/calendar2.png',
                          color: Theme.of(context).primaryColor,
                          scale: 1.2,
                        ),
                        Container(
                          width: 0.4,
                          color: Colors.black,
                          margin: const EdgeInsets.only(right: 8, left: 8),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              AppProvider.choosenTimeSlot ?? '0:00 PM',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 8),
                            if (AppProvider.dateTimeChoosen != null)
                              Text(
                                AppProvider.dateTimeChoosen,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 12,
                                ),
                              ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.4,
                    color: Colors.grey,
                    margin: const EdgeInsets.only(
                        right: 20, left: 20, top: 16, bottom: 16),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/location.png',
                          color: Theme.of(context).primaryColor,
                          scale: 1.2,
                        ),
                        Container(
                          width: 0.4,
                          color: Colors.black,
                          margin: const EdgeInsets.only(right: 8, left: 8),
                        ),
                        Column(
                          children: [
                            if (AppProvider.doctorInfo.fullAddress != null)
                              Text(
                                AppProvider.doctorInfo.fullAddress,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 12,
                                ),
                              ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //     SliverToBoxAdapter(child: ChooseInsuranceWidget()),
          SliverToBoxAdapter(
            child: Container(
              width: size.width * 0.95,
              margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/money.png',
                      color: Theme.of(context).primaryColor,
                      scale: 1.2,
                    ),
                    Container(
                      width: 0.4,
                      color: Colors.black,
                      margin: const EdgeInsets.only(right: 8, left: 8),
                    ),
                    SizedBox(
                      width: size.width * 0.65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fees',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            AppProvider.doctorInfo.feez ?? ' ',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: size.width * .95,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                  child: FlatButton(
                    onPressed: () async {
                      String date = AppProvider.dateTimeChoosen
                          .toString()
                          .replaceAll(RegExp(r'[a-z]'), '')
                          .trimRight();

                      String time = AppProvider.choosenTimeSlot
                          .toString()
                          .replaceAll(RegExp(r'[a-zA-Z]'), '')
                          .trimRight();

                      var status = await API.bookAnAppointment(
                          AppProvider.doctorInfo.id,
                          1,
                          date,
                          time,
                          AppProvider.isPatient,
                          AppProvider.patientFirstName,
                          AppProvider.patientLastName,
                          1,
                          AppProvider.patientAddress);

                      if (status.status != "error" && status.status != null) {
                        Navigator.popAndPushNamed(
                            context, ThankYouScreen.routeName);
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(status.status ?? "UNKOWN ERROR!..."),
                              content: Text(status.message ??
                                  'UnExpected Response Error :Missing Data '),
                              actions: [
                                FlatButton(
                                  textColor: Color(0xFF6200EE),
                                  onPressed: () {
                                    Navigator.pop(context);

                                    Navigator.popAndPushNamed(
                                        context, FilteringScreen.routeName);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _NameAndPhoto(BuildContext context, image) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: size.width * 0.95,
              margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Text(
                    AppProvider.doctorInfo.doctorName,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: size.width * 0.8,
                    child: Text(
                      AppProvider.doctorInfo.detailedTitle,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Positioned(
            top: -size.width * 0.05,
            left: size.width / 2 - 30,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundImage: image != null
                    ? NetworkImage(image)
                    : AssetImage('assets/images/dr.png'),
                radius: 33,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
