import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/DocotorsInfo.dart';
import 'package:giatroo/Models/Regions.dart';
import 'package:giatroo/Models/SearchOptions.dart';
import 'package:giatroo/screens/select_city.dart';
import 'package:giatroo/widgets/card_search.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'filter_screen.dart';

class FilteringScreen extends StatefulWidget {
  static const routeName = 'filtering-screen';

  @override
  _FilteringScreenState createState() => _FilteringScreenState();
}

class _FilteringScreenState extends State<FilteringScreen> {
  TextEditingController _controller = TextEditingController();
  int _radioValue = 0;
  String searchedDocName;
  bool search = false;
  ScrollController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DoctorsInfo> doctorsInfo = [];
  List<SearchOptions> searchOptions = [];
  List<DoctorsInfo> doctorsInoArr = [];
  List<DoctorsInfo> _resultSearch = [];
  List<Regions> regions = [];
  List parameters = [];
  bool loading = true;
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
      }
    });
    Navigator.pop(context);
  }

  _searchInText(String value) async {
    _resultSearch = [];
    if (value.isEmpty) {
      setState(() {
        _resultSearch = [];
      });
      return;
    }
    doctorsInoArr.forEach((spec) {
      if (spec.fullName.contains(value)) {
        _resultSearch.add(spec);
        // print(spec);
        //  print(_resultSearch.length.toString());
        //  print(doctorsInoArr.length.toString());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    parameters = [];
    //Provider.of<AppProvider>(context, listen: false).refreshData();
    controller = new ScrollController()..addListener(_scrollListener);
    API.getSearchOptions().then((value) {
      searchOptions.addAll(value);
    });
    API.getAllRegions().then((value) {
      regions.addAll(value);
      AppProvider.regions = regions;
      setState(() {});
    });
    if (AppProvider.sepecialityId != null) {
      _prepareParameters();
      print('-------------------------------------------');
      print(AppProvider.serachUrlValue);
      API.getDoctorsViews().then((value) {
        if (value.length == 0) setState(() {});
        AppProvider.doctorsInfo = [];

        value.forEach((element) {
          if (element.specialityId == AppProvider.sepecialityId)
            AppProvider.doctorsInfo.add(element);
          loading = false;
          setState(() {});
        });
      }).whenComplete(() {
        loading = false;
      });
    }

    if (AppProvider.lastSearchedWord != "")
      _controller.text = AppProvider.lastSearchedWord;
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 10) {
      setState(() {
        if (AppProvider.sepecialityId != null) {
          _prepareParameters();

          print(AppProvider.serachUrlValue);
          API.getDoctorsViews().then((value) {
            AppProvider.doctorsInfo = [];

            value.forEach((element) {
              if (element.specialityId == AppProvider.sepecialityId)
                AppProvider.doctorsInfo.add(element);
              loading = false;
              setState(() {});
            });
          }).whenComplete(() => loading = false);
        }
        //  items.addAll(new List.generate(42, (index) => 'Inserted $index'));
      });
    }
  }

  void _prepareParameters() {
    if (AppProvider.sepecialityId != null)
      parameters.add('speciality_id=' + AppProvider.sepecialityId.toString());
    else
      parameters.add('speciality_id=');
    parameters.add('sub_specialities_ids[]');

    if (AppProvider.regionId != null)
      parameters.add('region_id=' + AppProvider.regionId.toString());
    else
      parameters.add('region_id');
    if (AppProvider.regionId != null)
      parameters.add('city_id=' + AppProvider.cityId.toString());
    else
      parameters.add('city_id');

    parameters.add('genders_ids[]');

    parameters.add('availability=');
    //parameters.add('fee_id');
    parameters.add('sort_by=');
    parameters.add('name=');
    if (AppProvider.serviceType == 1) parameters.add('service_id=1');
    if (AppProvider.serviceType == 2) parameters.add('service_id=2');

    parameters.add('titles_ids[]');
    String url = API.prepareUrl('searchDoctors', parameters);
    API.searchURL = url;
    AppProvider.serachUrlValue = "";
    AppProvider.serachUrlValue = url;
  }

  /// ***************************************************************************** */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: null,
      backgroundColor: Color(0xffE1E5E8),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            AppProvider.lastSearchedWord = "";
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: FlatButton(
          onPressed: () {
            AppProvider.startedScreen = 'filteringdoctorSearch';
            Navigator.pushNamed(context, SelectCity.routeName);
            setState(() {});
          },
          child: Column(
            children: [
              Text(
                'Searching in',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppProvider.selectRegios,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  const SizedBox(width: 2),
                  Icon(Icons.keyboard_arrow_down,
                      color: Colors.white, size: 18),
                ],
              ),
            ],
          ),
        ),
      ),
      body: loading == false
          ? Form(
              key: _scaffoldKey,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controller,
                          cursorColor: Theme.of(context).primaryColor,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: 'Search by Doctor Name',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: IconButton(
                              icon: Icon(Icons.search, color: Colors.grey),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                          onEditingComplete: () {
                            setState(() {
                              //    AppProvider.doctorsInfo = [];

                              // List parameters = [];

                              parameters.add('speciality_id=');

                              parameters.add('sub_specialities_ids[]');

                              if (AppProvider.regionId != null)
                                parameters.add('region_id' +
                                    AppProvider.regionId.toString());
                              else
                                parameters.add('region_id');
                              if (AppProvider.regionId != null)
                                parameters.add(
                                    'city_id' + AppProvider.cityId.toString());
                              else
                                parameters.add('city_id');

                              parameters.add('gender_ids[]');

                              parameters.add('availability=');
                              //     parameters.add('fee_id');
                              parameters.add('sort_by=');
                              AppProvider.lastSearchedWord =
                                  searchedDocName.toString();
                              parameters
                                  .add('name=' + searchedDocName.toString());
                              parameters.add('service_id=1');

                              parameters.add('titles_ids[]');
                              String url =
                                  API.prepareUrl('searchDoctors', parameters);
                              API.searchURL = url;
                              AppProvider.serachUrlValue = "";
                              AppProvider.serachUrlValue = url;

                              loading = true;
                              AppProvider.doctorsInfo = [];
                              API.getDoctorsViews().then((value) {
                                value.forEach((element) {
                                  setState(() {
                                    AppProvider.doctorsInfo = [];
                                    AppProvider.doctorsInfo.add(element);
                                  });
                                  loading = false;
                                  setState(() {});
                                });
                              }).whenComplete(() {
                                setState(() {
                                  loading = false;
                                });
                              });
                            });
                          },
                          onSaved: (newValue) {},
                          onChanged: (value) {
                            setState(() {
                              //  AppProvider.doctorsInfo = [];
                              searchedDocName = value;
                            });
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: OutlineButton(
                                onPressed: () async {
                                  _settingModalBottomSheet(context);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.sort, color: Colors.grey[700]),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Sort',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: OutlineButton(
                                onPressed: () async {
                                  // AppProvider.doctorsInfo = [];
                                  await Navigator.pushNamed(
                                      context, FilterScreen.routeName);

                                  if (AppProvider.doctorsInfo.length > 0) {
                                    setState(() {
                                      loading = false;
                                    });
                                  } else
                                    setState(() {
                                      AppProvider.doctorsInfo = [];
                                      //  loading = true;
                                    });
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.filter_alt_outlined,
                                        color: Colors.grey[700]),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Filter',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            /* Expanded(
                              flex: 1,
                              child: OutlineButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.grey[700]),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Map',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ),*/
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: AppProvider.doctorsInfo.length != 0
                        ? _resultSearch.length == 0
                            ? doctorsInoArr.length == 0
                                ? ListView.builder(
                                    itemCount: AppProvider.doctorsInfo.length,
                                    controller: controller,
                                    itemBuilder: (ctx, index) {
                                      AppProvider.pushedFrom = 'SearchByArea';
                                      return CardSearch(index);
                                    },
                                  )
                                : ListView.builder(
                                    itemCount: doctorsInoArr.length,
                                    controller: controller,
                                    itemBuilder: (ctx, index) {
                                      //  Provider.of<AppProvider>(_scaffoldKey.currentContext,listen: false).updListDocsIndex();
                                      // print('index num ='+AppProvider.listDocsIndexVal.toString());
                                      AppProvider.pushedFrom = 'SearchByArea';
                                      return CardSearch(index);
                                    },
                                  )
                            : ListView.builder(
                                itemCount: _resultSearch.length,
                                controller: controller,
                                itemBuilder: (ctx, index) {
                                  return CardSearch(index);
                                },
                              )
                        : Center(
                            child: Text('No Doctors Found'),
                          ),
                  ),
                ],
              ),
            )
          : Center(
              child: SpinKitFadingCircle(
                color: Colors.blueAccent,
                size: 80.0,
              ),
            ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sort',
                    style: TextStyle(
                        color: Colors.grey[800], fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'Reset',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ],
              ),
            ),
            Divider(),
            if (searchOptions != null)
              Expanded(
                child: ListView.builder(
                  itemCount: searchOptions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Theme.of(context).primaryColor,
                            value: 0,
                            groupValue: searchOptions[index].id,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text(
                            searchOptions[index].name,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
          ],
        );
      },
    );
  }
}
