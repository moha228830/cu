import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/pages/order_payment/delivery_address.dart';
import 'package:my_store/pages/product/product_details.dart';
import 'package:provider/provider.dart';
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:my_store/pages/search.dart';
import 'package:page_transition/page_transition.dart';
import 'package:my_store/functions/passDataToProducts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_store/config.dart';
import 'dart:io' ;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


// My Own Imports

class ProductPage2 extends StatefulWidget {
  final Product data;

  ProductPage2({Key key, this.data}) : super(key: key);


  @override
  _ProductPage2State createState() => _ProductPage2State();
}

class _ProductPage2State extends State<ProductPage2> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool favourite = false;
  int cartItem = 3;
  bool   is_laad = false;


  List qut =["الكمية","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"];

  String dropdownValue3 = 'الكمية';
  Map map = {};




  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////
  add_to_cart() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
     var user_id = localStorage.getString('user_id')??0;
    if (tok != null){

      if( dropdownValue3 == "الكمية"){
        Fluttertoast.showToast(
          msg: 'قم بتحديد الكمية',
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );

      }else{


        var data = "token="+tok+"&item_id="+widget.data.id.toString()+
            "&qut="+dropdownValue3+"&type="+widget.data.type.toString();
print(data);
        try{
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            http.Response response =
            await http.get(Config.url+"add_carts?"+data);


            if (response.statusCode == 200) {
              var $res =  json.decode(response.body);
              if ($res["state"]=="1"){
                Fluttertoast.showToast(
                  msg: '  تمت الاضافة بنجاح الي عربة التسوق ',
                  backgroundColor: Theme.of(context).textTheme.headline6.color,
                  textColor: Theme.of(context).appBarTheme.color,
                );
              }
              else if ($res["state"]=="4"){
                Fluttertoast.showToast(
                  msg: $res["msg"],
                  backgroundColor: Theme.of(context).textTheme.headline6.color,
                  textColor: Theme.of(context).appBarTheme.color,
                );
              }
              else{
                Fluttertoast.showToast(
                  msg: 'خطأ حاول مرة اخري',
                  backgroundColor: Theme.of(context).textTheme.headline6.color,
                  textColor: Theme.of(context).appBarTheme.color,
                );
              }
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


      }


    }else{
      Fluttertoast.showToast(
        msg: 'خطأ غير متوقع اغلق التطبيق ثم اعد فتحة من البداية',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }
    if (this.mounted) {
      setState(() {
        is_laad = false;
      });
    }
    //print(map);
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color color = Theme.of(context).textTheme.headline6.color;
    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          widget.data.name,
          style: TextStyle(
              fontFamily: 'Jost',
              letterSpacing: 1.0,
              fontSize: width/25,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        titleSpacing: 0.0,
        // actions: <Widget>[
        //   IconButton(
        //  icon: Icon(
        //  Icons.search,
        // ),
        // onPressed: () {
        //  Navigator.push(
        //  context, MaterialPageRoute(builder: (context) => Search()));
        // },
        // ),
        //],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          // Slider and Add to Wishlist Code Starts Here
          Stack(


            children: <Widget>[
              Container(
                width: width,
                padding: EdgeInsets.only(top: 2.0),
                color: Theme.of(context).appBarTheme.color,
                child: SizedBox(
                  height: (height / 2.0),
                  width: width,



                  child: Carousel(

                    images:   widget.data.images.map((title) => NetworkImage(title["img_full_path"])).toList(),



                    dotSize: 5.0,

                    dotSpacing: 15.0,
                    dotColor: Colors.grey,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.purple.withOpacity(0.0),
                    boxFit: BoxFit.fitHeight,
                    animationCurve: Curves.decelerate,
                    dotIncreasedColor: Colors.red,

                  ),

                ),
              ),
              //  Positioned(
              //   top: 20.0,
              //   right: 20.0,
              // child: FloatingActionButton(
              //  backgroundColor: Theme.of(context).appBarTheme.color,
              //  elevation: 3.0,
              // onPressed: () {
              //  if (this.mounted) {
              //setState(() {
              //if (!favourite) {
              //favourite = true;
              // color = Colors.red;

              // Scaffold.of(context).showSnackBar(
              //SnackBar(
              // content: Text(
              // AppLocalizations.of(context).translate(
              //'productPage', 'addedtoWishlistString'),
              // ),
              // ),
              //);
              // } else {
              //favourite = false;
              //color = Colors.grey;
              //Scaffold.of(context).showSnackBar(
              //SnackBar(
              // content: Text(
              //AppLocalizations.of(context).translate(
              //'productPage', 'removeFromWishlistString'),
              //),
              //),
              //);
              //}
              // });
              // }
              //  },
              // child: Icon(
              // (!favourite)
              //   ? FontAwesomeIcons.heart
              //    : FontAwesomeIcons.solidHeart,
              //  color: color,
              // ),
              //   ),
              // ),
            ],
          ),
          // Slider and Add to Wishlist Code Ends Here
          SizedBox(
            height: 8.0,
          ),
          Divider(
            height: 1.0,
          ),

          Container(
            color: Theme.of(context).appBarTheme.color,
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Product Title Start Here

                // Product Title End Here

                // Special Price badge Start Here

                // Special Price badge Ends Here.

                // Price & Offer Row Starts Here
                Row(
                  children: [
                    Expanded(child:  Text(
                      '${widget.data.name}',
                      style: TextStyle(
                        fontSize: width/24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jost',
                        letterSpacing: 0.7,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                      textAlign: TextAlign.start,
                    ),),
                    Expanded(child:  Container(
                      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${widget.data.overPrice} KW', textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontSize: width/24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.headline6.color,
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            '${widget.data.price} KW', textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: width/25,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),

                        ],
                      ),
                    ),)
                  ],
                ),
                // Price & Offer Row Ends Here

                // Rating Row Starts Here
                // RatingRow(),
                // Rating Row Ends Here
              ],
            ),
          ),

          // Product Size & Color Start Here
          //  P
          //  roductSize(),

          Container(
            padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
            color: Colors.white,
            child: Row(
              children: [




                Expanded(child:
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pinkAccent,

                    boxShadow: [
                      BoxShadow(color: Colors.pinkAccent, spreadRadius: 3),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                  margin: EdgeInsets.all(5),
                  child: DropdownButton<String>(
                    value: dropdownValue3,
                    icon: Icon(Icons.arrow_downward,color: Colors.white,),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

                    onChanged: (String newValue) {
                      if (this.mounted) {
                        setState(() {
                          dropdownValue3 = newValue;
                        });
                      }
                    },
                    items: qut

                        .map<DropdownMenuItem<String>>(( value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(padding: EdgeInsets.all(10),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ) ,),

              ],
            ),
          ),

          // Product Size & Color End Here

          // Product Details Start Her
          //product detils  ////////////////////////////////////

          //endproduct detils  ////////////////////////////////////

          // Product Details Ends Here

          // Product Description Start Here
          Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(top: 5.0),
            color: Theme.of(context).appBarTheme.color,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[



                SizedBox(height: 5.0),

                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)
                              .translate('productPage', 'productDescriptionString'),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: width/25,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    _productDescriptionModalBottomSheet(context,widget.data.description);
                  },
                ),
                Divider(
                  height: 1.0,
                ),
              ],
            ),
          ),



          // Product Description Ends Here
          ////////////////////////////////////////////////////////////////////////////////////

          // Similar Product Starts Here

          // Similar Product Ends Here
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: Container(
          color: Colors.white,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                minWidth: ((width) / 2),
                height: height/10,
                child: RaisedButton(
                  child:is_laad? Container(
                      child: CircularProgressIndicator(),
                      width: 32,
                      height: 32
                  ):

                  Text(
                    AppLocalizations.of(context)
                        .translate('productPage', 'addToCartString'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: (myLocale.languageCode == 'id' || myLocale.languageCode == 'ru') ? width/25 : width/25,
                      fontFamily: 'Jost',
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (this.mounted) {
                      setState(() {
                        is_laad = true;
                      });
                    }
                    // _displaySnackBarAddToCart(context);
                    add_to_cart();
                  },
                  color: Colors.pinkAccent,
                ),
              ),
              ButtonTheme(
                // minWidth: ((width - 60.0) / 2),
                minWidth: ((width) / 2),
                height: height/10,
                child: RaisedButton(
                  child: Text(
                    //  AppLocalizations.of(context).translate('productPage', 'buyNowString'),
                    " الصفحة الرئيسية",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: (myLocale.languageCode == 'id' || myLocale.languageCode == 'ru') ? width/25 : width/25,
                      fontFamily: 'Jost',
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Home()));
                  },
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _displaySnackBarAddToCart(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _scaffoldKey.currentState.showSnackBar(SnackBar(

        content: Text(
          AppLocalizations.of(context).translate('productPage', 'addedToCartString'),
          style: TextStyle(fontSize: width/25),
        )));
  }
  void _productDescriptionModalBottomSheet(context,data) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).appBarTheme.color,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate(
                              'productPage', 'productDescriptionString'),
                          style: TextStyle(
                            fontSize: width/25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Divider(
                          height: 1.0,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(data,
                          style: TextStyle(
                            fontSize: width/25,
                            fontWeight: FontWeight.bold,
                            height: 1.45,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 5,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
