import 'package:flutter/material.dart';
import 'dart:async' show Future, Timer;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io' ;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_store/config.dart';
import 'package:shimmer/shimmer.dart';
import 'package:my_store/pages/product/product.dart';
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:my_store/pages/home/products/product_list_view.dart';
// My Own Import
import 'package:my_store/pages/home/home_component/category_slider.dart';
import 'package:my_store/pages/home/home_component/deal_of_the_day.dart';
import 'package:my_store/pages/home/home_component/new_main_slider.dart';
import 'package:my_store/pages/home/home_component/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final categoryList = [
    {'title': 'cusa', 'image': 'assets/deal_of_the_day/null.png'},
    {'title': 'cusa', 'image': 'assets/deal_of_the_day/null.png'},
    {
      'title': 'cusa',
      'image': 'assets/category_grid/brand3.jpg'
    },
    {'title': 'cusa', 'image': 'assets/deal_of_the_day/null.png'}
  ];
  List list = [];
  List map = [];
  List over =[];
  List popular =[];
  List  new_item =[];
 List brands = [];
 List sliders = [];
  bool _shimmer = true;

  List list1 = [];
  List map1 = [];
  List items = [];
  bool _load = true  ;

  void initState() {
    super.initState();
    list = [];
    over =[];
    popular =[];
    new_item =[];
    brands =[];
    sliders = [];
    getCategories();
    _load = true  ;

  }

  getCategories() async {
try{
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      http.Response response =
      await http.get(Config.url+"categories");


      if (response.statusCode == 200) {
        //for (var one in json.decode(response.body)["data"]) {
        //  map.add(one["name"]);
        //  }
        if (this.mounted) {

          setState(() {
            list = json.decode(response.body)["data"]["categories"];
            over =json.decode(response.body)["data"]["over"];
            popular =json.decode(response.body)["data"]["popular"];
            new_item =json.decode(response.body)["data"]["new"];
            brands =json.decode(response.body)["data"]["brands"];
            sliders =json.decode(response.body)["data"]["sliders"];

          });
        }


        if(sliders.length>0){
          for(var one in sliders){
         //   print( one["img_full_path"]);
            if (this.mounted) {
              setState(() {
                items.add(
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) =>
                            ProductListView(one["id"], "sliders",)));
                      },
                      child: Image.network(
                        one["img_full_path"],
                        fit: BoxFit.cover,
                      ),
                    )

                );
              });
            }
          }
        }
       // print(list.length);
       // print(list);
      }
    }else{
      Fluttertoast.showToast(
        msg: 'no internet ',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }
    } on SocketException {

      Fluttertoast.showToast(
        msg: 'no internet ',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }
if (this.mounted) {
  setState(() {
    _load = false;
    _shimmer = false;
  });
}
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        // Category Slider Start
           _load ?CategorySlider2(): CategorySlider(list) ,
        // Category Slider End

        // Main Slider Start
        // MainSlider(),
        NewMainSlider(sliders,items),
        // Main Slider End
       // SizedBox(height: 5.0,),
        //Divider(),



        // Menu End
       SizedBox(height: 5.0,),
        // Featured Item Start
       DealOfTheDay(brands),
        // Featured Item End

       // SizedBox(height: 5.0,),
       // Divider(),
       // SizedBox(height: 5.0,),

        // Category Grid Start
       // CategoryGrid(),
        // Category Grid End


        SizedBox(height: 10.0,),

        // Item Discount Start
        Container(
          width: width,
          height: height/2.2,
          color: Theme.of(context).appBarTheme.color,
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(" وصل حديثا",
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: width/25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.0),


              (_shimmer)
                  ? Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.white,
                child: Container(
                  height: 245.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        Map cat =  categoryList[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).appBarTheme.color,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0.7,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              child:   SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Hero(
                                      tag: Text(
                                          "${cat["title"]}"),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            height: 170.0,
                                            width: 170.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    cat["image"]
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            margin: EdgeInsets.all(6.0),
                                          ),
                                          Positioned(
                                            top: 0.0,
                                            left: 0.0,
                                            child: Container(
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                color: Colors.pinkAccent,
                                                borderRadius:
                                                BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(10.0),
                                                  bottomRight:
                                                  Radius.circular(
                                                    10.0,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                  cat["title"],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          right: 6.0, left: 6.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            cat["title"],
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Jost',
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.6,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                cat["title"],
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                width: 7.0,
                                              ),
                                              Text(
                                                cat["title"],
                                                style: TextStyle(
                                                    fontSize: 13.0,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey),
                                                overflow:
                                                TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {

                            },
                          ),
                        );
                      }),
                ),
              )
                  : Container(
                height: height/2.7,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: new_item.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      Map cat =  new_item[index];
                      return
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).appBarTheme.color,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0.7,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Hero(
                                      tag: Text(
                                          "${cat["id"]}"),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            height: height/4,
                                            width: width/1.8,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: NetworkImage(cat["img_full_path"]),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            margin: EdgeInsets.all(6.0),
                                          ),
                                          Positioned(
                                            top: 0.0,
                                            left: 0.0,
                                            child: Container(
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                color: Colors.pinkAccent,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(10.0),
                                                  bottomRight: Radius.circular(
                                                    10.0,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                  "${cat["precentage"]} - %",
                                                  style: TextStyle(
                                                    fontSize: width/28,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          right: 6.0, left: 6.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            cat["name"],
                                            style: TextStyle(
                                              fontSize: width/25,
                                              fontFamily: 'Jost',
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.6,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "${cat["over_price"]} KW ", textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: width/24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                width: 7.0,
                                              ),
                                              Text(
                                                "${cat["price"]} KW ", textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                    fontSize: width/30,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                    data: Product(
                                      id : cat["id"],
                                      name : cat["name"],
                                      description : cat["description"],
                                      price : cat["price"].toDouble(),
                                      overPrice : cat["over_price"].toDouble(),
                                      brandId : cat["brand_id"],
                                      made : cat["made"],
                                      subCategoryId : cat["subCategory_id"],
                                      categoryId : cat["category_id"],
                                      qut : cat["qut"],
                                      pay : cat["pay"],
                                      view : cat["view"],
                                      newItem : cat["new"],
                                      popular : cat["popular"],
                                      over : cat["over"],
                                      subSubCategoryId : cat["subSubCategory_id"],
                                      img : cat["img"],
                                      activity : cat["activity"],
                                      numItem : cat["new"],
                                      imgFullPath : cat["img_full_path"],
                                      precentage : cat["precentage"],
                                      images : cat["images"],
                                      sizes : cat["sizes"],


                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                    }),
              )
              ,


            ],
          ),
        ),
        // Item Discount End

        SizedBox(height: 10.0),

        // Item Popular Start
        Container(
          width: width,
          height: height/2.2,
          color: Theme.of(context).appBarTheme.color,
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("الاكثر مبيعا",
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: width/25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.0),


              (_shimmer)
                  ? Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.white,
                child: Container(
                  height: 245.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        Map cat =  categoryList[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).appBarTheme.color,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0.7,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              child:   SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Hero(
                                      tag: Text(
                                          "${cat["title"]}"),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            height: 170.0,
                                            width: 170.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    cat["image"]
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            margin: EdgeInsets.all(6.0),
                                          ),
                                          Positioned(
                                            top: 0.0,
                                            left: 0.0,
                                            child: Container(
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                color: Colors.pinkAccent,
                                                borderRadius:
                                                BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(10.0),
                                                  bottomRight:
                                                  Radius.circular(
                                                    10.0,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                  cat["title"],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          right: 6.0, left: 6.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            cat["title"],
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Jost',
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.6,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                cat["title"],
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                width: 7.0,
                                              ),
                                              Text(
                                                cat["title"],
                                                style: TextStyle(
                                                    fontSize: 13.0,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey),
                                                overflow:
                                                TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {

                            },
                          ),
                        );
                      }),
                ),
              )
                  : Container(
                height: height/2.7,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: popular.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      Map cat =  popular[index];
                      return
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).appBarTheme.color,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0.7,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Hero(
                                      tag: Text(
                                          "${cat["id"]}"),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            height: height/4,
                                            width: width/1.8,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: NetworkImage(cat["img_full_path"]),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            margin: EdgeInsets.all(6.0),
                                          ),
                                          Positioned(
                                            top: 0.0,
                                            left: 0.0,
                                            child: Container(
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                color: Colors.pinkAccent,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(10.0),
                                                  bottomRight: Radius.circular(
                                                    10.0,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                  "${cat["precentage"]} - %",
                                                  style: TextStyle(
                                                    fontSize: width/28,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          right: 6.0, left: 6.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            cat["name"],
                                            style: TextStyle(
                                              fontSize: width/25,
                                              fontFamily: 'Jost',
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.6,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "${cat["over_price"]} KW ", textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: width/24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                width: 7.0,
                                              ),
                                              Text(
                                                "${cat["price"]} KW ", textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                    fontSize: width/30,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                    data: Product(
                                      id : cat["id"],
                                      name : cat["name"],
                                      description : cat["description"],
                                      price : cat["price"].toDouble(),
                                      overPrice : cat["over_price"].toDouble(),
                                      brandId : cat["brand_id"],
                                      made : cat["made"],
                                      subCategoryId : cat["subCategory_id"],
                                      categoryId : cat["category_id"],
                                      qut : cat["qut"],
                                      pay : cat["pay"],
                                      view : cat["view"],
                                      newItem : cat["new"],
                                      popular : cat["popular"],
                                      over : cat["over"],
                                      subSubCategoryId : cat["subSubCategory_id"],
                                      img : cat["img"],
                                      activity : cat["activity"],
                                      numItem : cat["new"],
                                      imgFullPath : cat["img_full_path"],
                                      precentage : cat["precentage"],
                                      images : cat["images"],
                                      sizes : cat["sizes"],


                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                    }),
              )
              ,


            ],
          ),
        ),
        // Item Popular End

        SizedBox(height: 10.0),
        Container(
          width: width,
          height:height/2.2,
          color: Theme.of(context).appBarTheme.color,
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("عروض الخصم",
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: width/25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.0),


              (_shimmer)
                  ? Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.white,
                child: Container(
                  height: 245.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        Map cat =  categoryList[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).appBarTheme.color,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0.7,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              child:   SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Hero(
                                      tag: Text(
                                          "${cat["title"]}"),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            height: 170.0,
                                            width: 170.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    cat["image"]
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            margin: EdgeInsets.all(6.0),
                                          ),
                                          Positioned(
                                            top: 0.0,
                                            left: 0.0,
                                            child: Container(
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                color: Colors.pinkAccent,
                                                borderRadius:
                                                BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(10.0),
                                                  bottomRight:
                                                  Radius.circular(
                                                    10.0,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                  cat["title"],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          right: 6.0, left: 6.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            cat["title"],
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Jost',
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.6,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                cat["title"],
                                                style: TextStyle(
                                                  fontSize: width/24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                width: 7.0,
                                              ),
                                              Text(
                                                cat["title"],
                                                style: TextStyle(
                                                    fontSize: width/28,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey),
                                                overflow:
                                                TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {

                            },
                          ),
                        );
                      }),
                ),
              )
                  : Container(
                height: height/2.7,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: over.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      Map cat =  over[index];
                      return
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).appBarTheme.color,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0.7,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Hero(
                                      tag: Text(
                                          "${cat["id"]}"),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            height: height/4,
                                            width: width/1.8,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: NetworkImage(cat["img_full_path"]),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            margin: EdgeInsets.all(6.0),
                                          ),
                                          Positioned(
                                            top: 0.0,
                                            left: 0.0,
                                            child: Container(
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                color: Colors.pinkAccent,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(10.0),
                                                  bottomRight: Radius.circular(
                                                    10.0,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                  "${cat["precentage"]} - %",
                                                  style: TextStyle(
                                                    fontSize: width/28,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          right: 6.0, left: 6.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            cat["name"],
                                            style: TextStyle(
                                              fontSize: width/25,
                                              fontFamily: 'Jost',
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.6,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "${cat["over_price"]} KW ", textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                  fontSize: width/24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                width: 7.0,
                                              ),
                                              Text(
                                                "${cat["price"]} KW ", textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                    fontSize: width/30,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                    data: Product(
                                      id : cat["id"],
                                      name : cat["name"],
                                      description : cat["description"],
                                      price : cat["price"].toDouble(),
                                      overPrice : cat["over_price"].toDouble(),
                                      brandId : cat["brand_id"],
                                      made : cat["made"],
                                      subCategoryId : cat["subCategory_id"],
                                      categoryId : cat["category_id"],
                                      qut : cat["qut"],
                                      pay : cat["pay"],
                                      view : cat["view"],
                                      newItem : cat["new"],
                                      popular : cat["popular"],
                                      over : cat["over"],
                                      subSubCategoryId : cat["subSubCategory_id"],
                                      img : cat["img"],
                                      activity : cat["activity"],
                                      numItem : cat["new"],
                                      imgFullPath : cat["img_full_path"],
                                      precentage : cat["precentage"],
                                      images : cat["images"],
                                      sizes : cat["sizes"],


                                    ),
                                  ),
                                ),
                              );

                            },
                          ),
                        );
                    }),
              )
              ,

            ],
          ),
        ),
        // New Item Start

        // Recommended Products Start

        // Recommended Products Ends
      ],
    );
  }
}
