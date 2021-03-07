import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/screens/choose_specialty_screen.dart';
import 'package:giatroo/screens/filtering_screen.dart';
import 'package:giatroo/screens/offers_screen.dart';

class SelectArea extends StatelessWidget {
  static const routeName = 'select-area-screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Area'),
      ),
      body: Column(
        children: [
          /*Container(
            width: size.width,
            height: 70,
            color: Color(0xffFAFAFA),
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              //controller: _controller,
              cursorColor: Theme.of(context).primaryColor,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Type City Name',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            ),
          ),*/
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppProvider.allRegionCities.length > 0
                  ? ListView.separated(
                      itemCount: AppProvider.allRegionCities.length,
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemBuilder: (ctx, index) {
                        return index == 0
                            ? ListTile(
                                onTap: () {
                                  AppProvider.cityId = 0;
                                  if (AppProvider.startedScreen ==
                                      'filteringdoctorSearch') {
                                    //  Navigator.pop(context);
                                    Navigator.pop(context);
                                    //   Navigator.pop(context);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FilteringScreen(),
                                        ));
                                  }
                                  if (AppProvider.startedScreen ==
                                      'doctorSearch') {
                                    print('doctorSearch == ' +
                                        AppProvider.selectRegios);
                                    Navigator.pop(context);
                                    // Navigator.pop(context);

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChooseSpecialtyScreen(),
                                        ));
                                  }
                                  if (AppProvider.startedScreen ==
                                      'offersSearch') {
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OffersScreen(),
                                        ));
                                  }
                                  //  Navigator.pop(context);
                                },
                                // trailing: Icon(
                                //   Icons.location_searching_sharp,
                                //   color: Colors.red,
                                // ),
                                title: Text(
                                  'All Cities',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : ListTile(
                                onTap: () {
                                  AppProvider.cityId = AppProvider
                                      .allRegionCities[index].city_id;
                                  if (AppProvider.startedScreen ==
                                      'filteringdoctorSearch') {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    //   Navigator.pop(context);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FilteringScreen(),
                                        ));
                                  }
                                  if (AppProvider.startedScreen ==
                                      'doctorSearch') {
                                    print('doctorSearch == ' +
                                        AppProvider.selectRegios);
                                    Navigator.pop(context);
                                    // Navigator.pop(context);

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChooseSpecialtyScreen(),
                                        ));
                                  }
                                  if (AppProvider.startedScreen ==
                                      'offersSearch') {
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OffersScreen(),
                                        ));
                                  }
                                },
                                title: Text(
                                  '${AppProvider.allRegionCities[index].name}',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 12,
                                  ),
                                ),
                              );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
