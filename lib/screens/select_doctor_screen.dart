import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/DocotorsInfo.dart';
import 'package:giatroo/widgets/card_search.dart';

class SelectDoctorScreen extends StatefulWidget {
  static const routeName = 'select-docror-screen';

  @override
  _SelectDoctorScreenState createState() => _SelectDoctorScreenState();
}

class _SelectDoctorScreenState extends State<SelectDoctorScreen> {
  TextEditingController _controller = TextEditingController();
  bool _isSearch = false;
  Future<List<DoctorsInfo>> doctorsInfo;
  List<DoctorsInfo> doctorsInoArr = [];
  List<DoctorsInfo> _resultSearch = [];
  List parameters = [];
  @override
  void initState() {
    super.initState();
    _getData();
    if (AppProvider.lastSearchedWord != "") {
      _getData();
      _isSearch = true;
      _controller.text = AppProvider.lastSearchedWord;
      _searchInText(AppProvider.lastSearchedWord);
      setState(() {});
    }
  }

  _getData() async {
    await API.getDoctorsViews().then((value) {
      AppProvider.doctorsInfo = [];
      doctorsInoArr = [];
      doctorsInoArr.addAll(value);
      AppProvider.doctorsInfo.addAll(value);
      setState(() {
        _isSearch = true;
      });
    });
  }

  _searchInText(String value) async {
    _resultSearch = [];
    AppProvider.lastSearchedWord = value;
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
    AppProvider.doctorsInfo = _resultSearch;
    /*_resultSearch.forEach((element) {
      print(element);
    });*/
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffE1E5E8),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            _isSearch = false;
            _controller.text = "";
            AppProvider.lastSearchedWord = "";
            Navigator.pop(context);
          },
        ),
        title: Text('Select Doctor'),
      ),
      body: Form(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 70,
              color: Colors.white,
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                  controller: _controller,
                  onFieldSubmitted: (value) {
                    setState(() {
                      _isSearch = !_isSearch;
                      parameters.add('speciality_id=');

                      parameters.add('sub_specialities_ids[]');

                      if (AppProvider.regionId != null)
                        parameters
                            .add('region_id' + AppProvider.regionId.toString());
                      else
                        parameters.add('region_id');
                      if (AppProvider.regionId != null)
                        parameters
                            .add('city_id' + AppProvider.cityId.toString());
                      else
                        parameters.add('city_id');

                      parameters.add('gender_ids[]');

                      parameters.add('availability=');
                      //     parameters.add('fee_id');
                      parameters.add('sort_by=');
                      AppProvider.lastSearchedWord = _controller.text;
                      parameters.add('name=' + _controller.text);
                      parameters.add('service_id=1');

                      parameters.add('titles_ids[]');
                      String url = API.prepareUrl('searchDoctors', parameters);
                      API.searchURL = url;
                      AppProvider.serachUrlValue = "";
                      AppProvider.serachUrlValue = url;

                      //   _isSearch = true;
                      AppProvider.doctorsInfo = [];
                      API.getDoctorsViews().then((value) {
                        value.forEach((element) {
                          setState(() {
                            AppProvider.doctorsInfo = [];
                            AppProvider.doctorsInfo.add(element);
                          });
                          //  _isSearch = false;
                          setState(() {});
                        });
                      }).whenComplete(() {
                        setState(() {
                          if (AppProvider.doctorsInfo.length > 0)
                            _isSearch = true;
                          else
                            _isSearch = false;
                        });
                      });
                    });
                  },
                  cursorColor: Theme.of(context).primaryColor,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search by Doctor Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  onChanged: null //_searchInText,
                  ),
            ),
            _isSearch
                ? AppProvider.doctorsInfo.length >= 0
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: AppProvider.doctorsInfo.length,
                          itemBuilder: (ctx, index) {
                            AppProvider.pushedFrom = 'SearchByDoctorName';
                            return index <= AppProvider.doctorsInfo.length
                                ? CardSearch(index ?? 0)
                                : Container(
                                    height: 300,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      backgroundColor: Colors.blueAccent,
                                    )),
                                  );
                          },
                        ),
                      )
                    : doctorsInoArr.length != 0
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: doctorsInoArr.length,
                              itemBuilder: (ctx, index) {
                                AppProvider.pushedFrom = 'SearchByDoctorName';
                                return CardSearch(index ?? 0);
                              },
                            ),
                          )
                        : Container(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.blueAccent,
                              ),
                            ),
                          )
                : Column(
                    children: [
                      SizedBox(height: size.height * 0.25),
                      Image.asset(
                        'assets/images/nurseBig.png',
                        color: Colors.grey[400],
                        width: size.width * 0.3,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No search result found!',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
