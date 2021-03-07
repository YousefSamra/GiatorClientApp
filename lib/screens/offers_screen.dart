import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/DocotorsInfo.dart';
import 'package:giatroo/Models/DoctorInfo.dart';
import 'package:giatroo/Models/Regions.dart';
import 'package:giatroo/Models/viewServices.dart';
import 'package:giatroo/screens/doctor_profile_screen.dart';
import 'package:giatroo/screens/select_city.dart';
import 'package:provider/provider.dart';

class OffersScreen extends StatefulWidget {
  static const routeName = 'offers-screen';
  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  bool _isSearch = true;
  List<ViewServices> viewServices = [];
  bool _loading = true;
  List<String> parameters = [];
  List<DoctorsInfo> doctorsInoArr = [];
  List<Regions> regions = [];
  String searchServeName;
  @override
  void initState() {
    super.initState();
    //   if (AppProvider.userToken != null) _getData();

    parameters.add('region_id=');
    parameters.add('sort_by');
    parameters.add('fee_id');
    parameters.add('service_name');
    var url = API.prepareUrl('searchOffers', parameters);
    AppProvider.serachUrlValue2 = "";
    AppProvider.serachUrlValue2 = url;
    if (AppProvider.userToken != null)
      API.getDoctorsServices().then((value) {
        viewServices.addAll(value);
        _loading = false;
        setState(() {});
      });

    if (AppProvider.userToken != null)
      API.getAllRegions().then((value) {
        regions.addAll(value);
        AppProvider.regions = regions;
        setState(() {});
      });
  }

  _getData() async {
    List parameters = [];
    parameters.add('speciality_id=');
    parameters.add('sub_specialities_ids[]');

    parameters.add('region_id');

    parameters.add('city_id');

    parameters.add('gender_ids=');

    parameters.add('availability=');
    parameters.add('fee_id');
    parameters.add('sort_by=');
    parameters.add('name');
    parameters.add('service_id=1');
    parameters.add('titles_ids[]');
    String url = API.prepareUrl('searchDoctors', parameters);
    API.searchURL = url;
    AppProvider.serachUrlValue = "";
    AppProvider.serachUrlValue = url;

    await API.getDoctorsViews().then((value) {
      AppProvider.doctorsInfo = [];
      doctorsInoArr = [];
      doctorsInoArr.addAll(value);
      doctorsInoArr.forEach((element) {
        DoctorInfo doctorInfo = DoctorInfo(
          id: element.doctorId,
          avgDoctorRate: element.avgDoctorREate,
          fullAddress: element.fullAddress,
          doctorRegistration: null,
          doctorName: element.fullName,
          detailedInfo: null,
          detailedTitle: element.detailedTitle,
          clinicPhone: null,
          viewCount: 0,
          feez: element.fees,
          oldFeez: element.oldFees,
          picUrl: element.picUrl,
        );
        AppProvider.doctorInfo = doctorInfo;
      });
      AppProvider.doctorsInfo.addAll(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: ColorfulSafeArea(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        child: FlatButton(
                          onPressed: () {},
                          child: GestureDetector(
                            onTap: () {
                              AppProvider.startedScreen = 'offersSearch';
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectCity(),
                                  ));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'All Regions',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                                const SizedBox(width: 2),
                                Icon(Icons.keyboard_arrow_down,
                                    color: Colors.white, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width,
                        color: Colors.white,
                        margin:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: Center(
                          child: TextFormField(
                            //controller: _controller,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.search,
                            onFieldSubmitted: (value) async {
                              setState(() {
                                //    _isSearch = !_isSearch;
                              });
                              parameters.add('region_id=');
                              parameters.add('sort_by');
                              parameters.add('fee_id');
                              parameters.add('service_name=' + searchServeName);
                              var url =
                                  API.prepareUrl('searchOffers', parameters);
                              AppProvider.serachUrlValue2 = "";
                              AppProvider.serachUrlValue2 = url;
                              if (AppProvider.userToken != null)
                                viewServices = [];
                              await API.getDoctorsServices().then((value) {
                                viewServices.addAll(value);
                                _loading = false;
                                setState(() {});
                              });
                            },
                            onSaved: (newValue) {
                              setState(() {
                                searchServeName = newValue;
                              });
                            },
                            onChanged: (value) {
                              searchServeName = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'What are you looking for?',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _isSearch
                    ? viewServices.length > 0
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 300,
                            child: ListView.builder(
                              itemCount: viewServices.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    onTap: () async {
                                      setState(() {
                                        AppProvider.startFrom = 'Offers';
                                        AppProvider.doctorId =
                                            viewServices[index].doctor_id;
                                      });
                                      DoctorInfo docInfo;
                                      await API
                                          .getDoctorsInfo(
                                              viewServices[index].doctor_id,
                                              viewServices[index].service_id)
                                          .then((value) {
                                        AppProvider.doctorsInfo = [];
                                        AppProvider.doctorsInfo.add(value);
                                        AppProvider.doctorsInfo
                                            .forEach((element) {
                                          docInfo = DoctorInfo(
                                              doctorName: element.fullName,
                                              id: element.doctorId,
                                              fullAddress: element.fullAddress,
                                              avgDoctorRate:
                                                  element.avgDoctorREate,
                                              clinicPhone: null,
                                              detailedInfo:
                                                  element.detailedTitle,
                                              detailedTitle:
                                                  element.detailedTitle,
                                              feez: element.fees,
                                              picUrl: element.picUrl,
                                              doctorRegistration: null,
                                              oldFeez: null,
                                              viewCount: 0);

                                          AppProvider.doctorInfo = docInfo;
                                        });
                                      });
                                      await Provider.of<AppProvider>(context,
                                              listen: false)
                                          .getDocsWorksDays()
                                          .then((value) {
                                        Provider.of<AppProvider>(context,
                                                listen: false)
                                            .getDocotrServices()
                                            .whenComplete(() {
                                          // Navigator.pop(context);
                                        });
                                      });
                                      Navigator.pushNamed(context,
                                          DoctorProfileScreen.routeName);
                                    },
                                    title: _containerOffer(index));
                              },
                            ),
                          )
                        : Center(
                            child: Column(
                              children: [
                                SizedBox(height: size.height * 0.25),
                                Image.asset(
                                  'assets/images/offersBig.png',
                                  color: Colors.grey[600],
                                  width: size.width * 0.4,
                                ),
                                SizedBox(height: 24),
                                Text(
                                  'Offers are not avilable in the chosen location',
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 13),
                                ),
                              ],
                            ),
                          )
                    : Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blueAccent,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _containerOffer(index) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFFECECEC),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Color(0xFFDBDBDB).withOpacity(0.2),
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundImage: viewServices[index].pic_url != null
                  ? NetworkImage(viewServices[index].pic_url)
                  : AssetImage('assets/images/dr.png'),
              radius: 33,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  viewServices[index].service_name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  viewServices[index].full_name,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Price :' +
                            viewServices[index].service_price.toString(),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (viewServices[index].old_service_price != null)
                        Text(
                          "(" +
                              viewServices[index].old_service_price.toString() +
                              ")",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                RatingBarIndicator(
                  unratedColor: Colors.grey,
                  itemBuilder: (context, index) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                  itemCount: 5,
                  itemSize: 15.0,
                  rating: AppProvider.doctorInfo != null
                      ? AppProvider.doctorInfo.avgDoctorRate != null
                          ? double.parse(
                              AppProvider.doctorInfo.avgDoctorRate.toString() ??
                                  '0')
                          : 0.0
                      : 0.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
