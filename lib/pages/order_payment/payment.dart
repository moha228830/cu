import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' ;
import 'package:my_store/config.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

// My Own Imports

class PaymentPage extends StatefulWidget {
double price ;
String govern ;
String city ;
String address ;
String phone ;
double total ;
double balance ;

String name ;
PaymentPage(this.total,this.price,this.phone,this.govern,this.city,this.address,this.name,this.balance);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selectedRadioPayment;
bool _load = false ;
double net=0.0;
double remind=0.0;
get_net(){
   double net2 = (widget.total + widget.price) - widget.balance ;
   if (net2 == 0 ){
             setState(() {
               net = 0.0;
               remind = 0.0;

             });
   }
   if (net2 > 0 ){

     setState(() {
       net =net2;
       remind = 0.0;

     });
   }
   if (net2 < 0 ){
     setState(() {
       net =0.0;
       remind = (net2).abs();

     });
   }
   print(widget.name);
   print((widget.balance - remind).toString());
}
  set_orders  () async{
    setState(() {
      _load = true ;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    var user = localStorage.getString('user_id');
    if (tok != null){
      try{


        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response =
          await http.post(Config.url+"add_orders", headers: {
            "Accept": "application/json"
          }, body: {
            "phone": widget.phone,
            "username": widget.name,
            "name": widget.govern,
            "city": widget.city,
            "address": widget.address,
            "token": tok,
            "user_id": user,
            "price":widget.price.toString(),
            "total":widget.total.toString(),
            "balance":(widget.balance - remind).toString(),



          });
          print(widget.phone);
          print(widget.name);
          print(widget.govern);
          print(widget.city);
          print(widget.address);
          print(tok);

          print((widget.balance - remind).toString());
          print(widget.total.toString());
          print(widget.price.toString());
          if (response.statusCode == 200) {
           // print((widget.balance - remind).toString());



            var res = json.decode(response.body);
            if (res["state"]=="1"){


              _showDialog();

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
    if (this.mounted) {
      setState(() {
        _load = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    get_net();
    selectedRadioPayment = 0;
    _load = false ;

  }

  setSelectedRadioPayment(int val) {
    if (this.mounted) {
      setState(() {
        selectedRadioPayment = val;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          AppLocalizations.of(context)
              .translate('paymentPage', 'appBarTitleString'),
          style: TextStyle(
            fontFamily: 'Jost',
            fontSize: width/24,
            letterSpacing: 1.7,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 0.0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "عادة ما يكون التوصيل في مدة لا تتجواز 4 ايام",
                  style: TextStyle(
                      fontSize: width/23,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Alatsi',
                      height: 1.6),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),

                Container(
                  height: height/9,

                  width: width,
                  child: Center(child:
                  Container(
                    margin: EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Expanded(child:
                        InkWell(
                          onTap: () {

                          },
                          child: Container(
                            color:
                            Colors.pinkAccent,
                            width: 120.0,
                            height: height/10,
                            alignment: Alignment.center,
                            child: Text(
                             "  الطلب :  ${widget.total.toStringAsFixed(2)}" + " KW",
                              style: TextStyle(
                                fontSize: width/23,
                                fontFamily: 'Jost',
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .appBarTheme
                                    .color,
                              ),
                            ),
                          ),
                        )),
                        Expanded(child: InkWell(
                          onTap: () {

                          },
                          child: Container(
                            color:
                            Colors.black,
                            width: 120.0,
                            height: height/10,
                            alignment: Alignment.center,
                            child: Text(
                              "  توصيل :  ${widget.price}" + " KW",
                              style: TextStyle(
                                fontSize: width/23,
                                fontFamily: 'Jost',
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  )),
                ),
                widget.balance!=0.0?
                Container(
                  color: Theme.of(context).appBarTheme.color,
                  width: width,
                  padding:EdgeInsets.all(15.0),

                  child: Text(
                    "  رصيدك  :  ${(widget.balance)}" + " KW",
                    style: TextStyle(
                      fontSize:width/23,
                      fontFamily: 'Jost',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ):Divider(
                  height: 1.0,
                ),

                Divider(
                  height: 1.0,
                ),
                Container(
                  height: height/10,

                  width: width,
                  child: Center(child:
                  Container(
                    margin: EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Expanded(child:
                        InkWell(
                          onTap: () {

                          },
                          child: Container(
                            color:
                            Colors.pinkAccent,
                            width: 120.0,
                            height: height/10,
                            alignment: Alignment.center,
                            child: Text(
                              "  عليك دفع :  ${(net).toStringAsFixed(2)}" + " KW",
                              style: TextStyle(
                                fontSize:width/23,
                                fontFamily: 'Jost',
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .appBarTheme
                                    .color,
                              ),
                            ),
                          ),
                        )),

                      ],
                    ),
                  )),
                ),
                widget.balance!=0.0?
                Container(
                  color: Theme.of(context).appBarTheme.color,
                  width: width,
                  padding:EdgeInsets.all(15.0),

                  child: Text(
                    "  يتبقي من رصيدك  :  ${(remind).toStringAsFixed(2)}" + " KW",
                    style: TextStyle(
                      fontSize:width/23,
                      fontFamily: 'Jost',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ):Divider(
                  height: 1.0,
                ),
                Divider(
                  height: 1.0,
                ),
                Container(
                  width: width - 40.0,
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: RadioListTile(
                    value: 2,
                    groupValue: selectedRadioPayment,
                    title: Text(
                      AppLocalizations.of(context)
                          .translate('paymentPage', 'cashOnDeliveryString'),
                      style: TextStyle(
                        fontSize:width/23,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),
                    onChanged: (val) {
                      setSelectedRadioPayment(val);
                    },
                    activeColor: Theme.of(context).primaryColor,
                    secondary: Image(
                      image: AssetImage(
                        'assets/payment_icon/cash_on_delivery.png',
                      ),
                      height: 45.0,
                      width: 45.0,
                    ),
                  ),
                ),
                Divider(
                  height: 1.0,
                ),

                SizedBox(
                  height: 40.0,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: InkWell(
                    onTap: () {
                      set_orders  ();

                    },
                    child: Container(
                      width: width - 40.0,
                      padding: EdgeInsets.all(15.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: !_load?Text(
                      "تأكيد ",
                        style: TextStyle(
                          color: Theme.of(context).appBarTheme.color,
                          fontFamily: 'Jost',
                          fontSize: width/24,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.bold,
                        ),
                      ):CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // user defined function for Logout Dialogue
  void _showDialog() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 5.0,
          backgroundColor: Theme.of(context).appBarTheme.color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Container(
            height: 250.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height:100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Theme.of(context).appBarTheme.color,
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 5.0),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 50.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate('paymentPage', 'congratulationsString'),
                  style: TextStyle(
                    fontFamily: 'Jost',
                    letterSpacing: 0.7,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "تم تاكيد الطلب بنجاح",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (this.mounted) {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home(1)),
          );
        });
      }
    });
  }
}
