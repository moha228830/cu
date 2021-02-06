import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/order_payment/payment.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' ;
import 'package:my_store/config.dart';


import 'package:shared_preferences/shared_preferences.dart';
// My Own Imports

class Delivery extends StatefulWidget {

  double total ;
  Delivery(this.total);
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  var _currentSelectedValue;
  final _addresscontroller = TextEditingController();
  final _citycontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  List governs = [];
  int len ;
  bool _load = true ;
  double price = 0.0 ;
  Map map = {};
  List <String> names = [];
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  get_carts  () async{
    try{
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        http.Response response =
        await http.get(Config.url+"get_governs");


        if (response.statusCode == 200) {


          var res = json.decode(response.body);
          if (res["state"]=="1"){
            if (this.mounted) {
              setState(() {
                governs = res["data"];
                print(governs);
                len = governs.length;
                for (int i = 0; i < len; i++) {
                  names.add(governs[i]["name"]);
                  map[governs[i]["name"]] = governs[i]["price"];
                }
              });
            }
            //print(cartItemList.length);

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

    if (this.mounted) {
      setState(() {
        _load = false;
      });
    }
  }

  go_pay(){
    if(_currentSelectedValue=="" || _citycontroller.text ==""  ||_phonecontroller.text =="" || _addresscontroller.text==""  )
    {

      Fluttertoast.showToast(
        msg: 'اكمل البيانات ',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
      return false ;
    }else{
      return true ;



    }

  }
  @override
  void initState() {
    _load = true ;
    get_carts  ();

    super.initState();
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
              .translate('deliveryPage', 'appBarTitleString'),
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
          !_load?
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)
                      .translate('deliveryPage', 'whereShippedString'),
                  style: TextStyle(
                      fontSize: width/20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Alatsi',
                      height: 1.6),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: width - 40.0,
                  child: TextField(
                    controller: _phonecontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "رقم الهاتف",

                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 26.0,
                ),
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return
                      InputDecorator(
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Colors.redAccent, fontSize: width/25),
                          hintText: 'المحافظة',

                          hintStyle: TextStyle(fontSize: width/23, color: Theme.of(context).primaryColor,),
                        ),
                        isEmpty: _currentSelectedValue == null,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _currentSelectedValue,
                            isDense: true,
                            onChanged: ( newValue) {
                              if (this.mounted) {
                                setState(() {
                                  _currentSelectedValue = newValue ;
                                  price = map[newValue].toDouble();
                                  print(price);
                                  state.didChange(newValue);
                                });
                              }
                            },
                            items: names.map(( value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                  },
                ),

                SizedBox(
                  height: 18.0,
                ),


                Container(
                  width: width - 40.0,
                  child: TextField(
                    controller: _citycontroller,

                    decoration: InputDecoration(
                      labelText: "المدينة / المنطقة",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Container(
                  width: width - 40.0,
                  child: TextField(
                    controller: _addresscontroller,

                    decoration: InputDecoration(
                      labelText:"العنوان التفصيلي",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: InkWell(
                    onTap: () {

                      if(go_pay()){
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,child:
                            PaymentPage(widget.total,price,_phonecontroller.text,_currentSelectedValue,_citycontroller.text,_addresscontroller.text)));
                      }
                    },
                    child: Container(
                      width: width - 40.0,
                      padding: EdgeInsets.all(15.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        "حفظ وانتقال",
                        style: TextStyle(
                            color: Theme.of(context).appBarTheme.color,
                            fontFamily: 'Jost',
                            letterSpacing: 0.7,
                            fontSize: width/25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ):
          Center(child:  LinearProgressIndicator(
            backgroundColor: Colors.pinkAccent,
            valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
            minHeight: 20,
          )),
        ],
      ),
    );
  }
}
