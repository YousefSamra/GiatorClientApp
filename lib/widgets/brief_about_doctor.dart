import 'package:flutter/material.dart';
import 'package:giatroo/Models/AppProvider.dart';

class BriefAboutDoctor extends StatefulWidget {
  @override
  _BriefAboutDoctorState createState() => _BriefAboutDoctorState();
}

class _BriefAboutDoctorState extends State<BriefAboutDoctor> {
  bool _isMore = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
      padding: const EdgeInsets.all(8),
      width: size.width * 0.95,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/info.png',
                scale: 1.5,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 8),
              AppProvider.doctorInfo.detailedInfo != ''
                  ? Text(
                      'Brief about Doctor',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(height: 4),
          if (AppProvider.doctorInfo != null)
            SizedBox(
              width: size.width * 0.9,
              child: Text(
                AppProvider.doctorInfo.detailedInfo ?? '',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: _isMore ? 50 : 2,
              ),
            ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isMore = !_isMore;
              });
            },
            child: Text(
              _isMore ? 'Less' : 'More',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 12,
                decoration: TextDecoration.underline,
                decorationThickness: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
