import 'package:flutter/material.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/services.dart';
import 'package:giatroo/screens/more_services_screen.dart';

class DoctorServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var serviceWidgets = List<Widget>();
    int serviceCoumt = 0;
    for (var service in AppProvider.doctorServices) {
      serviceCoumt++;
      if (serviceCoumt <= 4)
        serviceWidgets.add(_cardTextService(service.serviceName));
      else
        AppProvider.remainsdDoctorServices.add(service);
    }
    serviceWidgets.add(GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MoreServicesScreen.routeName);
      },
      child: AppProvider.doctorServices.length > 4
          ? _cardTextService('+' + (serviceCoumt - 4).toString())
          : Container(),
    ));

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
                'assets/images/stethoscope.png',
                scale: 1.5,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 8),
              Text(
                "Doctor's Services",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Wrap(
            children: serviceWidgets,
          ),
        ],
      ),
    );
  }

  Widget _cardTextService(text) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFF0070cc), //0xff1BC0A0
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
