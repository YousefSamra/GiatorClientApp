import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/Specialities.dart';
import 'package:giatroo/screens/filtering_screen.dart';

class SearchBySpecialtyScreen extends StatefulWidget {
  static const routeName = 'search-by-specialty';
  @override
  _SearchBySpecialtyScreenState createState() =>
      _SearchBySpecialtyScreenState();
}

class _SearchBySpecialtyScreenState extends State<SearchBySpecialtyScreen> {
  static List<Specialaties> specialaties = [];
  @override
  void initState() {
    super.initState();
    API.getAllSpecialities().then((value) {
      specialaties.addAll(value);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List _listName = [
      '',
      'Dermatology',
      'Dentistry',
      'Psychaitry',
      'Pediatrics and New Born',
      'Neurology',
      'Orthopedics',
      'Gynaecology and Infertility',
      'Ear, Nose and Throat',
      'Cardiology and Vascular Disease',
      'Allergy and Immunology',
      '',
      'Andrology and Male Infertility',
      'Audiology',
      'Cardiology and Thoracic Surgery',
      'Chest and Respiratory',
      'Disbetes and Endocrinology',
      'Dietitian and Nutrition',
      'Emergency and Accidents Medicine',
      'Family Medicine',
      'Gastroenterology and Endoscopy',
      'General Practice',
      'General Surgery',
      'Hematology',
      'Hepatology',
      'Internal Medicine',
      'IVF and Infertility',
      'Nephrology',
      'Neurosurgery',
      'Obesity and Laparoscopic Surgery',
      'Oncology',
      'Ophthalmology',
      'Pain Management',
      'Pediatric Surgery',
      'Phoniatrics',
      'Physiotherapy and Sport Injuries',
      'Plastic Surgery',
      'Rheumatology',
      'Spinal Surgery',
      'Urology',
      'Vascular Surgery',
    ];
    List _listIcon = [
      '',
      'assets/images/icons/dermathology.png',
      'assets/images/icons/dentistry.png',
      'assets/images/icons/psychiatry.png',
      'assets/images/icons/pediatrics-and-new-born.png',
      'assets/images/icons/neurology.png',
      'assets/images/icons/orthopedic.png',
      'assets/images/icons/gynecology.png',
      'assets/images/icons/nose.png',
      'assets/images/icons/cardiology.png',
      'assets/images/icons/allergy.png',
      '',
      'assets/images/icons/andrology.png',
      'assets/images/icons/Audiology.png',
      'assets/images/icons/cardiology-thoracic.png',
      'assets/images/icons/respiratory.png',
      'assets/images/icons/endocrinology.png',
      'assets/images/icons/nutrition.png',
      'assets/images/icons/accident-medicine.png',
      'assets/images/icons/family.png',
      'assets/images/icons/stomach.png',
      'assets/images/stethoscope.png',
      'assets/images/icons/surgery.png',
      'assets/images/icons/blood.png',
      'assets/images/icons/liver.png',
      'assets/images/icons/stomach.png',
      'assets/images/icons/in-vitro.png',
      'assets/images/icons/kidneys.png',
      'assets/images/icons/neurology.png',
      'assets/images/icons/liposuction.png',
      'assets/images/icons/oncology.png',
      'assets/images/icons/eye.png',
      'assets/images/icons/pain.png',
      'assets/images/icons/baby-boy.png',
      'assets/images/icons/speak.png',
      'assets/images/icons/injury.png',
      'assets/images/icons/plastic-surgery.png',
      'assets/images/icons/rheumatology.png',
      'assets/images/icons/spine.png',
      'assets/images/icons/urology.png',
      'assets/images/icons/vessel.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Search by specialty'),
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
                hintText: 'Search for Specialties',
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
                itemCount: specialaties.length,
                separatorBuilder: (context, index) {
                  return index == 0 || index == 11
                      ? Divider(color: Colors.transparent)
                      : Divider();
                },
                itemBuilder: (ctx, index) {
                  return index % 11 == 0 && index <= 11
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text(
                            index == 0
                                ? 'Most Popular Specialities'
                                : 'Other Specialities',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                      : ListTile(
                          onTap: () {
                            AppProvider.sepecialityId = specialaties[index].id;
                            AppProvider.sepcialityName =
                                specialaties[index].name;
                            Future.delayed(Duration(seconds: 1)).then((value) {
                              AppProvider.serviceType = 2;
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, FilteringScreen.routeName);
                            });
                            setState(() {});
                          },
                          // leading: Image.asset(
                          //   'assets/images/icons/injury.png',
                          //   color: Theme.of(context).primaryColor,
                          // ),
                          title: Text(
                            '${specialaties[index].name}',
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
