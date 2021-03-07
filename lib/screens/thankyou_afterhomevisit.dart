import 'package:flutter/material.dart';

class ThankYouAfterHomeVisit extends StatelessWidget {
  static const routeName = 'ThankYouAfterHomeVisit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thank You'),),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 16),
            Image.asset('assets/images/successful.png'),
            SizedBox(height: 16),
            Text('We will contact you soon',style: TextStyle(color: Color(0xff3BB54A),fontSize: 16),)
          ],
        ),
      ),
    );
  }
}