import 'package:flutter/material.dart';
import 'package:giatroo/screens/filtering_screen.dart';

class InsuranceCompaniesScreen extends StatelessWidget {
  static const routeName = 'insurance-companies-screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List _listInsurance = [
      'All insutances',
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Insurance Companies'),
      ),
      body: Column(
        children: [
          Container(
            width: size.width,
            height: 70,
            color: Color(0xffFAFAFA),
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              //controller: _controller,
              cursorColor: Theme.of(context).primaryColor,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search Insurances Providers',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: _listInsurance.length,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (ctx, index) {
                  return ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, FilteringScreen.routeName);
                          },
                          title: Text(
                            '${_listInsurance[index]}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12,
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
