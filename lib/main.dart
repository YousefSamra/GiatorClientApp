import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giatroo/screens/Loading.dart';
import 'package:giatroo/screens/Reset.dart';
import 'package:giatroo/screens/aboutus.dart';
import 'package:giatroo/screens/book_doctor.dart';
import 'package:giatroo/screens/change_password.dart';
import 'package:giatroo/screens/choose_specialty_screen.dart';
import 'package:giatroo/screens/choose_time_slot_screen.dart';
import 'package:giatroo/screens/confirmation_screen.dart';
import 'package:giatroo/screens/contactus.dart';
import 'package:giatroo/screens/doctor_profile_screen.dart';
import 'package:giatroo/screens/edit_profile.dart';
import 'package:giatroo/screens/filter_screen.dart';
import 'package:giatroo/screens/filtering_screen.dart';
import 'package:giatroo/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:giatroo/screens/home_visit.dart';
import 'package:giatroo/screens/insurance_companies_screen.dart';
import 'package:giatroo/screens/login_screen.dart';
import 'package:giatroo/screens/more_insurance_screen.dart';
import 'package:giatroo/screens/more_services_screen.dart';
import 'package:giatroo/screens/offers_screen.dart';
import 'package:giatroo/screens/register_screen.dart';
import 'package:giatroo/screens/search_by_specialty.dart';
import 'package:giatroo/screens/select_area.dart';
import 'package:giatroo/screens/select_city.dart';
import 'package:giatroo/screens/select_doctor_screen.dart';
import 'package:giatroo/screens/settings_screen.dart';
import 'package:giatroo/screens/thankyou_afterhomevisit.dart';
import 'package:giatroo/screens/thankyou_screen.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/API.dart';
import 'Models/AppProvider.dart';
import 'Screens/subSpecialaties.dart';
import 'Models/AppProvider.dart';

//void main() {
//  runApp(MyApp());
//}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  var listener = DataConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case DataConnectionStatus.connected:
        print('Data connection is available.');
        HttpOverrides.global = new MyHttpOverrides();
        runApp(MyApp());
        break;
      case DataConnectionStatus.disconnected:
        print('You are disconnected from the internet.');
        break;
    }
  });

  // close listener after 30 seconds, so the program doesn't run forever
  await Future.delayed(Duration(seconds: 30));
  await listener.cancel();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool newLogin = true;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    callLogin();
    setState(() {});
  }

  void callLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String email = prefs.getString("username");
    String password = prefs.getString("userpass");
    String userToken = prefs.getString("usertoken");

    if (email == null && password == null) {
      newLogin = true;
      loading = false;
      setState(() {});
      return;
    }

    var response = API.userLogin(email, password);
    response.then((value) {
      if (value == true) {
        if (userToken == prefs.getString("usertoken")) {
          newLogin = false;
          loading = false;
          setState(() {});
        } else {
          newLogin = true;
          loading = false;
          setState(() {});
        }
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print('current token is ${AppProvider.userToken}');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (context) => AppProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Giatroo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xFF0070cc), //0xFF1BC0A0 -- -0xFF12B392
          accentColor: Color(0xFF82B1FF), //0xFF74F1D8
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: TextTheme(
              headline6: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto'),
            ),
            brightness: Brightness.dark,
            elevation: 0.0,
          ),
        ),
        home: loading == false
            ? newLogin == true
                ? LoginScreen()
                : HomeScreen()
            : Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              )),
        initialRoute: LoginScreen.routeName,
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          SelectDoctorScreen.routeName: (ctx) => SelectDoctorScreen(),
          DoctorProfileScreen.routeName: (ctx) => DoctorProfileScreen(),
          MoreServicesScreen.routeName: (ctx) => MoreServicesScreen(),
          MoreInsuranceScreen.routeName: (ctx) => MoreInsuranceScreen(),
          ChooseTimeSlotScreen.routeName: (ctx) => ChooseTimeSlotScreen(),
          ConfirmationScreen.routeName: (ctx) => ConfirmationScreen(),
          ThankYouScreen.routeName: (ctx) => ThankYouScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          EditProfile.routeName: (ctx) => EditProfile(),
          ChangePassword.routeName: (ctx) => ChangePassword(),
          ChooseSpecialtyScreen.routeName: (ctx) => ChooseSpecialtyScreen(),
          InsuranceCompaniesScreen.routeName: (ctx) =>
              InsuranceCompaniesScreen(),
          SelectCity.routeName: (ctx) => SelectCity(),
          SelectArea.routeName: (ctx) => SelectArea(),
          FilteringScreen.routeName: (ctx) => FilteringScreen(),
          ContactUs.routeName: (ctx) => ContactUs(),
          AboutUs.routeName: (ctx) => AboutUs(),
          BookDoctorScreen.routeName: (ctx) => BookDoctorScreen(),
          HomeVisitScreen.routeName: (ctx) => HomeVisitScreen(),
          ThankYouAfterHomeVisit.routeName: (ctx) => ThankYouAfterHomeVisit(),
          OffersScreen.routeName: (ctx) => OffersScreen(),
          SearchBySpecialtyScreen.routeName: (ctx) => SearchBySpecialtyScreen(),
          FilterScreen.routeName: (ctx) => FilterScreen(),
          Loading.routeName: (ctx) => Loading(),
          SubSpecialaties.routeName: (ctx) => SubSpecialaties(),
          Reset.routeName: (ctx) => Reset(),
        },
        supportedLocales: [
          Locale('en', ''),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}

///*****************************************************************************/
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
