import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const routeName = 'about-us-screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF0063b3),
      appBar: AppBar(title: Text('About Us')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: size.width * 0.4,
              child: Image.asset('assets/images/logo2.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: size.width * 0.9,
              child: Center(
                child: Text(
                  "Giatro ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    wordSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: size.width * 0.9,
              child: Text(
                "Giatro.my is the leading digital healthcare booking platform and practice management software in Malaysia. We are pioneering the shift to automated physician, nurse and clinic bookings making healthcare easily accessible in the region.With verified reviews, patients are able to search, compare, and book the best doctors in just 1 minute.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: size.width * 0.9,
              child: Text(
                "Doctors also provide Patients with seamless healthcare experiences through our clinic management software.We strive to lead every aspect of the healthcare industry and continue to launch products that have positive impact on people’s lives.Contact Us.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
