import 'package:emall/Dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dwidth,
      height: Dheight,
      child: Center(
        child: Text("Support Us"),
      ),
    );
  }
}
