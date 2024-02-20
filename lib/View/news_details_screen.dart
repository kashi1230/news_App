import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {
   final String newImage , newTitle, newDate, author,description , content ,source;
  const NewsDetailsScreen({super.key,
    required this.newImage ,
    required this.newTitle ,
    required this.newDate ,
    required this.author ,
    required this.description ,
    required this.content,
    required this.source,

  });

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final format = DateFormat('MMM dd yy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;

    DateTime dateTime = DateTime.parse(widget.newDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.newImage,
                fit: BoxFit.cover,
                placeholder: (context , url)=> Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height*0.4),
            padding: EdgeInsets.only(top: 20,right: 20,left: 20),
            height: height*.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              color: Colors.white
            ),
            child: ListView(
              children: [
                Text(widget.newTitle,style: GoogleFonts.poppins(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700)),
                SizedBox(height: height*.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.source, style: GoogleFonts.poppins(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600)),
                    Text(format.format(dateTime), style: GoogleFonts.poppins(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: height*.03,),
                Text(widget.description,style: GoogleFonts.poppins(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
