import 'package:flutter/material.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/widgets/about_doctor.dart';
import 'package:giatroo/widgets/brief_about_doctor.dart';
import 'package:giatroo/widgets/doctor_services.dart';
import 'package:giatroo/widgets/time_slot.dart';
import 'package:provider/provider.dart';

class DoctorProfileScreen extends StatelessWidget {
  static const routeName = 'doctor-profile-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2E5EA),
      appBar: AppBar(
        title: Text('Doctor Profile'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: AboutDoctor()),
          SliverToBoxAdapter(child: TimeSlot()),
          SliverToBoxAdapter(child: BriefAboutDoctor()),
          SliverToBoxAdapter(child: DoctorServices()),
          //  SliverToBoxAdapter(child: InsuranceCompanies()),
          // SliverToBoxAdapter(child: Reviews()),
        ],
      ),
    );
  }
}
