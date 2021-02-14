import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' ;
import 'package:provider/provider.dart';
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:my_store/pages/login_signup/signup.dart';

import 'package:my_store/config.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

// My Own Import
import 'package:my_store/pages/home/home.dart';
import 'package:my_store/pages/order_payment/delivery_address.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List  cartItemList = [] ;
  int cartItem =0;
  var total= 0.00;
  bool _load =true ;
  bool progres = false ;
  Map map = {};
  bool set_num = false;

  Map map_price = {};
  List qut =["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15",
    "16","17","18","19","20","21","22","23","24","25","26","27","28","29","30",
        "31","32","33","34","35","36","37","38","39","40","41","42","43","44","45"
        "46","47","48","49","50"];
  String dropdownValue3 = 'الكمية';
   //////////////////////////////////////////////////////////////////////////////////////////////////////


  get_shard() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var login = localStorage.getString('login');
    //print(login);
    //var user =localStorage.getString('user');
    if (login != "2"){

      showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: MaterialLocalizations.of(context)
              .modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext,
              Animation animation,
              Animation secondaryAnimation) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.height -  80,

                padding: EdgeInsets.all(20),
                color: Theme.of(context).appBarTheme.color,
                child: Scaffold(
                  body:   Container(
                    padding: EdgeInsets.all(20),

                    child: Column(
                      children: [
                        Text("يمكنك الشراء من التطبيق بدون تسجيل وللحصول علي مميزات اضافية قم بالتسجيل اولا "
                        ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline6.color),),
                        SizedBox(height: 15,),
                        Divider(),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: SignupPage()));
                              },
                              child: Text(
                                "تسجيل جديد",
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              color: Colors.pinkAccent,
                            ),
                            SizedBox(width: 20,),

                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "تخطي ",
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              color: Colors.pinkAccent,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            );
          });




    }
  }


  get_carts  () async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    var user = localStorage.getString('user_id');
    if (tok != null){
      try{
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response =
          await http.get(Config.url+"get_carts?token="+tok+"&user_id=0");


          if (response.statusCode == 200) {


            var res = json.decode(response.body);
            if (res["state"]=="1") {
              if (this.mounted) {
              setState(() {
                cartItemList = res["data"];
                cartItem = cartItemList.length;
                for (int i = 0; i < cartItem; i++) {
                  total += cartItemList[i]["item"]["over_price"] *
                      cartItemList[i]["qut"];

                  add_map();
                }

                _load = false;
              });
            }
              print(cartItemList.length);

              //  print(tok);

            }else{
              Fluttertoast.showToast(
                msg: '${res["msg"]}',
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
    }else{
      Fluttertoast.showToast(
        msg: 'خطأ غير متوقع اغلق التطبيق ثم اعد فتحة من البداية',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );

    }


  }



  add_map(){
     if(cartItem > 0){
       for (int i = 0; i < cartItemList.length; i++) {

         map[cartItemList[i]["id"]] = cartItemList[i]["qut"];
         map_price[cartItemList[i]["id"]] = cartItemList[i]["qut"] * cartItemList[i]["item"]["over_price"] ;
         //print(cartItemList[i]["item"]["over_price"] * cartItemList[i]["qut"]);
       }
      // print(map);
     }

  }



  add_to_cart(item_id,color,size,qut,id,newValue,type) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    if (tok != null){


     // var data = "token="+tok+"&item_id="+item_id+
        //  "&size="+size+"&color="+color+"&qut="+newValue+"&type="+type;


      try{
        if (this.mounted) {
          setState(() {
            progres = true;
          });
        }
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response  =
          await http.post(Config.url+"add_carts_cart", headers: {
            "Accept": "application/json"
          }, body: {
            "token":tok,
            "item_id": item_id,
            "size": size,

            "color": color,

            "qut": newValue,
            "type":type,




          });


          if (response.statusCode == 200) {
            var $res =  json.decode(response.body);
            if ($res["state"]=="1"){
              if (this.mounted) {
                setState(() {
                  _load = true;
                  total = 0.00;
                  get_carts();
                });
              }

              Fluttertoast.showToast(
                msg: ' تمت العملية بنجاح ',
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );
            }
            else if ($res["state"]=="4"){
              if (this.mounted) {
                setState(() {
                  map[id] = qut;
                  print(qut);
                });
              }
              Fluttertoast.showToast(
                msg: '${$res["msg"]}',
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );
            }
            else{
              if (this.mounted) {
                setState(() {
                  map[id] = qut;
                });
              }
              Fluttertoast.showToast(
                msg: '${$res["msg"]}',
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





    }else{
      Fluttertoast.showToast(
        msg: 'خطأ غير متوقع اغلق التطبيق ثم اعد فتحة من البداية',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }
    if (this.mounted) {
      setState(() {
        _load = false;
        progres = false;
      });
    }
    //print(map);
  }
  add_to_cart2(item_id,color,size,qut,id,newValue,type) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    if (tok != null){


      var data = "token="+tok+"&item_id="+item_id+
          "&qut="+newValue+"&type="+type;


      try{
        if (this.mounted) {
          setState(() {
            progres = true;
          });
        }
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response  =
          await http.post(Config.url+"add_carts_cart", headers: {
            "Accept": "application/json"
          }, body: {
            "token":tok,
            "item_id": item_id,

            "qut": newValue,
            "type":type,




          });


          if (response.statusCode == 200) {
            var $res =  json.decode(response.body);
            if ($res["state"]=="1"){
              if (this.mounted) {
                setState(() {
                  _load = true;
                  total = 0.00;
                  get_carts();
                });
              }

              Fluttertoast.showToast(
                msg: ' تمت العملية بنجاح ',
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );
            }
            else if ($res["state"]=="4"){
              if (this.mounted) {
                setState(() {
                  map[id] = qut;
                  print(qut);
                });
              }
              Fluttertoast.showToast(
                msg: '${$res["msg"]}',
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );
            }
            else{
              if (this.mounted) {
                setState(() {
                  map[id] = qut;
                });
              }
              Fluttertoast.showToast(
                msg: '${$res["msg"]}',
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





    }else{
      Fluttertoast.showToast(
        msg: 'خطأ غير متوقع اغلق التطبيق ثم اعد فتحة من البداية',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }
    if (this.mounted) {
      setState(() {
        _load = false;
        progres = false;
      });
      print(newValue);
    }
    //print(map);
  }



  ///////////////////////////add to cart

  delete(index) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    if (tok != null){



      var data = "token="+tok+"&id="+index;
      try{
        if (this.mounted) {
          setState(() {
            progres = true;
          });
        }
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response =
          await http.get(Config.url+"delet_from_cart?"+data);


          if (response.statusCode == 200) {
            var $res =  json.decode(response.body);
            if ($res["state"]=="1"){
              if (this.mounted) {
                setState(() {
                  _load = true;
                  total = 0.00;
                  get_carts();
                });
              }

              Fluttertoast.showToast(
                msg: ' تمت العملية بنجاح ',
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );
            }
            else if ($res["state"]=="4"){
              if (this.mounted) {
                setState(() {


                });
              }
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





    }else{
      Fluttertoast.showToast(
        msg: 'خطأ غير متوقع اغلق التطبيق ثم اعد فتحة من البداية',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }
    if (this.mounted) {
      setState(() {
        _load = false;
        progres = false;
      });
    }
    //print(map);
  }



  /////////////////////////////////////////////////////

@override
 void initState() {
    // TODO: implement initState
    super.initState();
    progres = false ;
     cartItem;
     set_num;
    get_shard();
    get_carts();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
    !_load?
      (cartItem == 0)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/empty_bag.png',
                  height: height/10,
                ),
                SizedBox(
                  height: 10.0,
                ),

                SizedBox(
                  height: 5.0,
                ),

                Text(
                  AppLocalizations.of(context)
                      .translate('cartPage', 'nothingCartString'),
                  style: TextStyle(
                    fontSize: width/25,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home(0)),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, bottom: 10.0, right: 15.0, left: 15.0),
                      child:
                      Text(
                        AppLocalizations.of(context)
                            .translate('cartPage', 'addItemToCartString'),
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Jost',
                          fontSize:  width/25,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: ListView(
              children: [
                Container(child:
                progres?
                LinearProgressIndicator(
                  backgroundColor: Colors.pinkAccent,
                  valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
                  minHeight: 20,
                ):null
                  ,),
                Container(
                  height: height/8,

                 width: width,
                 child: Card(child: Center(child:
                 Container(
                   margin: EdgeInsets.all(10),
                   child: Row(
                     children: [
                       Expanded(child:
                       !progres?InkWell(
                         onTap: () {
                           if(total != 0){
                           Navigator.push(
                               context,
                               PageTransition(
                                   type: PageTransitionType
                                       .rightToLeft,
                                   child: Delivery(total)))
    ;}
                         },
                         child: Container(
                           color:
                         Colors.pinkAccent,
                           width: 120.0,
                           height: height/10,
                           alignment: Alignment.center,
                           child: Text(
                             "تأكيد الطلب",
                             style: TextStyle(
                               fontSize: width/24,
                               fontFamily: 'Jost',
                               letterSpacing: 1.5,
                               fontWeight: FontWeight.bold,
                               color: Theme.of(context)
                                   .appBarTheme
                                   .color,
                             ),
                           ),
                         ),
                       ): Center(child: CircularProgressIndicator())
                       ),
                       Expanded(child: InkWell(
                         onTap: () {

                         },
                         child: Container(
                           color:
                           Colors.white,
                           width: width/4,
                           height: height/10,
                           alignment: Alignment.center,
                           child: Text(
                             total.toStringAsFixed(2)+ " KW ",
                             style: TextStyle(
                               fontSize:  width/24,
                               fontFamily: 'Jost',
                               letterSpacing: 1.5,
                               fontWeight: FontWeight.bold,
                               color: Colors.black,
                             ),
                           ),
                         ),
                       )),
                     ],
                   ),
                 ))),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: cartItemList.length,
                  itemBuilder: (context, index) {
                    final item = cartItemList[index];
                    return Container(
                      alignment: Alignment.center,
                      child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        secondaryActions: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              top: 5.0,
                              bottom: 5.0,
                            ),
                            child: IconSlideAction(
                              caption: AppLocalizations.of(context)
                                  .translate('cartPage', 'deleteString'),

                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {

                                delete (item["id"].toString());

                                // Then show a snackbar.
                                //Scaffold.of(context).showSnackBar(SnackBar(
                                  //  content: Text(
                                //  AppLocalizations.of(context)
                                    //  .translate('cartPage', 'itemRemoved'),
                               // ))
                               // );
                              },
                            ),
                          ),
                        ],
                        child: Container(
                          height: height/3.2,
                          width: (width - 10.0),
                          child: Card(
                            elevation: 3.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: width/4,
                                              height: height/7,
                                              child: Image(
                                                image:NetworkImage(item["item"]['img_full_path']),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Container(
                                          padding: EdgeInsets.all(10.0),
                                          // width: (width - 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${item["item"]['name']}',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontSize:  width/25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 7.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'السعر:',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .color,
                                                      fontSize:  width/25,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Text(
                                                    '${item["item"]['over_price']}  KW',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .color,
                                                      fontSize: width/25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 7.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10.0),
                                          // width: (width - 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              item["color"] !=null ?Text(
                                                '${item["color"]}',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontSize:  width/25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ):Text(" "),
                                              SizedBox(
                                                height: 7.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: <Widget>[
                                                    item["size"] !=null ?
                                                  Text(
                                                    'المقاس :',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .color,
                                                      fontSize:  width/25,
                                                    ),
                                                  ):Text(" "),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  item["size"] !=null ?
                                                  Text(
                                                    '${item["size"]}',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .color,
                                                      fontSize:  width/25,
                                                    ),
                                                  ):Text(" "),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 7.0,
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, right: 8.0, left: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[


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
                                              value: map[item["id"]].toString(),
                                              icon: Icon(Icons.arrow_downward,color: Colors.white,),
                                              iconSize: 24,
                                              elevation: 16,
                                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

                                              onChanged: ( newValue) {
                                                print((item["item"]["type"]));
                                                  if(item["item"]["type"]==2){
                                                    add_to_cart2(item["item"]["id"].toString(),item["color"],item["size"],item["qut"].toString(),item["id"].toString(),newValue,item["type"].toString());

                                                  }else{
                                                    add_to_cart(item["item"]["id"].toString(),item["color"],item["size"],item["qut"].toString(),item["id"].toString(),newValue,item["type"].toString());

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
                                          ) ,
                                         Column(
                                           children: [
                                             Container(

                                                  width: width/4,

                                                  alignment: Alignment.center,
                                                  child: Text(
                                                   "الاجمالي",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontFamily: 'Jost',
                                                      fontSize:  width/25,
                                                      letterSpacing: 0.8,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                              ),
                                             Container(

                                               width: width/4,
                                               alignment: Alignment.center,
                                               child: Text(
                                                 " ${map_price[item["id"]].toStringAsFixed(2)} KW",
                                                 style: TextStyle(
                                                   color: Colors.red,
                                                   fontFamily: 'Jost',
                                                   fontSize:  width/25,
                                                   letterSpacing: 0.8,
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                               ),
                                             ),

                                           ],
                                         ),
                                          InkWell(
                                            onTap: () {
                                             //


                                                delete (item["id"].toString());




                                              },
                                            child: Container(

                                              width: width/5,
                                              height: height/15,
                                              alignment: Alignment.center,
                                              child: Icon(Icons.delete)
                                            ),
                                          ),





                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )

                    ;
                  },
                ),
                Container(
                  height: 20,
                  child:
                progres?
                LinearProgressIndicator(
                  backgroundColor: Colors.pinkAccent,
                  valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
                  minHeight: 20,
                ):null
                  ,),

              ],
            ),
          ) :
    Center(
      child: Container(
          child: CircularProgressIndicator(),
          width: 32,
          height: 32
      ),
    )
    ;
  }
}
