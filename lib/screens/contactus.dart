import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  static const routeName = 'contact-us-screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: size.width * .9,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(0, 3)),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 32),
                        Icon(
                          Icons.email_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 32),
                        Text(
                          'We will be happy to receive your inquiries and suggestions',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                              labelText: 'Add Message',
                              labelStyle: TextStyle(fontSize: 14)),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: size.height*0.3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'For more call ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              '065001616',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: size.width * .9,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: FlatButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
