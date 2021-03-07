import 'package:flutter/material.dart';
import 'package:giatroo/Models/AppProvider.dart';

class MoreServicesScreen extends StatelessWidget {
  static const routeName = 'more-services-screen';

  /* [
    'Ortho',
    'Bones',
    'Fractures',
    'Knee Injuries',
    'Athlete\'s Foot',
    'Knee Replacment',
    'Hip Replacment',
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor's Services"),
      ),
      body: Wrap(
        children: AppProvider.remainsdDoctorServices
            .map((item) => _cardTextService(item.serviceName))
            .toList()
            .cast<Widget>(),
      ),
    );
  }

  Widget _cardTextService(text) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFF0070cc),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
