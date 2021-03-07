import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/subSpecial.dart';
import 'package:giatroo/screens/filter_screen.dart';

class SubSpecialaties extends StatefulWidget {
  static const routeName = 'subSpecialaties-screen';
  @override
  _SubSpecialatiesState createState() => _SubSpecialatiesState();
}

class _SubSpecialatiesState extends State<SubSpecialaties> {
  Future<List<SubSpecialist>> futureSubSpecialaty;
  List<SubSpecialist> supSpecialistArr = [];
  List<bool> _checksValues = [];
  List<int> _specialitiesIds = [];
  @override
  void initState() {
    super.initState();
    AppProvider.subSpeicalitiesNames = [];
    API.getDoctorSubSpecialists(AppProvider.sepecialityId ?? 3).then((value) {
      supSpecialistArr.addAll(value);
      supSpecialistArr.forEach((element) {
        _checksValues.add(false);
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('subspecialities'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                AppProvider.subSpeicalitiesIds.addAll(_specialitiesIds);
              });
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilterScreen(),
                  ));
              setState(() {});
            },
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: supSpecialistArr.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Checkbox(
                value: _checksValues[index],
                onChanged: (value) {
                  setState(() {
                    _checksValues[index] = value;
                    if (value == true) {
                      _specialitiesIds
                          .add(supSpecialistArr[index].sub_speciality_id);
                      AppProvider.subSpeicalitiesNames
                          .add(supSpecialistArr[index].sub_speciality_name);
                    } else {
                      _specialitiesIds.removeAt(index);
                      AppProvider.subSpeicalitiesNames.removeWhere((element) =>
                          element ==
                          supSpecialistArr[index].sub_speciality_name);
                    }
                  });
                },
              ),
              onTap: () {
                setState(() {
                  AppProvider.subSpecialityId =
                      supSpecialistArr[index].sub_speciality_id;
                  AppProvider.subSpecialityName =
                      supSpecialistArr[index].sub_speciality_name;

                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterScreen(),
                      ));
                  setState(() {});
                });
              },
              title: Text(supSpecialistArr[index].sub_speciality_name),
              trailing: Icon(Icons.arrow_right),
            );
          },
        ),
      ),
    );
  }
}
