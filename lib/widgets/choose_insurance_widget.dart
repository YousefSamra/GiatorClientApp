import 'package:flutter/material.dart';

class ChooseInsuranceWidget extends StatefulWidget {
  @override
  _ChooseInsuranceWidgetState createState() => _ChooseInsuranceWidgetState();
}

class _ChooseInsuranceWidgetState extends State<ChooseInsuranceWidget> {
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

  String _choose = 'Choose Insurance';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.95,
      margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Image.asset(
                  'assets/images/insurance.png',
                  color: Theme.of(context).primaryColor,
                  scale: 1.2,
                ),
                Container(
                  width: 0.4,
                  color: Colors.black,
                  margin: const EdgeInsets.only(right: 8, left: 8),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      'Insurance Companies',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Insurance Companies'),
                              content: SizedBox(
                                height: size.height * 0.8,
                                width: size.width * 0.8,
                                child: setupAlertDialoadContainer(),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: size.width * 0.65,
                        height: 30,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _choose,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              Icons.expand_more,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget setupAlertDialoadContainer() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _listServices.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            setState(() {
              _choose = _listServices[index];
            });
            Navigator.of(context).pop();
          },
          title: Text(_listServices[index]),
        );
      },
    );
  }
}
