

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/categories_news_model.dart';

import '../view_model/news_view_model.dart';
import 'homescreen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMM dd yy');
  String  Categoriename='General';

  List<String> categoriesList =[
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Buisness',
    'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          },
            child: Icon(Icons.chevron_left_rounded,color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                  itemBuilder: (context ,index){
                    return InkWell(
                      onTap: (){
                        Categoriename = categoriesList[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            color:  Categoriename == categoriesList[index] ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child:Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                                child: Text(categoriesList[index].toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: Colors.black
                                  ),
                                )),
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
            SizedBox(height: 20),

            Expanded(
              child: FutureBuilder<CtegoriesNewsModel>(
                  future: newsViewModel.fetchcategoriesNewsApi(Categoriename),
                  builder: (BuildContext , snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(
                        child: SpinKitSpinningLines(
                          size: 40,
                          color: Colors.black,
                        ),
                      );
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context , index){
                            DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      height: height*.18,
                                      width: width*.3,
                                      fit: BoxFit.cover,
                                      placeholder: (context , url) => Container(child: spinkit2,),
                                      errorWidget: (context , url ,error) => const Icon(Icons.error_outline,color: Colors.red,),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  Expanded(
                                      child:Container(
                                        padding: EdgeInsets.only(left: 15),
                                        height: height*.18,
                                        child: Column(
                                          children: [
                                            Text(snapshot.data!.articles![index].title.toString(),
                                              maxLines: 3,
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700
                                              ),

                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(snapshot.data!.articles![index].source!.name.toString(),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600
                                                  ),

                                                ),
                                                Text(format.format(dateTime),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.blue,
                                                      fontWeight: FontWeight.w700
                                                  ),

                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                  )

                                ],
                              ),
                            );
                          }
                      );
                    }
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
