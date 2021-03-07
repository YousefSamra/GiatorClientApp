import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'filtering_screen.dart';

class Loading extends StatefulWidget {
  static const routeName = 'Looding';
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void _loadNextPage() async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => FilteringScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
