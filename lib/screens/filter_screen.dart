import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/avaiability.dart';
import 'package:giatroo/Models/feesRange.dart';
import 'package:giatroo/Models/genders.dart';
import 'package:giatroo/Models/titles.dart';
import 'package:giatroo/screens/subSpecialaties.dart';
import 'package:giatroo/Models/AppProvider.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = 'filter-screen';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool checkedValue = false;
  bool isSwitched = false;
  List<int> avaliabilityValue = [0, 1, 1];
  List<bool> gendersOptions = [false, false];
  List<bool> titlesOptions = [false, false, false, false];
  double _minValue = 0;

  double _value = 1500;
  double _maxvalue = 1500;

  bool _looading = true;
  int selectedAvaliability = 0;
  List<FeesRange> feesRages = [];
  List<Genders> genders = [];
  List<Titles> titles = [];
  List<Avaliability> valiabilaties = [];
  void _handleRadioValueChange(int index) {
    setState(() {
      // avaliabilityValue[index] = value;
      switch (index) {
        case 0:
          avaliabilityValue = [0, 1, 1];
          selectedAvaliability = index;
          break;
        case 1:
          avaliabilityValue = [1, 0, 1];
          selectedAvaliability = index;
          break;
        case 2:
          avaliabilityValue = [1, 1, 0];
          selectedAvaliability = index;
          break;
      }
    });
    // Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    print('test');
    genders = [];
    feesRages = [];
    titles = [];
    AppProvider.titlesIds = [];
    AppProvider.gendersSelections = [];
    _loadingData();
  }

  void _loadingData() {
    API.getfeesFilters().then((value) {
      setState(() {
        var minFees = value[1]
            .description
            .toString()
            .replaceAll(RegExp(r'[a-zA-Z]'), '')
            .trimRight();
        _minValue = double.parse(minFees);

        var maxFees = value[value.length - 1]
            .description
            .toString()
            .replaceAll(RegExp(r'[a-zA-Z]'), '')
            .trimRight();
        _maxvalue = double.parse(maxFees);

        feesRages.addAll(value);
      });
    });

    API.getgenderFilter().then((value) {
      genders.addAll(value);
      AppProvider.genders.addAll(value);
      _looading = false;
      setState(() {});
    });

    API.getTitlesFilter().then((value) {
      titles.addAll(value);
      _looading = false;
      // titles.forEach((element) {
      //   AppProvider.titlesIds.add(element.id);
      // });
      setState(() {});
    }).then((value) {
      API.getAvaliabilityFilter().then((value) {
        valiabilaties.addAll(value);

        _looading = false;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text(
          'Filter',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              setState(() {
                checkedValue = false;
                isSwitched = false;
                _value = 0;
                genders = [];
                feesRages = [];
                titles = [];
                AppProvider.titlesIds = [];
                AppProvider.gendersSelections = [];
                valiabilaties = [];
                AppProvider.subSpeicalitiesNames = [];
                AppProvider.subSpeicalitiesIds = [];
                _looading = false;
                _loadingData();
              });
            },
            child: Text(
              'RESET',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 16),
                Container(
                  width: size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Doctor Sub Specialties',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8, top: 8),
                        child: Wrap(
                          // direction: Axis.vertical,
                          children: [
                            AppProvider.subSpeicalitiesNames.length != 0
                                ? SizedBox(
                                    height: 150,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 0.1,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 0.02,
                                              mainAxisSpacing: 0.03),
                                      reverse: true,

                                      //  scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: AppProvider
                                              .subSpeicalitiesNames.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                SubSpecialaties.routeName);
                                            setState(() {});
                                          },
                                          title: Chip(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            label: Text(
                                              AppProvider.subSpeicalitiesNames[
                                                      index] ??
                                                  'Doctor Sub Specialties',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : FlatButton(
                                    child: Text('Choose Sub Spacielaties'),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, SubSpecialaties.routeName);
                                      setState(() {});
                                    },
                                  )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                /*Container(
                  width: size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Examination Fees',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 8, top: 8),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${_minValue.toInt()} \$',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '${_maxvalue.toInt()} \$',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.8),
                                  inactiveTrackColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2),
                                  trackShape: RectangularSliderTrackShape(),
                                  trackHeight: 4.0,
                                  thumbColor: Colors.white,
                                  thumbShape: RoundSliderThumbShape(
                                      elevation: 2, enabledThumbRadius: 12.0),
                                  overlayColor: Colors.green.withAlpha(32),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 28.0),
                                ),
                                child: Slider(
                                  min: 0,
                                  max: 1500,
                                  divisions: null,
                                  value: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 16),*/
                Container(
                  width: size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Availability',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      if (_looading == false)
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 8),
                            child: valiabilaties.length > 0
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                              value: 0,
                                              groupValue: avaliabilityValue[0],
                                              onChanged: ((newValue) {
                                                _handleRadioValueChange(0);
                                              })),
                                          Text(
                                            valiabilaties[0].name,
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                              value: 0,
                                              groupValue: avaliabilityValue[1],
                                              onChanged: ((newValue) {
                                                _handleRadioValueChange(1);
                                              })),
                                          Text(
                                            valiabilaties[1].name,
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                              value: 0,
                                              groupValue: avaliabilityValue[2],
                                              onChanged: ((newValue) {
                                                _handleRadioValueChange(2);
                                              })),
                                          Text(
                                            valiabilaties[2].name,
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: SpinKitFadingCircle(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                          ),
                        )
                      else
                        Center(
                          child: SpinKitFadingCircle(
                            color: Colors.blueAccent,
                          ),
                        ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Gender',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      if (_looading != true)
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 8),
                            child: genders.length > 0
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: gendersOptions[0],
                                            onChanged: (newValue) {
                                              setState(() {
                                                gendersOptions[0] = newValue;
                                                if (newValue == true)
                                                  AppProvider.gendersSelections
                                                      .add(2);
                                              });
                                            },
                                          ),
                                          Text(
                                            genders[1].name,
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: gendersOptions[1],
                                            onChanged: (newValue) {
                                              setState(() {
                                                gendersOptions[1] = newValue;
                                                if (newValue == true)
                                                  AppProvider.gendersSelections
                                                      .add(1);
                                              });
                                            },
                                          ),
                                          Text(
                                            genders[0].name,
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 4),
                                    ],
                                  )
                                : Center(
                                    child: SpinKitFadingCircle(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                          ),
                        )
                      else
                        Center(
                          child: SpinKitFadingCircle(
                            color: Colors.blueAccent,
                          ),
                        ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Title',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 8, top: 8),
                          child: _looading != true && titles.length > 0
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: titlesOptions[0],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  titlesOptions[0] = newValue;
                                                  if (newValue = true) {
                                                    AppProvider.titlesIds
                                                        .add(titles[0].id);
                                                  }
                                                });
                                              },
                                            ),
                                            Text(
                                              titles[0].name,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: titlesOptions[1],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  titlesOptions[1] = newValue;
                                                  if (newValue = true) {
                                                    AppProvider.titlesIds
                                                        .add(titles[1].id);
                                                  }
                                                });
                                              },
                                            ),
                                            Text(
                                              titles[1].name,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 4),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: titlesOptions[2],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  titlesOptions[2] = newValue;
                                                  if (newValue = true) {
                                                    AppProvider.titlesIds
                                                        .add(titles[2].id);
                                                  }
                                                });
                                              },
                                            ),
                                            Text(
                                              titles[3].name,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: titlesOptions[3],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  titlesOptions[3] = newValue;
                                                  if (newValue = true) {
                                                    AppProvider.titlesIds
                                                        .add(titles[3].id);
                                                  }
                                                });
                                              },
                                            ),
                                            Text(
                                              titles[4].name,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 4),
                                      ],
                                    ),
                                  ],
                                )
                              : Center(
                                  child: SpinKitFadingCircle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xffF5F5F5),
            padding: const EdgeInsets.all(8),
            child: FlatButton(
              minWidth: size.width * 0.95,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onPressed: () async {
                print(avaliabilityValue.length.toString());

                List parameters = [];
                parameters.add(
                    'speciality_id=' + AppProvider.sepecialityId.toString());
                String subSpec = "";
                if (AppProvider.subSpeicalitiesIds.length > 0) {
                  AppProvider.subSpeicalitiesIds.forEach((element) {
                    subSpec = 'sub_specialities_ids[${element.toString()}]=' +
                        element.toString() +
                        '&';
                  });

                  parameters.add(subSpec.substring(0, subSpec.length - 1));
                } else
                  parameters.add('sub_specialities_ids[]=');
                if (AppProvider.regionId != null)
                  parameters.add('region_id' + AppProvider.regionId.toString());
                else
                  parameters.add('region_id');
                if (AppProvider.regionId != null)
                  parameters.add('city_id' + AppProvider.cityId.toString());
                else
                  parameters.add('city_id');
                //---------
                String gendersIds = "";
                if (AppProvider.gendersSelections.length > 0) {
                  AppProvider.gendersSelections.forEach((element) {
                    gendersIds = gendersIds +
                        'genders_ids[${element.toString()}]=' +
                        element.toString() +
                        '&';
                  });
                  parameters
                      .add(gendersIds.substring(0, gendersIds.length - 1));
                } else
                  parameters.add('genders_ids[]=');

                parameters
                    .add('availability=' + selectedAvaliability.toString());
                // if (_value > 0)
                //   parameters.add('fee_id=' + _value.toString());
                // else
                //   parameters.add('fee_id=');
                parameters.add('sort_by=');
                parameters.add('name');
                parameters.add('service_id=1');
                var titles_str = "";
                if (AppProvider.titlesIds.length > 0) {
                  AppProvider.titlesIds.forEach((element) {
                    titles_str = titles_str +
                        'titles_ids[${element.toString()}]=' +
                        element.toString() +
                        '&';
                  });
                  parameters
                      .add(titles_str.substring(0, titles_str.length - 1));
                } else
                  parameters.add('titles_ids[]=');

                String url = API.prepareUrl('searchDoctors', parameters);
                API.searchURL = url;
                AppProvider.serachUrlValue = "";
                AppProvider.serachUrlValue = url;

                await API.getDoctorsViews().then((value) {
                  if (value.isEmpty == false) {
                    AppProvider.doctorsInfo = [];
                    value.forEach((element) {
                      setState(() {
                        AppProvider.doctorsInfo.add(element);
                      });
                      // loading = false;
                      setState(() {});
                    });
                  } else {
                    setState(() {
                      AppProvider.doctorsInfo = [];
                    });
                    //setState(() {});
                  }
                }).whenComplete(() {
                  // setState(() {
                  Navigator.pop(context);
                  setState(() {});
                  // });
                });
              },
              color: Theme.of(context).primaryColor,
              child: Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
