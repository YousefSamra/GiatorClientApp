import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/screens/doctor_profile_screen2.dart';
import 'package:giatroo/screens/home_screen.dart';

class ThankYouScreen extends StatefulWidget {
  static const routeName = 'thank-you-screen';

  @override
  _ThankYouScreenState createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  int _radioValue = 0;
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffE2E5EA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Thank You'),
              leading: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, HomeScreen.routeName);
                },
              ),
            ),
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
                    const SizedBox(height: 8),
                    Image.asset('assets/images/successful.png'),
                    const SizedBox(height: 24),
                    Text(
                      'Your booking is successful',
                      style: TextStyle(color: Colors.grey[800], fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppProvider.doctorInfo.doctorName,
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    Divider(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/appointment.png',
                          color: Theme.of(context).primaryColor,
                          scale: 1.2,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppProvider.choosenTimeSlot,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppProvider.dateTimeChoosen,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/location.png',
                          color: Theme.of(context).primaryColor,
                          scale: 1.2,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SafeArea(
                              right: true,
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 84),
                                child: Text(
                                  AppProvider.doctorInfo.fullAddress,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // GestureDetector(
                            //   onTap: () {}, // open location in google map
                            //   child: Text(
                            //     'Check the map',
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       color: Theme.of(context).primaryColor,
                            //       fontWeight: FontWeight.w300,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/money.png',
                          color: Theme.of(context).primaryColor,
                          scale: 1.2,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppProvider.doctorInfo.feez,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Cash at the Clinic',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            /* SliverToBoxAdapter(
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
                    Text(
                      'Notes for the doctor (optional)',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Age',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: size.width * 0.4,
                              child: TextField(
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                    'assets/images/present-box.png',
                                    color: Colors.grey[400],
                                    scale: 1.7,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              style: TextStyle(fontSize: 12),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: 0,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text(
                                      'Male',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: 1,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text(
                                      'Female',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: size.width * 0.45,
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Symptoms',
                          style: TextStyle(fontSize: 12),
                        ),
                        TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            hintText: 'e.g. cough, back pain, etc.',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Documents',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Use images or PDF files',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        DottedBorder(
                          radius: Radius.circular(5),
                          color: Colors.grey,
                          child: SizedBox(
                            width: size.width * 0.9,
                            height: 50,
                            child: FlatButton(
                              onPressed: () {},
                              color: Colors.white,
                              child: Text(
                                'Attach files',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    SizedBox(
                      width: size.width * 0.9,
                      height: 50,
                      child: FlatButton(
                        onPressed: () {},
                        color: Colors.grey[600],
                        child: Text(
                          'Attach files',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Appointments',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
