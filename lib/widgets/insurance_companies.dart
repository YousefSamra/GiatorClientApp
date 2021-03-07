import 'package:flutter/material.dart';
import 'package:giatroo/screens/more_insurance_screen.dart';

class InsuranceCompanies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
      padding: const EdgeInsets.all(8),
      width: size.width * 0.95,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/insurance.png',
                scale: 1.5,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 8),
              Text(
                "Insurance Companies",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Wrap(
            children: [
              _cardTextInsurance('MedNet'),
              _cardTextInsurance('Medvisa'),
              _cardTextInsurance('Nat Health'),
              _cardTextInsurance('Palestine Bank'),
              _cardTextInsurance('Islamic Bank'),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MoreInsuranceScreen.routeName);
                  },
                  child: _cardTextInsurance('+28')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardTextInsurance(text) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
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
