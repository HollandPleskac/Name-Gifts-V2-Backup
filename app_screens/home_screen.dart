import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant.dart';

final Firestore _firestore = Firestore.instance;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List<String> eventsList = ['Pleskac Christmas List 2020', 'testing'];
  // get the variable below from shared prefs
  // just to initialize the starting value of selectedEventDisplay
  String selectedEventDisplay = 'Pleskac Christmas List 2020';
  String selectedEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: EdgeInsets.only(left: 40, top: 50, right: 20),
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF3383CD),
                    Color(0xFF11249F),
                  ],
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/virus.png"),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        // SvgPicture.asset(
                        //   'assets/icons/Drcorona.svg',
                        //   width: 210,
                        //   fit: BoxFit.fitWidth,
                        //   alignment: Alignment.topCenter,
                        // ),
                        Positioned(
                          top: 60,
                          left: 80,
                          child: Wrap(
                            children: <Widget>[
                              Text(
                                selectedEventDisplay,
                                style: kHeadingTextStyle.copyWith(
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(), // dont know why this works ??
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          ////
          ////
          ////
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Color(0xFFE5E5E5),
              ),
            ),
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("user data")
                    .document('HpVdivf2z7MRwu4nppw8m6CVTpp1')
                    .collection('my events')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Text("Loading.....");
                  else {
                    List<DropdownMenuItem> dropdownEvents = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data.documents[i];
                      dropdownEvents.add(
                        DropdownMenuItem(
                          child: Text(
                            documentSnapshot['event name'],
                            style: kSubTextStyle.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: "${documentSnapshot['event name']}",
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.event,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            underline: SizedBox(),
                            icon: Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Icon(Icons.arrow_drop_down),
                            ),

                            value: selectedEvent,
                            items: dropdownEvents,
                            onChanged: (newEventSelected) {
                              setState(() {
                                // you actually need two varialbles (selectedEvent and selectedEventDisplay) to get the dropdown to work ??
                                this.selectedEvent = newEventSelected;
                                this.selectedEventDisplay = newEventSelected;
                              });
                            },
                            // this hint needs to come from shared preferences
                            // shared prefs will show the currently selected event when the user signs in
                            hint: Text(
                              selectedEventDisplay,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ),

          //                                 Example of a dropdown with a list instead of firebase
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 20),
          //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //   height: 60,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(25),
          //     border: Border.all(
          //       color: Color(0xFFE5E5E5),
          //     ),
          //   ),
          //   child: Row(
          //     children: <Widget>[
          //       Icon(Icons.perm_camera_mic),
          //       SizedBox(
          //         width: 20,
          //       ),
          //       Expanded(
          //         child: DropdownButton<String>(
          //           isExpanded: true,
          //           underline: SizedBox(),
          //           icon: Container(
          //             width: 10,
          //             height: 10,
          //             child: Icon(Icons.arrow_drop_down),
          //           ),
          //           value: selectedEventDisplay,
          //           items: eventsList
          //               .map<DropdownMenuItem<String>>((String dropDownItem) {
          //             return DropdownMenuItem<String>(
          //               value: dropDownItem,
          //               child: Text(dropDownItem),
          //             );
          //           }).toList(),
          //           onChanged: (String newValueSelected) {
          //             setState(() {
          //               this.selectedEvent = newValueSelected;
          //             });
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Event Members\n",
                            style: kTitleTextstyle,
                          ),
                          TextSpan(
                            text: selectedEventDisplay,
                            style: TextStyle(
                              color: kTextLightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    //it can be annoying to skroll through 7 people so just search

                    InkWell(
                      child: Text(
                        "Search",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 250,
            child: StreamBuilder(
              stream: _firestore
                  .collection("events")
                  .document('7311581S106O0Y320444')
                  .collection('event members')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    return Center(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: snapshot.data.documents.map(
                          (DocumentSnapshot document) {
                            return family(
                              context: context,
                              familyName: document['family name'],
                              gifts: document['gifts'],
                              members: document['members'],
                            );
                          },
                        ).toList(),
                      ),
                    );
                }
              },
            ),
          ),
          // Container(
          //   height: 250,
          //   child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     physics: BouncingScrollPhysics(),
          //     children: <Widget>[
          //       family(context),
          //       family(context),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

Widget family(
    {BuildContext context, String familyName, int gifts, int members}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      height: 250,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        //boxShadow: [
        //BoxShadow(
        //blurRadius: 2,
        //offset: Offset(8, 8),
        //color: Color(000000).withOpacity(.2),
        //spreadRadius: -5),
        //],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profilePic(context),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20),
                  child: text(context, familyName),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 45, left: 40),
                  child: information(context, members, gifts),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 55, left: 95),
                    child: viewButton(context, 'uid', 'eventId', 'display name'))
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget profilePic(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.16,
    width: MediaQuery.of(context).size.height * 0.16,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        color: Colors.black,
        width: 3,
      ),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(23),
      child: Image.network(
        //'https://i.pinimg.com/originals/9e/e8/9f/9ee89f7623acc78fc33fc0cbaf3a014b.jpg',
        'https://free4kwallpapers.com/uploads/originals/2020/01/07/animated-colorful-landscape-wallpaper.jpg',
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget text(BuildContext context, String name) {
  return Text(
    name,
    style: kHeadingTextStyle.copyWith(color: Colors.black, fontSize: 28),
  );
}

Widget information(BuildContext context, int members, int gifts) {
  return Row(
    children: <Widget>[
      Row(
        children: <Widget>[
          Text(
            members.toString(),
            style: kHeadingTextStyle.copyWith(
              color: Color(0xFF3383CD),
              fontSize: 32,
            ),
          ),
          Text(
            ' Members',
            style: kSubTextStyle.copyWith(),
          ),
        ],
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.05,
      ),
      Row(
        children: <Widget>[
          Text(
            gifts.toString(),
            style: kHeadingTextStyle.copyWith(
              color: Color(0xFF3383CD),
              fontSize: 32,
            ),
          ),
          Text(
            ' Gifts',
            style: kSubTextStyle.copyWith(),
          ),
        ],
      ),
    ],
  );
}

Widget viewButton(
    BuildContext context, String uid, String eventId, String displayName) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.05,
    width: MediaQuery.of(context).size.width * 0.2,
    child: FlatButton(
      onPressed: () async {},
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      child: Text('View', style: kSubTextStyle.copyWith(color: Colors.white)),
    ),
  );
}
