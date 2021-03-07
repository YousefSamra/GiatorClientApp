import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/Cities.dart';
import 'package:giatroo/screens/filtering_screen.dart';
import 'package:giatroo/screens/select_area.dart';

class SelectCity extends StatelessWidget {
  static const routeName = 'select-city-screen';
  List<Cities> cities = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Region '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: AppProvider.regions.length,
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemBuilder: (ctx, index) {
            return index == 0
                ? ListTile(
                    onTap: () {
                      AppProvider.regionId = null;
                      AppProvider.cityId = null;
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilteringScreen(),
                          ));
                    },
                    // trailing: Icon(
                    //   Icons.done_all,
                    //   color: Colors.red,
                    // ),
                    title: Text(
                      'All Regions',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                    ),
                  )
                : ListTile(
                    onTap: () async {
                      AppProvider.selectRegios =
                          AppProvider.regions[index].name;
                      AppProvider.regionId = AppProvider.regions[index].id;
                      await API
                          .getRegionCities(AppProvider.regions[index].region_id)
                          .then((value) {
                        cities.addAll(value);
                        AppProvider.allRegionCities.addAll(value);
                      }).whenComplete(() {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, SelectArea.routeName);
                      });
                    },
                    title: Text(
                      '${AppProvider.regions[index].name}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
