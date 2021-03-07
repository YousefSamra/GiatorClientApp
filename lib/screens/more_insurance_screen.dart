import 'package:flutter/material.dart';

class MoreInsuranceScreen extends StatelessWidget {
  static const routeName = 'more-insurance-screen';

  List _listServices = [
    'MedNet',
    'Medvisa',
    'Nat Health',
    'Palestine Bank',
    'Islamic Bank',
    'Jordan Insurance Company',
    'American Life Insurance Company (Metlife)',
    'Middle East Insurance Company',
    'Watania National Insurance Company',
    'United Insurance Limited',
    'AL Manara Insurance Company',
    'Arabia Insurance Company - Jordan',
    'Jerusalem Insurance Company',
    'AL-Nisr Al-Arabi Insurance',
    'Jordan French Insurance',
    'Delta Insurance Company',
    'Al SAFWA Insurance PSC',
    'Jordan Bank',
    'Holy Land Insurance Company',
    'Philadelphia Insurance Company',
    'Arab Life & Accidents Ins.',
    'Arab Assurers Company',
    'Islamic Insurance Company',
    'Arab Union International Ins.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insurance Companies"),
      ),
      body: Wrap(
        children:_listServices.map((item) => _cardTextInsurance(item)).toList().cast<Widget>(),
      ),
    );
  }

  Widget _cardTextInsurance(text) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top:8,right: 8,left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xff1BC0A0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
