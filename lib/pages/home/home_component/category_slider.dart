import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/Category/category.dart';
import 'dart:async' show Future, Timer;
import 'package:shimmer/shimmer.dart';

class CategorySlider extends StatefulWidget {
  List  data ;
  CategorySlider(this.data);

  @override
  _CategorySliderState createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  bool _shimmer = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();




  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return


      Container(
        width: width,
        height: height/8,
        color: Theme.of(context).appBarTheme.color,
        child: Container(
          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(width: 5.0),

              ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.data == null?0:widget.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = widget.data[index];
                  return

                    SingleChildScrollView(
                      child: Row(
                        children: [
                          SizedBox(width: 5.0),

                          InkWell(
                            onTap: () {
                              if(cat["sub_categories"].length != 0){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryPage(
                                        categoryName:"${cat["name"]}" ,data:cat["sub_categories"]
                                    ),
                                  ),
                                );
                              }

                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1.5,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(width/20, height/80, width/20, height/80),
                                    child: Text( "${cat["name"]}"
                                      ,
                                      style: TextStyle(
                                        fontFamily: 'Jost',
                                        fontWeight: FontWeight.bold,
                                        fontSize: width/25,
                                        color: Colors.white,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5.0),

                        ],
                      ),
                    )

                  ;
                },
              ),




            ],
          ),
        ),
      )
    ;
  }
}











class CategorySlider2 extends StatefulWidget {
  @override
  _CategorySlider2State createState() => _CategorySlider2State();
}

class _CategorySlider2State extends State<CategorySlider2> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: 90.0,
      child: Container(
        margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 5.0),
            SingleChildScrollView(
              child: Row(
                children: [
                  SizedBox(width: 5.0),

                  InkWell(
                    onTap: () {


                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width:width/4,
                          height: height/17,
                          decoration: BoxDecoration(
                            color: Colors.grey,

                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width/20, height/80, width/20, height/80),
                            child: Text( "${""}"
                              ,
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0),

                  InkWell(
                    onTap: () {


                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width:width/4,
                          height: height/17,
                          decoration: BoxDecoration(
                            color: Colors.grey,

                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width/20, height/80, width/20, height/80),
                            child: Text( "${""}"
                              ,
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0),

                  InkWell(
                    onTap: () {


                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width:width/4,
                          height: height/17,
                          decoration: BoxDecoration(
                            color: Colors.grey,

                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width/20, height/80, width/20, height/80),
                            child: Text( "${""}"
                              ,
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0),

                  InkWell(
                    onTap: () {


                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width:width/4,
                          height: height/17,
                          decoration: BoxDecoration(
                            color: Colors.grey,

                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width/20, height/80, width/20, height/80),
                            child: Text( "${""}"
                              ,
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0),

                  InkWell(
                    onTap: () {


                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width:width/4,
                          height: height/17,
                          decoration: BoxDecoration(
                            color: Colors.grey,

                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width/20, height/80, width/20, height/80),
                            child: Text( "${""}"
                              ,
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0),

                ],
              ),
            ),
            SizedBox(width: 5.0),
          ],
        ),
      ),
    );
  }
}
