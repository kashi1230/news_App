
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/news_channel_healines_model.dart';
import 'package:news_app/View/CategorieScreen.dart';
import 'package:news_app/View/news_details_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

import '../Models/categories_news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  final format = DateFormat('MMM dd yy');
  String  name='bbc-News';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;

    return  Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight:Radius.circular(30),bottomLeft: Radius.circular(30))
        ),

        actions: [
          PopupMenuButton<FilterList>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40),topRight: Radius.circular(15) ,topLeft:  Radius.circular(15))
            ),
            icon: Icon(Icons.more_horiz,color: Colors.white),
          onSelected: (FilterList item){
              if(FilterList.bbcNews.name == item.name){
                name = 'bbc-News';
              }
              if(FilterList.aryNews.name == item.name){
                name = 'ary-news';
              }
              if(FilterList.cnn.name == item.name){
                name = 'cnn';
              }
              if(FilterList.aljazeera.name == item.name){
                name = 'al-jazeera-english';
              }

              setState(() {
                selectedMenu=item;
              });

          },
            initialValue: selectedMenu,
              itemBuilder: (context)=><PopupMenuEntry<FilterList>>[
                const PopupMenuItem<FilterList>(
                  value: FilterList.bbcNews,
                  child: Text("BBC News"),
                ), const PopupMenuItem<FilterList>(
                  value: FilterList.aryNews,
                  child: Text("Ary News"),
                ), const PopupMenuItem<FilterList>(
                  value: FilterList.aljazeera,
                  child: Text("Al-jazera-News"),
                ), const PopupMenuItem<FilterList>(
                  value: FilterList.cnn,
                  child: Text("CNN"),
                )
              ]
          )
        ],
          backgroundColor: Colors.black,
        // elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesScreen()));
          },
          icon: Image.asset('images/categories.png',height: 30,width: 30,color: Colors.white),
        ),
        title:  Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Text("News",style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.white),),
        ),
        // )
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
              SizedBox(
                child: Container(
                  height: height*.55,
                  width: width,
                  child: FutureBuilder<NewschanelsHeadlinesModel>(
                      future: newsViewModel.fetchNewschannelheadlinesApi(name),
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
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.articles!.length,
                            itemBuilder: (context , index){
                            DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context)=>NewsDetailsScreen
                                    (
                                      newImage: snapshot.data!.articles![index].urlToImage.toString(),
                                      newTitle: snapshot.data!.articles![index].title.toString(),
                                      newDate: snapshot.data!.articles![index].publishedAt.toString(),
                                      author: snapshot.data!.articles![index].author.toString(),
                                      description: snapshot.data!.articles![index].description.toString(),
                                      content: snapshot.data!.articles![index].content.toString(),
                                      source: snapshot.data!.articles![index].source!.name.toString()
                                  )));
                                },
                                child: SizedBox(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      //for showing images

                                      Container(
                                        height: height *0.6,
                                        width: width * 0.9,
                                        padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                                        child: ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                            fit: BoxFit.cover,
                                            placeholder: (context , url) => Container(child: spinkit2,),
                                            errorWidget: (context , url ,error) => const Icon(Icons.error_outline,color: Colors.red,),
                                          ),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),

                                      Positioned(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: width * 0.7,
                                                  // height: height * 0.22,
                                                  child:
                                                  Text(
                                                    snapshot.data!.articles![index].title.toString(),
                                                    style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.bold),
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  width: width * 0.7,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        snapshot.data!.articles![index].source!.name.toString(),
                                                        style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.blue),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      Text(
                                                        format.format(dateTime),
                                                        style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500,),
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  ),
                                                )
                                              ],
                                            ),
                                            alignment: Alignment.bottomCenter,
                                            height: height * 0.22,
                                            padding: const EdgeInsets.only(left: 12,right: 12),
                                          ),
                                          elevation: 5,
                                          color: Colors.white,
                                        ),
                                        bottom: 20,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      }
                    }
                  ),
                ),
              ),
                 Padding(
                  padding: const EdgeInsets.all(20),
                  child: FutureBuilder<CtegoriesNewsModel>(
                      future: newsViewModel.fetchcategoriesNewsApi('Genral'),
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
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
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
              ),

            ],
          ),
      ),
      
    );
  }
}

enum FilterList{bbcNews,aryNews,ruters,cnn,aljazeera}

const spinkit2 = SpinKitFadingCircle(
  color:Colors.amber,
  size: 50,
);
