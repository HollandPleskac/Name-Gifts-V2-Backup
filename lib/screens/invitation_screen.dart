import 'package:flutter/material.dart';
import 'package:name_gifts_v2/constant.dart';

class InvitationScreen extends StatefulWidget {
  @override
  _InvitationScreenState createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: SClipper(),
            child: Container(
              height: 350,
              width: double.infinity,
              color: kRecovercolor,
            ),
          ),
          
        ],
      ),
    );
  }
}

class SClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 80);
    var firstControlPoint = new Offset(size.width / 4, size.height - 90);
    var firstEndPoint = new Offset(size.width / 2, size.height- 160);
    var secondControlPoint =
        new Offset(size.width - (size.width / 4), size.height - 235);
    var secondEndPoint = new Offset(size.width , size.height - 230);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// var path = new Path();
//     path.lineTo(0, size.height - 20);
//     var firstControlPoint = new Offset(size.width / 4, size.height);
//     var firstEndPoint = new Offset(size.width / 2, size.height- 90);
//     var secondControlPoint =
//         new Offset(size.width - (size.width / 4), size.height - 210);
//     var secondEndPoint = new Offset(size.width , size.height - 205);

//     path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
//         firstEndPoint.dx, firstEndPoint.dy);
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
//         secondEndPoint.dx, secondEndPoint.dy);

//     path.lineTo(size.width, size.height / 3);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;