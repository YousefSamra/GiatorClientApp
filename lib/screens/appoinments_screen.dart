import 'package:flutter/material.dart';
import 'package:giatroo/Models/API.dart';
import 'package:giatroo/Models/AppProvider.dart';
import 'package:giatroo/Models/clientVisit.dart';
import 'package:giatroo/screens/home_screen.dart';
import 'package:provider/provider.dart';

class AppoinmentsScreen extends StatefulWidget {
  @override
  _AppoinmentsScreenState createState() => _AppoinmentsScreenState();
}

class _AppoinmentsScreenState extends State<AppoinmentsScreen> {
  @override
  ScrollController _controller;
  bool _loading;
  List<Widget> circleAvatar = [];
  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<ClientVisit>> clientVisitsFuture =
        Provider.of<AppProvider>(context, listen: false).getClientsVisits();
    return Scaffold(
      backgroundColor: Color(0xffE1E5E8),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Appoinments'),
      ),
      body: FutureBuilder(
        future: clientVisitsFuture,
        builder: (context, AsyncSnapshot<List<ClientVisit>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueGrey,
              ),
            );
          }

          snapshot.data.forEach((element) {
            circleAvatar.add(CircleAvatar(
              key: ValueKey(element.id),
              backgroundColor: Colors.white,
              radius: 20,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                ),
                color: Colors.white,
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmation'),
                        content: Text(' Are You Shure ?'),
                        actions: [
                          FlatButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () async {
                              _loading = true;
                              print(element.id);
                              await API
                                  .cancelAppointment(element.id)
                                  .then((value) {
                                setState(() {
                                  _loading = false;
                                });
                                setState(() {});
                              }).whenComplete(() {
                                setState(() {});
                                // Scaffold.of(context).showSnackBar(new SnackBar(
                                //     content: new Text(element.dayTime)));
                              });
                              Navigator.pop(context);

                              Navigator.popAndPushNamed(
                                  context, HomeScreen.routeName);
                            },
                            child: Text('OK'),
                          ),
                          FlatButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ));
          });
          return ListView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: true, // use it
            itemBuilder: (context, index) {
              return Column(
                children: [
                  if (snapshot.data[index].visit_status_id == 1)
                    bookContainer(context, index, snapshot.data)
                  else
                    cancelContainer(context, index, snapshot.data)
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget bookContainer(
      BuildContext ctx, index, List<ClientVisit> clientVisits) {
    Size size = MediaQuery.of(ctx).size;

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(ctx).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/calendar2.png',
                  color: Colors.white,
                  scale: 1.5,
                ),
                const SizedBox(width: 8),
                Text(
                  clientVisits[index].dayTime,
                  //   'Moday, 08 Mar. 2021 04:50 PM',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage:
                                clientVisits[index].profile_picture != null
                                    ? NetworkImage(
                                        clientVisits[index].profile_picture)
                                    : AssetImage('assets/images/dr.png'),
                            radius: 28,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              clientVisits[index].doctor_Name,
                              style: TextStyle(
                                color: Theme.of(ctx).primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              clientVisits[index].service_name,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        Image.asset(
                          'assets/images/location.png',
                          scale: 2,
                          color: Theme.of(ctx).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: size.width * 0.6,
                          child: Text(
                            clientVisits[index].full_address,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              /* Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Icon(
                        Icons.call,
                        color: Theme.of(ctx).primaryColor,
                        size: 24,
                      ),
                      Text(
                        clientVisits[index].service_name,
                        style: TextStyle(
                            color: Theme.of(ctx).primaryColor, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),*/
            ],
          ),
          Divider(),
          const SizedBox(height: 8),
          Row(
            children: [
              /*Expanded(
                flex: 1,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(ctx).primaryColor,
                      radius: 21,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Image.asset(
                            'assets/images/location.png',
                            scale: 1.5,
                            color: Theme.of(ctx).primaryColor,
                          ),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Map',
                      style: TextStyle(
                        color: Theme.of(ctx).primaryColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),*/
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Theme.of(ctx).primaryColor,
                        radius: 21,
                        child: _loading == false
                            ? circleAvatar[index]
                            : Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.blueAccent,
                                ),
                              )),
                    const SizedBox(height: 4),
                    Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(ctx).primaryColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              /* Expanded(
                flex: 1,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(ctx).primaryColor,
                      radius: 21,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.report_problem_outlined,
                            color: Theme.of(ctx).primaryColor,
                          ),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Report Problem',
                      style: TextStyle(
                        color: Theme.of(ctx).primaryColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),*/
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget cancelContainer(
      BuildContext ctx, index, List<ClientVisit> clientVisits) {
    return Container(
      //padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              clientVisits[index].dayTime,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
          Divider(),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              clientVisits[index].doctor_Name,
              style: TextStyle(
                color: Theme.of(ctx).primaryColor,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              clientVisits[index].service_name,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Divider(),
          const SizedBox(height: 4),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                clientVisits[index].visit_status_name,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
