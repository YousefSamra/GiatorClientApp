import 'package:flutter/material.dart';
import 'package:giatroo/Models/AppProvider.dart';

class DescriptionDr extends StatefulWidget {
  @override
  _DescriptionDrState createState() => _DescriptionDrState();
}

class _DescriptionDrState extends State<DescriptionDr> {
  bool _isMore = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          width: size.width * 0.8,
          child: Text(
            AppProvider.doctorInfo.detailedInfo ?? '',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
            maxLines: _isMore ? 50 : 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
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
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationThickness: 1,
            ),
          ),
        ),
      ],
    );
  }
}
