import 'package:flutter/material.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/widgets/choose_time.dart';
import 'package:giatroo/widgets/time_slot.dart';
import 'package:provider/provider.dart';

class ChooseTimeSlotScreen extends StatelessWidget {
  static const routeName = 'choose-time-slot-screen';
  AppProvider appProvider = AppProvider();
  @override
  Widget build(BuildContext context) {
    // print('choose time slots = ${AppProvider.dctorSchedulingDays.length}');
    // TimeSlot args = ModalRoute.of(context).settings.arguments;
    //
    // print(index ?? '0');
    return Scaffold(
      backgroundColor: const Color(0xffE2E5EA),
      appBar: AppBar(
        title: Text('Choose a time slot'),
      ),
      body: ListView.builder(
        itemCount: AppProvider.dctorChoosenTimeSlots.length,
        itemBuilder: (context, index) {
          AppProvider.dctorChoosenTimeSlots
              .retainWhere((element) => element.period_times != null);
          return index < AppProvider.dctorChoosenTimeSlots.length
              ? ChooseTime(AppProvider.dctorChoosenTimeSlots[index].id)
              : Container();
        },
      ),
    );
  }
}
