import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/widgets/description_dr.dart';

class AboutDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
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
              child: AppProvider.doctorInfo != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          AppProvider.doctorInfo.doctorName ?? '',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Text(
                            AppProvider.doctorInfo.detailedTitle ?? '',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 8),
                        DescriptionDr(),
                        SizedBox(height: 8),
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
                          rating: AppProvider.doctorInfo.avgDoctorRate != null
                              ? double.parse(AppProvider
                                      .doctorInfo.avgDoctorRate
                                      .toString() ??
                                  '0')
                              : 0.0,
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 25,
                          child: FlatButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Overall rating from ${AppProvider.doctorInfo.viewCount} visitors',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: size.width,
                          child: Divider(
                            color: Color(0xffF5F5F5),
                            thickness: 1,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/money.png',
                                  scale: 1.5,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Fees\n${AppProvider.doctorInfo.feez}',
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 12),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Image.asset(
                            //       'assets/images/clock.png',
                            //       scale: 1.5,
                            //       color: Theme.of(context).primaryColor,
                            //     ),
                            //     SizedBox(width: 8),
                            //     Text(
                            //       'Waiting Time\n38 Minutes',
                            //       style: TextStyle(
                            //         color: Colors.grey[700],
                            //         fontSize: 12,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                        SizedBox(height: 8),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    ),
            ),
          ),
          if (AppProvider.doctorInfo != null)
            Positioned(
              top: -size.width * 0.05,
              left: size.width / 2 - 30,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundImage: AppProvider.doctorInfo.picUrl != null
                      ? NetworkImage(AppProvider.doctorInfo.picUrl)
                      : AssetImage('assets/images/dr.png'),
                  radius: 33,
                ),
              ),
            ),
          if (AppProvider.doctorInfo != null)
            Positioned(
              left: size.width * 0.05,
              top: size.width * 0.05,
              child: Text(
                '${AppProvider.doctorInfo.viewCount} views',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
