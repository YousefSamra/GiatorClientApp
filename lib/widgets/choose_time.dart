import 'dart:math';

import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/DoctorScheduling.dart';
import 'package:giatroo/Models/PeriodsTimes.dart';
import 'package:giatroo/screens/confirmation_screen.dart';
import 'package:provider/provider.dart';

class ChooseTime extends StatefulWidget {
  final String day;
  ChooseTime([this.day]);

  @override
  _ChooseTimeState createState() => _ChooseTimeState();
}

class _ChooseTimeState extends State<ChooseTime> {
  var _expanded = false;
  Future<List<DoctorScheduling>> doctorScheduling;
  List<Map<String, dynamic>> periodTimes = [];
  Set<PeriodTimes> periodTimesArr = {};
  Set<PeriodTimes> periodTimesArr2 = {};
  AppProvider appProvider = AppProvider();
  //  List<String> _listTimes = [] ;

  var timeSlots = List();

  @override
  void initState() {
    super.initState();
    AppProvider.periodTimes = [];
    API.getDocScheduling(AppProvider.doctorInfo.id).then((value) {
      value.forEach((schedule) {
        if (schedule.period_times != null) {
          timeSlots = schedule.period_times;
          timeSlots.forEach((element) {
            PeriodTimes periodTimes = PeriodTimes(
                id: element["id"],
                start_time_am: element["values"]["start_time_am"],
                end_time_am: element["values"]["end_time_am"],
                end_time: element["values"]["end_time"],
                status: element["values"]["status"],
                date: schedule.id);
            periodTimesArr.add(periodTimes);
            AppProvider.periodTimes.add(periodTimes);
            print(AppProvider.periodTimes.length.toString());
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          child: Center(
            child: Container(
              width: size.width * 0.95,
              height: 60,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(_expanded ? 0 : 5),
                  bottomRight: Radius.circular(_expanded ? 0 : 5),
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: 0.0,
                    child: Icon(Icons.chevron_right),
                  ),
                  Text(
                    widget.day,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_expanded)
          Container(
            width: size.width * 0.95,
            //height: size.height * 0.33,
            height:
                min(periodTimesArr.length * 35.0, periodTimesArr.length * 34.0),
            margin: const EdgeInsets.only(top: 1),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: GridView.builder(
              itemCount: periodTimesArr.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (1 / 0.4),
              ),
              itemBuilder: (ctx, index) {
                print(widget.day);

                periodTimesArr
                    .retainWhere((element) => element.date == widget.day);

                return index < periodTimesArr.length
                    ? _cardTextService(
                        periodTimesArr.toList()[index].start_time_am,
                        periodTimesArr.toList()[index].date,
                        AppProvider.dctorChoosenTimeSlots[index].dayName)
                    : Container();
              },
            ),
          ),
      ],
    );
  }

  Widget _cardTextService(time, date, dayname) {
    return GestureDetector(
      onTap: () {
        AppProvider.dateTimeChoosen = widget.day + ' ' + dayname;
        AppProvider.choosenTimeSlot = time;
        Navigator.pop(context);
        Navigator.pushNamed(context, ConfirmationScreen.routeName);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 8, right: 4, left: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFF0070cc),
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
