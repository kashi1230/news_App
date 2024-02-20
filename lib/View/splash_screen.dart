
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homescreen.dart';

class SplashiScreen extends StatefulWidget {
  const SplashiScreen({super.key});

  @override
  State<SplashiScreen> createState() => _SplashiScreenState();
}

class _SplashiScreenState extends State<SplashiScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height*1;
    final width = MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/news.jpg',
              fit: BoxFit.cover,
              width: width *.9,
              height: height * .5,
            ),

            SizedBox(height: height*0.04),
            Text(
              "Top Headlines",
              style: GoogleFonts.anton(
              letterSpacing: .6,
                  color: Colors.grey.shade700
              ),),
            SizedBox(height: height*0.04),

            SpinKitChasingDots(size:40, color: Colors.blue,)
          ],
        ),
      ),
    );
  }
}
