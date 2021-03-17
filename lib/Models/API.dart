import 'dart:convert';

import 'dart:io';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/BookVisit.dart';
import 'package:giatroo/Models/DoctorAppontments.dart';
import 'package:giatroo/Models/DoctorRate.dart';
import 'package:giatroo/Models/DoctorScheduling.dart';
import 'package:giatroo/Models/DoctorServices.dart';
import 'package:giatroo/Models/PeriodsTimes.dart';
import 'package:giatroo/Models/SearchOptions.dart';
import 'package:giatroo/Models/Specialities.dart';
import 'package:giatroo/Models/Cities.dart';
import 'package:giatroo/Models/Regions.dart';
import 'package:giatroo/Models/avaiability.dart';
import 'package:giatroo/Models/clientVisit.dart';
import 'package:giatroo/Models/feesRange.dart';
import 'package:giatroo/Models/services.dart';
import 'package:giatroo/Models/subSpecial.dart';
import 'package:giatroo/Models/titles.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DocotorsInfo.dart';
import 'User.dart';
import 'UserInfo.dart';
import 'viewServices.dart';
import 'DoctorData.dart';
import 'doctorWorkingDays.dart';
import 'genders.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

FirebaseMessaging _firebaseMessaging;

class API {
  static const String _BASE_URL = 'https://giatro.my/';
  //----------------------------------------------------------------------------
  static String searchURL;
  static String prepareUrl(String apiName, List urlParameters) {
    String str = 'api/v1/${apiName}?';
    urlParameters.forEach((element) {
      str = str + element + '&';
    });
    str = str.substring(0, str.length - 1);
    return str;
  }

//----------------------------------------------------------------------------
  static Future<bool> setUserToken(
      User value, String userEmail, String userPass) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("username", value.userName ?? userEmail);
    prefs.setString("userpass", value.password ?? userPass);
    prefs.setString("usertoken", value.accessToken);
    AppProvider.userToken = value.accessToken;

    return true;
  }

  static Future<bool> setUserTokenSocial(var accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("usertoken", accessToken);
    AppProvider.userToken = accessToken;

    return true;
  }

  //=============================================================================

  //===========================================================================

  static Future<bool> showSocialButtons() async {
    Response response = await get('${_BASE_URL}api/v1/showSocialButtons',
        headers: {HttpHeaders.acceptHeader: "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      var mydata = response.body;
      if (mydata == "1") {
        return true;
      } else {
        return false;
      }
      //
    } else {
      return false;
      throw Exception('Cannot Load  the data ');
    }
  }

  //----------------------------------------------------------------------------
  static Future<bool> userLogin(userEmail, userPass) async {
    Response response = await post(_BASE_URL + 'oauth/token',
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          "username": userEmail,
          "password": userPass,
          "client_id": 2,
          "client_secret": 'ilm5bVD45t1lVJMmucpk6KiDsrCxjGxaPenJH93F',
          "grant_type": 'password'
        }));
    bool loginStatus = false;
    print(response.body);
    if (response.statusCode == 200) {
      var mydata = jsonDecode(response.body);
      var userLoginData = User.fromJson(mydata);
      loginStatus = true;
      Future<bool> saveToken = setUserToken(userLoginData, userEmail, userPass);
      saveToken.then((value) => loginStatus = value);
      print(response.body);
      return loginStatus; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return loginStatus;
    }
  }

  //---------------------------------------------------------------------------

  static Future<bool> loginWithGoogle() async {
    bool loginStatus = false;
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();

      GoogleSignInAccount account = await googleSignIn.signIn();

      if (account == null) return false;

//      String IdToken = (await account.authentication).idToken;
      String account_id = await account.id;
      String email = await account.email;
      String name = await account.displayName;
      String imageUrl = await account.photoUrl;

      _firebaseMessaging = FirebaseMessaging();
      String deviceToken = await _firebaseMessaging.getToken();
      var response = await createNewPatientSocial(name, name, 0,
          email ?? "a@a.com", "google", account_id, deviceToken, imageUrl);

      print("response.body:: ${response.body}");
      if (response.statusCode == 201) {
        var mydata = jsonDecode(response.body);
        loginStatus = true;
        await setUserTokenSocial(mydata["data"]["access_token"]);
//          print(response.body);
        return loginStatus; // Post.fromJson(json.decode(postFuture.body));
      } else {
        return loginStatus;
      }
    } catch (e) {
      print(e.message);
      print("Error logging with google");
      return false;
    }
  }

  static Future<bool> doLoginFacebook() async {
// Create an instance of FacebookLogin
    bool loginStatus = false;
    final fb = FacebookLogin();

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        _firebaseMessaging = FirebaseMessaging();
        String deviceToken = await _firebaseMessaging.getToken();

//        final FacebookAccessToken accessToken = res.accessToken;

        final profile = await fb.getUserProfile();
        final imageUrl = await fb.getProfileImageUrl(width: 100);

        final email = await fb.getUserEmail();

        if (email != null) print('And your email is $email');

        var response = await createNewPatientSocial(
            profile.firstName,
            profile.lastName,
            0,
            email ?? "a@a.com",
            "facebook",
            profile.userId,
            deviceToken,
            imageUrl);
        print("response.body:: ${response.body}");
        if (response.statusCode == 201) {
          var mydata = jsonDecode(response.body);
          loginStatus = true;
          await setUserTokenSocial(mydata["data"]["access_token"]);
//          print(response.body);
          return loginStatus; // Post.fromJson(json.decode(postFuture.body));
        } else {
          return loginStatus;
        }

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }

    return loginStatus;
  }

  //----------------------------------------------------------------------------

  static Future<Response> createNewPatientSocial(firstname, lastname, mobile,
      email, provider, provider_id, device_token, imageUrl) async {
    Response response = await post(_BASE_URL + 'api/v1/userSocialApi',
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          "scope": "*",
          "name": firstname,
          "last_name": lastname,
          "mobile": mobile,
          "email": email,
          "gender_id": null,
          "birthdate": null,
          "device_token": device_token,
          "provider_id": provider_id,
          "provider": provider,
          "avatar": imageUrl,
        }));

    if (response.statusCode == 201) {
      print(response.body);
      return response; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return response;
    }
  }

  //----------------------------------------------------------------------------
  static Future<Response> createNewPatient(firstname, lastname, mobile, email,
      gender_id, birthdate, password, city_id, device_token) async {
    Response response = await post(_BASE_URL + 'api/v1/registerPatient',
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          "name": firstname,
          "last_name": lastname,
          "mobile": mobile,
          "email": email,
          "gender_id": gender_id,
          "birthdate": birthdate,
          "password": password,
          "password_confirmation": password,
          //  "city_id": city_id,
          "device_token": device_token ?? 1884665557
        }));

    if (response.statusCode == 201) {
      print(response.body);
      return response; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return response;
    }
  }

  //----------------------------------------------------------------------------
  static Future<int> updatePatient(
      firstname, lastname, mobile, email, genderId, birthDate) async {
    Response response = await post(_BASE_URL + 'api/v1/updateUserInfo',
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + AppProvider.userToken,
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          "name": firstname,
          "last_name": lastname,
          "mobile": mobile,
          "email": email,
          "gender_id": genderId,
          "birthdate": birthDate,
          "_method": 'PUT'
        }));
    bool loginStatus = false;
    if (response.statusCode == 201) {
      print(response.body);
      return response
          .statusCode; // Post.fromJson(json.decode(postFuture.body));
    } else {
      print(response.body);
      return response.statusCode;
    }
  }

  /// --------------------------------------------------------------------------
  static Future<int> changePassword(oldPass, newPass) async {
    Response response = await post(_BASE_URL + 'api/v1/updatePassword',
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + AppProvider.userToken,
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          "old_password": oldPass,
          "password": newPass,
          "password_confirmation": newPass,
          "_method": 'PUT'
        }));
    bool loginStatus = false;
    if (response.statusCode == 200) {
      print(response.body);
      return response
          .statusCode; // Post.fromJson(json.decode(postFuture.body));
    } else {
      print(response.body);
      return response.statusCode;
    }
  }

  /// --------------------------------------------------------------------------
  static Future<int> logout() async {
    print("AppProvider.userToken: ${AppProvider.userToken}");
    Response response = await post(_BASE_URL + 'api/v1/logoutApi',
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + AppProvider.userToken,
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(<String, dynamic>{"_method": 'DELETE'}));
    bool loginStatus = false;
    if (response.statusCode == 200) {
      print(response.body);
      return response
          .statusCode; // Post.fromJson(json.decode(postFuture.body));
    } else {
      print(response.body);
      return response.statusCode;
    }
  }

//------------------------------------------------------------------------------
  static Future<String> getmainSpecialById(int specId) async {
    String specialName;
    Response sepcialNameResponse = await get(
        _BASE_URL + 'api/v1/allSpecialities?speciality_id=${specId}',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
          HttpHeaders.acceptHeader: "application/json"
        });
    if (sepcialNameResponse.statusCode == 200) {
      print(sepcialNameResponse.body);
      var responseData = jsonDecode(sepcialNameResponse.body);
      // countries = [];
      specialName = responseData[0]["name"];
      return specialName; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return specialName;
    }
  }

  //----------------------------------------------------------------------------
  static Future<List<String>> getmainSpecialities() async {
    String specialName;
    List<String> specialites = List<String>();
    Response sepcialNameResponse =
        await get(_BASE_URL + 'api/v1/allSpecialities', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (sepcialNameResponse.statusCode == 200) {
      print(sepcialNameResponse.body);
      var responseData = jsonDecode(sepcialNameResponse.body);
      specialites = [];

      for (var i in responseData) {
        specialites.add(i["name"]);
      }
      return specialites; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return specialites;
    }
  }

  // -------------------------------------------------------------------------
  static Future<UserInfo> getUserInfo() async {
    if (AppProvider.userToken == null) return null;
    UserInfo usersInfo = UserInfo();
    Response sepcialNameResponse =
        await get(_BASE_URL + 'api/v1/getUserInfo', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (sepcialNameResponse.statusCode == 201) {
      print(sepcialNameResponse.body);
      var responseData = jsonDecode(sepcialNameResponse.body)["data"];
      usersInfo = UserInfo.fromJson(responseData);
      print(usersInfo.firstName);
      return usersInfo; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return usersInfo;
    }
  }

// -------------------------------------------------------------------------
  static Future<List<DoctorsInfo>> getDoctorsViews() async {
    if (AppProvider.userToken == null) return null;
    List<DoctorsInfo> doctorsInfoArr = [];
    DoctorsInfo doctorsInfo = DoctorsInfo();
    // List<String> parameters = AppProvider.serachUrlValue.split('&');
    var path = _BASE_URL + AppProvider.serachUrlValue;
    Response sepcialNameResponse = await get(
      path,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
        HttpHeaders.acceptHeader: "application/json"
      },
    );
    if (sepcialNameResponse.statusCode == 200) {
      print(sepcialNameResponse.body);
      var responseData = jsonDecode(sepcialNameResponse.body)["data"];
      if (responseData.length > 0)
        for (var docs in responseData) {
          doctorsInfo = DoctorsInfo(
              doctorId: docs['view']['doctor_id'],
              fullName: docs['view']['full_name'],
              speciality: docs['view']['speciality'],
              specialityId: docs['view']['speciality_id'],
              detailedTitle: docs['view']['detailed_title'],
              fullAddress: docs['view']['full_address'],
              fees: docs['view']['fees'],
              avgDoctorREate: docs['view']['avg_doctor_rate'],
              doctorRate: docs['view']['doctor_rate'],
              ratingsTotal: docs['view']['ratings_total'],
              picUrl: docs['view']['pic_url'],
              picThumbnail: docs['view']['pic_thumbnail'],
              picPreview: docs['view']['pic_preview'],
              availability: docs['view']['availability'],
              oldFees: docs['view']['old_fees']);
          doctorsInfoArr.add(doctorsInfo);
        }

      return doctorsInfoArr; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return doctorsInfoArr;
    }
  }

//*************************************************************************** */
  static Future<DoctorsInfo> getDoctorsInfo(int doctorId, int serviceId) async {
    if (AppProvider.userToken == null) return null;
    // List<DoctorsInfo> doctorsInfoArr = [];
    DoctorsInfo doctorsInfo = DoctorsInfo();
    // List<String> parameters = AppProvider.serachUrlValue.split('&');
    var path = _BASE_URL +
        'api/v1/getDoctorByIdService?doctor_id=${doctorId}&service_id=${serviceId}';
    Response docDataResponse = await get(
      path,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
        HttpHeaders.acceptHeader: "application/json"
      },
    );
    if (docDataResponse.statusCode == 200) {
      print(docDataResponse.body);
      var responseData = jsonDecode(docDataResponse.body);
      // for (var docs in responseData) {
      doctorsInfo = DoctorsInfo(
          doctorId: responseData['view']['doctor_id'],
          fullName: responseData['view']['full_name'],
          speciality: responseData['view']['speciality'],
          specialityId: responseData['view']['speciality_id'],
          detailedTitle: responseData['view']['detailed_title'],
          fullAddress: responseData['view']['full_address'],
          fees: responseData['view']['service_price'],
          avgDoctorREate: responseData['view']['avg_doctor_rate'],
          doctorRate: responseData['view']['doctor_rate'],
          ratingsTotal: responseData['view']['ratings_total'],
          picUrl: responseData['view']['pic_url'],
          picThumbnail: responseData['view']['pic_thumbnail'],
          picPreview: responseData['view']['pic_preview'],
          availability: responseData['view']['availability'],
          oldFees: responseData['view']['old_service_price']);
      //doctorsInfoArr.add(doctorsInfo);
      // }

      return doctorsInfo; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return doctorsInfo;
    }
  }

// -------------------------------------------------------------------------
  static Future<DoctorsInfo> getDoctorInfo(int id) async {
    DoctorsInfo doctorsInfo = DoctorsInfo();
    Response sepcialNameResponse =
        await get(_BASE_URL + 'api/v1/getDoctorInfo?doctor_id=${id}', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (sepcialNameResponse.statusCode == 200) {
      print(sepcialNameResponse.body);
      var responseData = jsonDecode(sepcialNameResponse.body)["data"];

      doctorsInfo = DoctorsInfo(
          doctorId: responseData['view']['doctor_id'],
          fullName: responseData['view']['full_name'],
          speciality: responseData['view']['speciality'],
          specialityId: responseData['view']['speciality_id'],
          detailedTitle: responseData['view']['detailed_title'],
          fullAddress: responseData['view']['full_address'],
          fees: responseData['view']['fees'],
          avgDoctorREate: responseData['view']['avg_doctor_rate'],
          doctorRate: responseData['view']['doctor_rate'],
          ratingsTotal: responseData['view']['ratings_total'],
          picUrl: responseData['view']['pic_url'],
          picThumbnail: responseData['view']['pic_thumbnail'],
          picPreview: responseData['view']['pic_preview'],
          availability: responseData['view']['availability']);

      return doctorsInfo; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return doctorsInfo;
    }
  }

// -------------------------------------------------------------------------
  static Future<List<DoctorWorkingDays>> getDocWorksDays(int id) async {
    List<DoctorWorkingDays> doctorWorkingDaysArr = [];
    DoctorWorkingDays doctorWorkingDays = DoctorWorkingDays();
    Response sepcialNameResponse =
        await get(_BASE_URL + 'api/v1/getDoctorInfo?doctor_id=${id}', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (sepcialNameResponse.statusCode == 201) {
      print(sepcialNameResponse.body);
      var responseData =
          jsonDecode(sepcialNameResponse.body)["data"]["doctor_work_days"];
      for (var days in responseData) {
        doctorWorkingDays = DoctorWorkingDays(
            id: days['id'],
            doctorId: days['doctor_id'],
            dayNumber: days['day_number'],
            startTime: days['start_time'],
            endTime: days['end_time'],
            createdAt: days['created_at'],
            updatedAt: days['updated_at'],
            sessionId: days['session_id'],
            restrictionId: days['restriction_id']);
        doctorWorkingDaysArr.add(doctorWorkingDays);
      }
      return doctorWorkingDaysArr; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return doctorWorkingDaysArr;
    }
  }

// -------------------------------------------------------------------------
  static Future<List<DoctorScheduling>> getDocScheduling(int id) async {
    List<DoctorScheduling> doctorSchedulingArr = [];
    DoctorScheduling doctorScheduling = DoctorScheduling();
    Response sepcialNameResponse =
        await get(_BASE_URL + 'api/v1/getDoctorInfo?doctor_id=${id}', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (sepcialNameResponse.statusCode == 201) {
      print(sepcialNameResponse.body);
      try {
        var responseData =
            jsonDecode(sepcialNameResponse.body)["data"]["schedule"];

        for (var days in responseData) {
          doctorScheduling = DoctorScheduling(
            id: days['id'],
            dayNum: days["description"]["day"],
            dayName: days["description"]["dayName"],
            period_times: days["description"]["period_times"],
            dayStartTime: days["description"]["dayStartTime"],
            dayEndTime: days["description"]["dayEndTime"],
            sessionTime: days["description"]["session_time"],
            status: days["description"]["status"],
            dayNameDate: days["description"]["dayNameDate"],
          );
          doctorSchedulingArr.add(doctorScheduling);
        }
        doctorSchedulingArr.forEach((element) {
          AppProvider.periodTimesArr = element.period_times;
        });
      } catch (e) {}
      ;
      return doctorSchedulingArr; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return doctorSchedulingArr;
    }
  }

  //----------------------------------------------------------------------------
  static Future<List<SearchOptions>> getSearchOptions() async {
    List<SearchOptions> searchOptionsArr = [];
    SearchOptions searchOptions = SearchOptions();
    Response sepcialNameResponse =
        await get(_BASE_URL + 'api/v1/getSortOptions', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (sepcialNameResponse.statusCode == 202) {
      print(sepcialNameResponse.body);
      var responseData = jsonDecode(sepcialNameResponse.body)["data"];
      for (var opt in responseData) {
        searchOptions = SearchOptions(
            id: opt['id'] == '' ? 0 : int.parse(opt['id']),
            name: opt['name'].toString());
        searchOptionsArr.add(searchOptions);
      }

      return searchOptionsArr; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return searchOptionsArr;
    }
  }

  //----------------------------------------------------------------------------
  static Future<List<PeriodTimes>> getPeriodTimes(int id) async {
    List<PeriodTimes> doctorPeriodTimes = [];
    PeriodTimes periodTimes = PeriodTimes();
    Response sepcialNameResponse =
        await get(_BASE_URL + 'api/v1/getDoctorInfo?doctor_id=${id}', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (sepcialNameResponse.statusCode == 201) {
      print(sepcialNameResponse.body);
      var responseData = jsonDecode(sepcialNameResponse.body)["data"]
          ["schedule"][0]["description"]["period_times"];
      for (var days in responseData) {
        periodTimes = PeriodTimes(
            id: days['id'],
            start_time_am: days['start_time_am'],
            end_time_am: days['end_time_am'],
            end_time: days['end_time']);
        doctorPeriodTimes.add(periodTimes);
      }
      // doctorPeriodTimes.forEach((element) {
      //   AppProvider.periodTimesArr = element.period_times;
      // });
      return doctorPeriodTimes; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return doctorPeriodTimes;
    }
  }

  ///***************************************************************** */
  static Future<List<Services>> getDoctorServices(int docId) async {
    List<Services> doctorServiceArr = [];
    Response doctorServiceResponse = await get(
        _BASE_URL + 'api/v1/getDoctorInfo?doctor_id=${docId}',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
          HttpHeaders.acceptHeader: "application/json"
        });
    if (doctorServiceResponse.statusCode == 201) {
      print(doctorServiceResponse.body);
      try {
        var responseData =
            jsonDecode(doctorServiceResponse.body)["data"]["services"];
        for (var service in responseData) {
          print(service);

          Services docserv =
              Services(serviceId: service["id"], serviceName: service["name"]);
          doctorServiceArr.add(docserv);
          print(docserv);
        }
      } catch (e) {}
      return doctorServiceArr; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return doctorServiceArr;
    }
  }

  ///***************************************************************** */
  static Future<List<SubSpecialist>> getDoctorSubSpecialists(
      int majorId) async {
    List<SubSpecialist> specialist = [];
    Response specialists = await get(
        _BASE_URL + 'api/v1/subsOfSpeciality?speciality_id=${majorId}',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
          HttpHeaders.acceptHeader: "application/json"
        });
    if (specialists.statusCode == 200) {
      try {
        var responseData = jsonDecode(specialists.body);

        for (var spect in responseData) {
          print(spect);
          SubSpecialist myspecialist = SubSpecialist.fromJson(spect);
          specialist.add(myspecialist);
        }
      } catch (e) {
        print('No data ${e.toString()}');
        return null;
      }
      return specialist; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return specialist;
    }
  }

  //=================================================================
  /*static Future<List<Regions>> getAllRegions(String countryId) async {
    List<Regions> regions = [];
    Response regionList =
        await get(_BASE_URL + 'api/v1/regions/${countryId}', headers: {
      //   HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (regionList.statusCode == 200) {
      print(regionList.body);
      var responseData = jsonDecode(regionList.body);

      // countries = [];
      for (var region in responseData) {
        Regions myRegions = Regions(
          id: region["region_id"],
          name: region["name"],
        );
        regions.add(myRegions);
      }
      return regions; // Post.fromJson(json.decode(postFuture.body));
    } else {
      throw Exception('Failed auth');
    }
  }*/

  //=================================================================
  static Future<List<Cities>> getAllCities(int regionId) async {
    List<Cities> cities = [];
    Cities myCities;
    Response citiesList =
        await get(_BASE_URL + 'api/v1/region/cities/${regionId}', headers: {
      //   HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (citiesList.statusCode == 200) {
      print(citiesList.body);
      var responseData = jsonDecode(citiesList.body);
      // countries = [];
      //cities.clear();
      for (var region in responseData) {
        myCities = Cities(
          id: region["city_id"],
          name: region["name"],
        );
        cities.add(myCities);
      }
      return cities; // Post.fromJson(json.decode(postFuture.body));
    } else {
      print(cities);
      return cities;
    }
  }

  //=================================================================
  static Future<List<DoctorAppontments>> getDoctorAppintments() async {
    var data;
    List<DoctorAppontments> doctorAppontmentsArr = [];
    try {
      Response futurStatuses =
          await get(_BASE_URL + 'api/v1/getDoctorAppointments', headers: {
        HttpHeaders.authorizationHeader: "Bearer " + AppProvider.userToken,
        HttpHeaders.acceptHeader: "application/json"
      });

      if (futurStatuses.statusCode == 201) {
        // print(futurStatuses.body);
        var responseData = jsonDecode(futurStatuses.body)["data"];
        if (responseData == null) return null;
        for (var i in responseData) {
          data = DoctorAppontments(
              id: i['id'],
              booking_start_time: i['booking_start_time'],
              booking_date: i['booking_date'],
              booking_end_time: i['booking_end_time'],
              price: i['price'],
              client_is_patient: i['client_is_patient'],
              patient_first_name: i['patient_first_name'],
              patient_last_name: i['patient_last_name'],
              client_address: i['client_address'],
              visit_status_id: i['visit_status_id'],
              is_fees_transfered: i['is_fees_transfered'],
              is_manual_payment: i['is_manual_payment'],
              calculated: i['calculated'],
              created_at: i['created_at'],
              updated_at: i['updated_at'],
              deleted_at: i['deleted_at'],
              user_id: i['user_id'],
              doctor_id: i['doctor_id'],
              service_id: i['service_id'],
              patient_gender_id: i['patient_gender_id'],
              visit_status_name: i['visit_status_name'],
              service_name: i['service_name'],
              patient_name: i['patient_name']);
          doctorAppontmentsArr.add(data);
        }

        return doctorAppontmentsArr;
      } else {
        return doctorAppontmentsArr;
      }
    } catch (e) {
      print('Error : Conetction Lost $e');
    }
  }

//-------------------------------------------------------------------------------------------------
  // static Future<List<DoctorWorkingDays>> getWorkingHors() async {
  //   List<DoctorWorkingDays> arrDocWorksDays = [];
  //   try {
  //     Response futurRestrictions =
  //         await get('https://giatro.my/api/v1/showDoctorWorkDays', headers: {
  //       HttpHeaders.authorizationHeader: "Bearer " + AppProvider.userToken,
  //       HttpHeaders.acceptHeader: "application/json"
  //     });
  //     if (futurRestrictions.statusCode == 200 ||
  //         futurRestrictions.statusCode == 201) {
  //       print(futurRestrictions.body);
  //       var responseData = jsonDecode(futurRestrictions.body)["data"];

  //       if (responseData == null) return null;

  //       for (var i in responseData) {
  //         var data = DoctorWorkingDays(
  //             id: i['id'],
  //             dayNumber: i['day_number'],
  //             startTime: i['start_time'],
  //             endTime: i['end_time'],
  //             createdAt: i['created_at'],
  //             updatedAt: i['updated_at'],
  //             doctorId: i['doctor_id'],
  //             sessionId: i['session_id'],
  //             restrictionId: i['restriction_id'],
  //             dayName: i['dayName'],
  //             restrictionName: i['restrictionName'],
  //             seassionValue: i['sessionValue']);
  //         arrDocWorksDays.add(data);
  //         //AppProvider.docRestricationName = i['restrictionName'];
  //       }
  //       return arrDocWorksDays;
  //     } else {
  //       return arrDocWorksDays;
  //     }
  //   } catch (e) {
  //     print('Connection Lost $e');
  //   }
  // }
  //----------------------------------------------------------------------------
  static Future<int> orderHomeVisit(
      phone_number, city_id, region_id, speciality_id) async {
    Response response = await post(_BASE_URL + 'api/v1/orderHomeVisit',
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + AppProvider.userToken,
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          "phone_number": phone_number,
          "city_id": city_id,
          "region_id": region_id,
          "speciality_id": speciality_id,
          "_method": 'PUT'
        }));
    bool loginStatus = false;
    if (response.statusCode == 202) {
      return response
          .statusCode; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return response.statusCode;
    }
  }

  //----------------------------------------------------------------------------
  static Future<List<Specialaties>> getAllSpecialities() async {
    List<Specialaties> specialites = List<Specialaties>();
    Response sepcialNameResponse =
        await get(_BASE_URL + 'api/v1/allSpecialities', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (sepcialNameResponse.statusCode == 200) {
      var responseData = jsonDecode(sepcialNameResponse.body);
      for (var i in responseData) {
        specialites.add(Specialaties.fromJson(i));
      }
      return specialites; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return specialites;
    }
  }

  //----------------------------------------------------------------------------
  static Future<List<Regions>> getAllRegions() async {
    if (AppProvider.userToken == null) return null;
    List<Regions> regions = List<Regions>();
    Response regionsResponse =
        await get(_BASE_URL + 'api/v1/regions/my', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (regionsResponse.statusCode == 200) {
      var responseData = jsonDecode(regionsResponse.body);
      for (var i in responseData) {
        regions.add(Regions.fromJson(i));
      }
      return regions; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return regions;
    }
  }

  //----------------------------------------------------------------------------
  static Future<List<Cities>> getRegionCities(int region_id) async {
    List<Cities> cities = List<Cities>();
    Response citiesResponse = await get(
        _BASE_URL + 'api/v1/region/cities/' + region_id.toString(),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
          HttpHeaders.acceptHeader: "application/json"
        });
    if (citiesResponse.statusCode == 200) {
      var responseData = jsonDecode(citiesResponse.body);
      for (var i in responseData) {
        cities.add(Cities.fromJson(i));
      }
      return cities; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return cities;
    }
  }

  //=================================================================
  static Future<int> deviceToken(String p_device_token) async {
    final path = _BASE_URL + 'api/v1/updateDeviceToken';
    final Response response = await post(path,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
        },
        body: jsonEncode(
          <String, dynamic>{"device_token": p_device_token},
        ));
    print(p_device_token);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      print(response.body);
      if (!response.body.contains("errors")) {
        // var mydata = jsonDecode(response.body);
        // userLogin(email, password);
        // userLogin(email, password);
        print('after ' + p_device_token);
        AppProvider.deviceToken = p_device_token;
      }
    } else {
      return response.statusCode;
    }

    return response.statusCode;
  }

//========================================================================
//=================================================================
  static Future<BookVisit> bookAnAppointment(
      int doctorId,
      int serviceId,
      String bookingDate,
      String bookingStartTime,
      int clientIsPatient,
      String firstName,
      String lastName,
      int genderId,
      String clientAddress) async {
    BookVisit bookData = BookVisit();

    final Response response = await post(_BASE_URL + "api/v1/BookVisit",
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
        },
        body: jsonEncode(<String, dynamic>{
          "doctor_id": doctorId,
          "service_id": serviceId,
          "booking_date": bookingDate,
          "booking_start_time": bookingStartTime,
          "client_is_patient": clientIsPatient,
          "patient_first_name": firstName,
          "patient_last_name": lastName,
          "patient_gender_id": genderId,
          "client_address": clientAddress
        }));

    if (response.statusCode == 202) {
      var mydata = jsonDecode(response.body)["data"];
      var bookData = BookVisit.fromJson(mydata);
      print(bookData);
      return bookData;
    } else {
      return bookData;
    }
  }

  //----/----------------------------------------------------------------

  //----------------------------------------------------------------------------
  static Future<List<FeesRange>> getfeesFilters() async {
    List<FeesRange> feesRanges = List<FeesRange>();
    Response feesResponse =
        await get(_BASE_URL + 'api/v1/getFeesRange', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (feesResponse.statusCode == 202) {
      var responseData = jsonDecode(feesResponse.body)["data"];
      for (var i in responseData) {
        feesRanges.add(FeesRange.fromJson(i));
      }
      return feesRanges; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return feesRanges;
    }
  }

  //----------------------------------------------------------------------------
  static Future<List<Genders>> getgenderFilter() async {
    List<Genders> gendersRanges = List<Genders>();
    Response gendersResponse =
        await get(_BASE_URL + 'api/v1/genders/', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (gendersResponse.statusCode == 200) {
      var responseData = jsonDecode(gendersResponse.body);
      for (var i in responseData) {
        gendersRanges.add(Genders.fromJson(i));
      }
      return gendersRanges; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return gendersRanges;
    }
  }

  //----------------------------------------------------------------------------
  static Future<List<Titles>> getTitlesFilter() async {
    List<Titles> titlesOptions = List<Titles>();
    Response titlesResponse =
        await get(_BASE_URL + 'api/v1/getTitlesOptions', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (titlesResponse.statusCode == 202) {
      var responseData = jsonDecode(titlesResponse.body)["data"];
      for (var i in responseData) {
        titlesOptions.add(Titles.fromJson(i));
      }
      return titlesOptions; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return titlesOptions;
    }
  }

  //----------------------------------------------------------------------------
  static Future<List<Avaliability>> getAvaliabilityFilter() async {
    List<Avaliability> avaliabilityOptions = List<Avaliability>();
    Response avaliabilityResponse =
        await get(_BASE_URL + 'api/v1/getAvailabilityOptions', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (avaliabilityResponse.statusCode == 202) {
      var responseData = jsonDecode(avaliabilityResponse.body)["data"];
      for (var i in responseData) {
        avaliabilityOptions.add(Avaliability.fromJson(i));
      }
      return avaliabilityOptions; // Post.fromJson(json.decode(postFuture.body));
    } else {
      return avaliabilityOptions;
    }
  }

  //----------------------------------------------------------------------------
  static Future<List<ViewServices>> getDoctorsServices() async {
    if (AppProvider.userToken == null) return null;
    List<ViewServices> servicesOptions = List<ViewServices>();
    Response servicesResponse =
        await get(_BASE_URL + AppProvider.serachUrlValue2, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (servicesResponse.statusCode == 200) {
      var responseData = jsonDecode(servicesResponse.body)["data"];
      for (var i in responseData) {
        servicesOptions.add(ViewServices.fromJson(i));
      }
      return servicesOptions;
    } else {
      return servicesOptions;
    }
  }

  //----------------------------------------------------------------------------
  static Future<List<ClientVisit>> getUserVisits() async {
    if (AppProvider.userToken == null) return null;
    List<ClientVisit> clientVisits = List<ClientVisit>();
    Response visitsResponse =
        await get(_BASE_URL + 'api/v1/getUserVisits', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (visitsResponse.statusCode == 202) {
      var responseData = jsonDecode(visitsResponse.body)["data"];
      for (var i in responseData) {
        clientVisits.add(ClientVisit.fromJson(i));
      }
      return clientVisits;
    } else {
      return clientVisits;
    }
  }

  /*------------------------------------------------------------------*/
  static Future<Response> cancelAppointment(int visitId) async {
    final Response response = await post('https://giatro.my/api/v1/visitCancel',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "visit_id": visitId,
          },
        ));

    print(jsonEncode(
      <String, dynamic>{
        "visit_id": visitId,
      },
    ));
    print(response.body);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      if (response.body.contains('error')) {
        return response;
      } else
        return response;
    }
    return response;
  }

  /*------------------------------------------------------------------*/
  static Future<Response> resetPassword(String email) async {
    final Response response =
        await post('https://giatro.my/api/v1/forgotPassword',
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              // HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
            },
            body: jsonEncode(
              <String, dynamic>{"email": email, "_method": "PUT"},
            ));

    print(jsonEncode(
      <String, dynamic>{"email": email, "_method": "PUT"},
    ));
    print(response.body);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      if (response.body.contains('error')) {
        return response;
      } else
        return response;
    }
    return response;
  }

  //----------------------------------------------------------------------------
  static Future<List<DoctorRate>> getDoctorsRates(int doctoId) async {
    if (AppProvider.userToken == null) return null;
    List<DoctorRate> doctorsRate = List<DoctorRate>();
    String path = _BASE_URL + 'api/v1/getDoctorRates?doctor_id=$doctoId';
    Response doctorRateResponse = await get(path, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + AppProvider.userToken,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (doctorRateResponse.statusCode == 200) {
      var responseData = jsonDecode(doctorRateResponse.body);
      for (var i in responseData) {
        doctorsRate.add(DoctorRate.fromJson(i));
      }
      return doctorsRate;
    } else {
      return doctorsRate;
    }
  }
}
