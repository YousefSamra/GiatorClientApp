import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:giatroo/Models/Cities.dart';
import 'package:giatroo/Models/DocotorsInfo.dart';
import 'package:giatroo/Models/DoctorInfo.dart';
import 'package:giatroo/Models/DoctorScheduling.dart';
import 'package:giatroo/Models/Regions.dart';
import 'package:giatroo/Models/clientVisit.dart';

import 'package:giatroo/Models/doctorWorkingDays.dart';
import 'package:giatroo/Models/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'API.dart';
import 'Specialities.dart';
import 'UserInfo.dart';
import 'PeriodsTimes.dart';
import 'genders.dart';

class AppProvider extends ChangeNotifier {
  static String userToken;
  static List<Specialaties> specialaties = [];
  static UserInfo userInfo = UserInfo();
  static List<DoctorsInfo> doctorsInfo = [];
  static String serachUrlValue;
  static String serachUrlValue2;
  static int listDocsIndexVal = 0;
  static int serviceType = 1;
  static DoctorInfo doctorInfo;
  static List<DoctorWorkingDays> doctorWorkingDays;
  static List<DoctorScheduling> dctorSchedulingDays = [];
  static List<DoctorScheduling> dctorChoosenTimeSlots = [];
  static List<Services> doctorServices = [];
  static List<Services> remainsdDoctorServices = [];
  static List<int> subSpeicalitiesIds = [];
  static List<String> subSpeicalitiesNames = [];
  static List<int> gendersSelections = [];
  static List<int> titlesIds = [];
  static List<ClientVisit> clientsVisits = [];
  static List<Genders> genders = [];
  static var periodTimesArr;
  static List<PeriodTimes> periodTimes = [];
  static List<Regions> regions = [];
  String selectPeriodDate;
  static String startedScreen = "";
  static String choosenTimeSlot;
  static String dateTimeChoosen;
  static int isPatient;
  static String bookingDate;
  static String patientFirstName;
  static String patientLastName;
  static int patientGender;
  static String patientAddress;
  static int sepecialityId;
  static String sepcialityName;
  static int subSpecialityId;
  static String subSpecialityName;
  static List<Specialaties> allSpecialaties = [];
  static List<Regions> allRegions = [];
  static List<Cities> allRegionCities = [];
  static String deviceToken;
  static int regionId;
  static int cityId;
  static bool newLogin = false;
  static int newUser;
  static String startFrom;
  static int doctorId;
  int selectIndexForTimeSlot;
  static String pushedFrom;
  static String lastSearchedWord;
  static String selectRegios = 'All Regions';
  static Future<void> check_user_security() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String email = prefs.getString("username");
    String password = prefs.getString("userpass");
    userToken = prefs.getString("usertoken");

    if (email == null && password == null) {
      newLogin = true;
      return;
    }

    var response = API.userLogin(email, password);
    response.then((value) {
      if (value == true) {
        if (userToken == prefs.getString("usertoken")) {
          newLogin = false;
        } else
          newLogin = true;
      }
    });
  }

  void getCurrentLogin() {
    notifyListeners();
  }

  void setCurrentDate(String date) {
    this.selectPeriodDate = date;
    notifyListeners();
  }

  void setIndexTimeSlot(int index) {
    this.selectIndexForTimeSlot = index;
    notifyListeners();
  }

//********************************************************************************* */
  void updListDocsIndex() {
    listDocsIndexVal++;
    notifyListeners();
  }

//********************************************************************************* */
  Future<List<Specialaties>> getMainSpacialities() async {
    await API.getAllSpecialities().then((value) {
      specialaties = [];
      specialaties.addAll(value);
    });
    notifyListeners();
    return specialaties;
  }

  //********************************************************************************* */
  static void getUserInfo() async {
    await API.getUserInfo().then((value) {
      userInfo = value;
      print(' from provider section' + userInfo.firstName);
    });
  }

  void refreshData() {
    notifyListeners();
  }

//********************************************************************************* */
  String generateSearchParamters(var paramName, var paramValues) {
    String mainUrl = "api/v1/searchDoctors?";
    String urlParams =
        "speciality_id=&sub_specialities_ids[]&region_id&city_id&genders_ids[]&availability&fee_id&sort_by=&name&service_id=&titles_ids[]";
    String newStr = "";
    var urlArr = urlParams.toString().split('&');

    for (var i in urlArr) {
      if (i == paramName) {
        newStr = newStr + i + paramValues.toString() + '&';
      } else
        newStr = newStr + i + '&';
    }
    serachUrlValue = mainUrl + newStr;
    serachUrlValue =
        serachUrlValue.toString().substring(0, serachUrlValue.length - 1);
    notifyListeners();
    print(serachUrlValue);
    return serachUrlValue;
  }

  //********************************************************************************* */
  Future<void> getDocsWorksDays() async {
    // await API.getDocWorksDays(doctorInfo.id).then((value) {
    //   doctorWorkingDays = value;
    //   notifyListeners();
    // });
    await API.getDocScheduling(doctorInfo.id).then((value) {
      dctorSchedulingDays = value;
      notifyListeners();
    });
  }

  //*********************************************************************************** */
  static Future<void> getAllSpecialities() async {
    await API.getAllSpecialities().then((value) {
      allSpecialaties = value;
    });
  }

  static Future<void> getAllRegions() async {
    await API.getAllRegions().then((value) {
      allRegions = value;
    });
  }

  static void getRegionCities(int region_id) async {
    await API.getRegionCities(region_id).then((value) {
      allRegionCities = value;
    });
  }

  //********************************************************************************** */
  Future<void> getDocotrServices() async {
    await API.getDoctorServices(doctorInfo.id).then((value) {
      doctorServices = value;
      notifyListeners();
    });
  }

  ///******************************************************************************* */
  Future<List<ClientVisit>> getClientsVisits() async {
    await API.getUserVisits().then((value) {
      clientsVisits = [];
      clientsVisits.addAll(value);
    });
    notifyListeners();
    return clientsVisits;
  }
}
