import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';

import '../NewsModel.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {

  List<NewsModel>  newsModelList = <NewsModel>[];
  List<String> navBarItems = [
    "Top news" ,"india","udaipur","ctae","apple","banana",
    "hindustan","bharat","yash","hello","how","are  ","you ","guys"
  ];
bool isLoading = true;
  getNewsByQuery() async{
    Response response= await get(Uri.parse("https://newsapi.org/v2/everything?q=world&from=2023-03-05&sortBy=publishedAt&apiKey=fa5b68512b554d3e944fc2d475bd9c55"));
   Map data = jsonDecode(response.body);
  setState(() {
    data["articles"].forEach((element){
      NewsModel newsmodel = new NewsModel();
      newsmodel= NewsModel.fromMap(element);
      newsModelList.add(newsmodel);
      setState(() {
        isLoading = false;
      });
    });
  });

  }

  @override
  void initState() {
    getNewsByQuery();
    print(newsModelList);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xff213A50),
                    Color(0xff071938)
                  ]
              )
          ),
        ),
        SingleChildScrollView(
          child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height*0.05,
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: navBarItems.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return Container(
                           // padding: EdgeInsets.only(left: 10),
                            margin: EdgeInsets.only(left: 10),
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Center(child: Text(navBarItems[index])),
                          );
                        }
                    ),
                  ),

                  //SlideShow
                    CarouselSlider(items:newsModelList.map((instance) {
                      return Builder(builder: (context) {
                        return Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                         //   margin: EdgeInsets.all(20.0),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  child: Image.network(instance.newsImg,fit: BoxFit.fill,),
                                ),
                                Positioned(
                                    left: 0,
                                    bottom:0,
                                    right:0,
                                    child: Container(
                                        height : 40,
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10)),
                                        ) ,
                                        child: Text(instance.newsHead , style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15),)))
                              ],

                            ),

                          ),
                        );
                      }
                      );
                    }).toList(),
                    options:  CarouselOptions(
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                   //   autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),),
                  //listview
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      itemCount: newsModelList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.all(20.0),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  child: Image.network(newsModelList[index].newsImg, fit: BoxFit.cover)
                                ),
                                Positioned(
                                    left: 0,
                                    bottom:0,
                                    right:0,
                                    child: Container(

                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                        color: Colors.white70,
                                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10)),
                                        ) ,
                                        child:Column(
                                            children: [
                                          Text(newsModelList[index].newsHead , style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15),),
                                         // Text(newsModelList[index].newsdes.length >50 ?  "${newsModelList[index].newsdes.substring(0,55)}...." : newsModelList[index].newsdes)
                                            ],)))
                              ],

                            ),
                          );
                      },)

                ],
              )
          ),
        ),

      ],
    ),
    );
  }
}
