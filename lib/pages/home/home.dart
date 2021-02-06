import 'dart:io';
import 'package:badges/badges.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/contact.dart';
import 'package:my_store/pages/orders/orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';

// My Own Imports
import 'package:my_store/pages/home/home_main.dart';
import 'package:my_store/pages/login_signup/login.dart';

import 'package:my_store/pages/my_account/my_account.dart';
import 'package:my_store/pages/my_cart.dart';
import 'package:my_store/pages/notification.dart';
import 'package:my_store/pages/search.dart';
import 'package:my_store/pages/wishlist.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex;

  var token = utils.CreateCryptoRandomString();

  DateTime currentBackPressTime;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    set_token_not_register();
  }

  set_token_not_register() async{
    SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    var login = localStorage.getString('login');

    //if(login=="2"){
     //var data_user = localStorage.getString('user_id');
     //print(data_user);
    //}

if ( tok == null  ){
  localStorage.setString('token', token);
  localStorage.setString('user_id', "0");
  localStorage.setString('login', "0");

  // print( tok + "moha");

}
  print(tok);
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.pinkAccent,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '   KUSHA-STORE  ',
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.bold,
                  fontSize: width/22,
                  letterSpacing: 1.7,
                  color:Colors.white
                ),
              ),
            ),
          ),
          titleSpacing: 0.0,
          actions: <Widget>[
           // IconButton(
              //  icon: Icon(
                //  Icons.search,
              //  ),
            //    onPressed: () {

             //   }),
           // IconButton(
            //  icon: Badge(
              //  badgeContent: Text(
               //   '2',
                //  style: TextStyle(color: Colors.white),
              //  ),
              //  badgeColor: Theme.of(context).primaryColorLight,
               // child: Icon(
                 // Icons.notifications_none,
               // ),
             // ),
            //  onPressed: () {

           //   },
          //  ),
          ],
        ),
        bottomNavigationBar: BubbleBottomBar(
          backgroundColor:Colors.pinkAccent,
          hasNotch: false,
          opacity: .2,
          currentIndex: currentIndex,
          onTap: changePage,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                  16)), //border radius doesn't work when the notch is enabled.
          elevation: 8,
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  Icons.home,
                  color: Theme.of(context).textTheme.headline6.color,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text(AppLocalizations.of(context).translate('homePage','home'),
                  style: TextStyle(fontSize: width/26),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  Icons.apps,
                  color: Theme.of(context).textTheme.headline6.color,
                ),
                activeIcon: Icon(
                  Icons.apps,
                  color: Colors.white,
                ),
                title: Text("طلباتي",
                  style: TextStyle(fontSize: width/26),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.white,
                icon: Badge(
                  badgeContent: Text(
                    '!',
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:17)
                  ),
                  badgeColor:Colors.white,
                  child: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                ),
                activeIcon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                title: Text(AppLocalizations.of(context).translate('homePage','cart'),
                  style: TextStyle(fontSize: width/26),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  FontAwesomeIcons.user,
                  color: Theme.of(context).textTheme.headline6.color,
                ),
                activeIcon: Icon(
                  FontAwesomeIcons.user,
                  color: Colors.white,
                  size: 17.0,
                ),
                title: Text(AppLocalizations.of(context).translate('homePage','account'),
                  style: TextStyle(fontSize: width/26),
                ))
          ],
        ),
        body: WillPopScope(
          child: (currentIndex == 0)
              ? HomeMain()
              : (currentIndex == 1)
                  ? Order()
                  : (currentIndex == 2)
                      ? MyCart()
                      : MyAccount(),
          onWillPop: onWillPop,
        ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).translate('homePage','exitToastString'),
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
      return Future.value(false);
    }
    exit(0);
    return Future.value(true);
  }
}
class utils {
  static final Random _random = Random.secure();

  static String CreateCryptoRandomString([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }
}