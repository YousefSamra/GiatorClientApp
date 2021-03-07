import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/Regions.dart';
import 'package:giatroo/Models/Specialities.dart';
import 'package:giatroo/screens/select_city.dart';
import 'package:provider/provider.dart';
import 'filtering_screen.dart';

class ChooseSpecialtyScreen extends StatefulWidget {
  static const routeName = 'choose-by-specialty-and-area';
  @override
  _ChooseSpecialtyScreenState createState() => _ChooseSpecialtyScreenState();
}

class _ChooseSpecialtyScreenState extends State<ChooseSpecialtyScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Specialaties> _myListItems = [];

  List<Specialaties> _resultSearch = [];

  List<Regions> regions = [];
  Future<List<Specialaties>> futureSpecialities;
  AppProvider appProvider = AppProvider();
  @override
  void initState() {
    super.initState();
    //appProvider.getMainSpacialities();

    _resultSearch.clear();
    _myListItems.clear();
    _loadData();
    API.getAllRegions().then((value) {
      regions.addAll(value);
      AppProvider.regions = regions;
      setState(() {});
    });
  }

  @override
  dispose() {
    super.dispose();
    _resultSearch.clear();
    _myListItems.clear();

    print('disposed ');
  }

  _loadData() {
    futureSpecialities = appProvider.getMainSpacialities().then((value) {
      setState(() {
        _myListItems.clear();

        _myListItems.addAll(value);
      });
      print('Entry num 1');
      return _myListItems;
    });
  }

  _searchInText(String value) async {
    _resultSearch.clear();

    if (value.isEmpty) {
      setState(() {
        _resultSearch.clear();
      });
      return;
    }
    _myListItems.forEach((spec) {
      if (spec.name.contains(value.toUpperCase())) {
        _resultSearch.add(spec);
        print(spec);
        print(_resultSearch.length.toString());
        print(_myListItems.length.toString());
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Provider.of<AppProvider>(context,listen: false).getMainSpacialities() ;

    List _listIcon = [
      '',
      'assets/images/icons/dermathology.png',
      'assets/images/icons/dentistry.png',
      'assets/images/icons/psychiatry.png',
      'assets/images/icons/pediatrics-and-new-born.png',
      'assets/images/icons/neurology.png',
      'assets/images/icons/orthopedic.png',
      'assets/images/icons/gynecology.png',
      'assets/images/icons/nose.png',
      'assets/images/icons/cardiology.png',
      'assets/images/icons/allergy.png',
      '',
      'assets/images/icons/andrology.png',
      'assets/images/icons/Audiology.png',
      'assets/images/icons/cardiology-thoracic.png',
      'assets/images/icons/respiratory.png',
      'assets/images/icons/endocrinology.png',
      'assets/images/icons/nutrition.png',
      'assets/images/icons/accident-medicine.png',
      'assets/images/icons/family.png',
      'assets/images/icons/stomach.png',
      'assets/images/stethoscope.png',
      'assets/images/icons/surgery.png',
      'assets/images/icons/blood.png',
      'assets/images/icons/liver.png',
      'assets/images/icons/stomach.png',
      'assets/images/icons/in-vitro.png',
      'assets/images/icons/kidneys.png',
      'assets/images/icons/neurology.png',
      'assets/images/icons/liposuction.png',
      'assets/images/icons/oncology.png',
      'assets/images/icons/eye.png',
      'assets/images/icons/pain.png',
      'assets/images/icons/baby-boy.png',
      'assets/images/icons/speak.png',
      'assets/images/icons/injury.png',
      'assets/images/icons/plastic-surgery.png',
      'assets/images/icons/rheumatology.png',
      'assets/images/icons/spine.png',
      'assets/images/icons/urology.png',
      'assets/images/icons/vessel.png',
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            setState(() {
              _resultSearch.clear();

              _myListItems.clear();
            });
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: FlatButton(
          onPressed: () {
            AppProvider.startedScreen = 'doctorSearch';
            Navigator.pop(context);
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
      body: Column(
        children: [
          Container(
            width: size.width,
            height: 70,
            color: Color(0xffFAFAFA),
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _searchController,
              cursorColor: Theme.of(context).primaryColor,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search for Specialties',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              onChanged: _searchInText,
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: futureSpecialities,
            builder: (context, AsyncSnapshot<List<Specialaties>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: _resultSearch.length == 0
                    // ? _myListItems.length != 0
                    ? ListView.separated(
                        itemCount: snapshot.data.length,

                        ///AppProvider.allSpecialaties.length,
                        separatorBuilder: (context, index) {
                          //   print(AppProvider.allSpecialaties.length);

                          return index == 0 || index == 11
                              ? Divider(color: Colors.transparent)
                              : Divider();
                        },
                        itemBuilder: (ctx, index) {
                          // if (_myListItems.length == 0) setState(() {});

                          return index % 11 == 0 && index <= 11
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: Text(
                                    index == 0
                                        ? 'Most Popular Specialities'
                                        : 'Other Specialities',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                )
                              : _resultSearch.length == 0 ||
                                      _searchController.text.isEmpty
                                  ? ListTile(
                                      onTap: () {
                                        AppProvider.sepecialityId =
                                            snapshot.data[index].id;
                                        AppProvider.sepcialityName =
                                            snapshot.data[index].name;
                                        print('sprciality id is ' +
                                            AppProvider.sepecialityId
                                                .toString());
                                        Future.delayed(Duration(seconds: 1))
                                            .then((value) {
                                          AppProvider.serviceType = 1;
                                          AppProvider.pushedFrom =
                                              'SearchByArea';
                                          Navigator.pop(context);
                                          setState(() {});
                                          Navigator.pushNamed(context,
                                              FilteringScreen.routeName);
                                        });
                                        setState(() {});
                                        // Navigator.pushNamed(
                                        //     context, FilteringScreen.routeName);
                                      },
                                      //            leading: Image.asset(
                                      //   '${_listIcon[index]}',
                                      //   color: Theme.of(context).primaryColor,
                                      // ),
                                      //  subtitle: screen(context),
                                      title: Text(
                                        '${snapshot.data[index].name}',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.blue,
                                      ),
                                    );
                        },
                      )
                    : ListView.builder(
                        itemCount: _resultSearch.length,
                        itemBuilder: (context, index) {
                          if (_resultSearch.length == 0)
                            return CircularProgressIndicator(
                              backgroundColor: Colors.blueAccent,
                            );
                          return ListTile(
                            onTap: () {
                              AppProvider.sepecialityId =
                                  _resultSearch.toList()[index].id;
                              AppProvider.sepcialityName =
                                  _resultSearch.toList()[index].name;
                              print('sprciality name is ' +
                                  AppProvider.sepcialityName.toString());
                              Navigator.pushNamed(
                                  context, FilteringScreen.routeName);
                            },
                            /* leading: Image.asset(
                            '${_listIcon[index]}',
                            color: Theme.of(context).primaryColor,
                          ),*/
                            title: Text(
                              '${_resultSearch.toList()[index].name}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
              );
            },
          )),
        ],
      ),
    );
  }
}

/*
ListView(
            children: [
              Text(
                'Most Popular Specialities',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Image.asset(''),
                title: Text(
                  '',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ),
              Divider(),
            ],
          )),
*/
