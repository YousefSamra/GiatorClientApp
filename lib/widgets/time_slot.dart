import 'package:flutter/material.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/screens/choose_time_slot_screen.dart';
import 'package:giatroo/widgets/time_card.dart';
import 'package:provider/provider.dart';

class TimeSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.95,
      margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          if (AppProvider.doctorInfo != null)
            Row(
              children: [
                Image.asset(
                  'assets/images/location.png',
                  color: Theme.of(context).primaryColor,
                  scale: 1.5,
                ),
                SizedBox(width: 8),
                Text(
                  AppProvider.doctorInfo.fullAddress ?? '',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          SizedBox(height: 4),
          if (AppProvider.dctorSchedulingDays.length > 0)
            SizedBox(
              width: size.width * 0.9,
              child: Text(
                'Book now and you will receive full address details and clinic number',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
            ),
          SizedBox(height: 8),
          if (AppProvider.dctorSchedulingDays.length > 0)
            SizedBox(
              height: size.height * 0.2,
              child: AppProvider.dctorSchedulingDays != null
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: AppProvider.dctorSchedulingDays.length ?? 0,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            // Provider.of<AppProvider>(context, listen: false)
                            //     .setIndexTimeSlot(index);

                            if (AppProvider
                                    .dctorSchedulingDays[index].period_times !=
                                null) {
                              AppProvider.dctorChoosenTimeSlots = [];
                              AppProvider.dctorChoosenTimeSlots
                                  .addAll(AppProvider.dctorSchedulingDays);
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, ChooseTimeSlotScreen.routeName);
                            }
                          },
                          child: index < AppProvider.dctorSchedulingDays.length
                              ? TimeCard(index)
                              : Container(),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    ),
            ),
          if (AppProvider.dctorSchedulingDays.length > 0) SizedBox(height: 32),
          if (AppProvider.dctorSchedulingDays.length > 0)
            Text(
              'Time slot reservation',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
