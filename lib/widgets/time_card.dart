import 'package:flutter/material.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:provider/provider.dart';

class TimeCard extends StatelessWidget {
  TimeCard(this.index);
  final index;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Provider.of<AppProvider>(context, listen: false).refreshData();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: size.width * 0.25,
      height: size.height * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(color: Colors.grey[300], width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width,
            height: 25,
            decoration: BoxDecoration(
              color: Color(0xFF0070cc),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Text(
                AppProvider.dctorSchedulingDays[this.index].dayNameDate
                        .toString() ??
                    'Tomorrow',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                ),
              ),
            ),
          ),
          AppProvider.dctorSchedulingDays[this.index].period_times != null
              ? Text(
                  '${AppProvider.dctorSchedulingDays[this.index].dayStartTime ?? '12:00'}\nTo\n${AppProvider.dctorSchedulingDays[this.index].dayEndTime ?? '01:00'}',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                )
              : Center(
                  child: Text(
                    'No available slots',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 10,
                    ),
                  ),
                ),
          Container(
            width: size.width,
            height: 30,
            decoration: BoxDecoration(
              color: AppProvider.dctorSchedulingDays[this.index].period_times !=
                      null
                  ? Color(0xFFE94C51)
                  : Colors.grey,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Text(
                'Book',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
