import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/home/home.dart';
import 'package:page_transition/page_transition.dart';

import 'package:sizer/sizer.dart';

import 'package:my_store/pages/product_list_view/product_class.dart';

import 'package:carousel_pro/carousel_pro.dart';


// My Own Imports

class MySlider extends StatelessWidget {
  final List data;

  MySlider( this.data) ;


  final _scaffoldKey = GlobalKey<ScaffoldState>();




  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color color = Theme.of(context).textTheme.headline6.color;
    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      key: _scaffoldKey,
backgroundColor: Colors.white ,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 2.0.h,),

          // Slider and Add to Wishlist Code Starts Here
          Stack(


            children: <Widget>[
              Center(
                child: Container(
                  width: 90.0.w,
                  padding: EdgeInsets.only(top: 2.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.color,
                    borderRadius: BorderRadius.circular(0.0),
                    border: Border.all(color:Colors.grey),


                  ),                  child: SizedBox(
                    height: (74.0.h),
                    width: width,
                  child: Carousel(

                      images:   data.map((title) => NetworkImage(title["img_full_path"])).toList(),



                      dotSize: 5.0,

                      dotSpacing: 15.0,
                      dotColor: Colors.grey,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.purple.withOpacity(0.0),
                      boxFit: BoxFit.fill ,
                      animationCurve: Curves.decelerate,
                      dotIncreasedColor: Colors.red,

                    ),

                  ),
                ),
              ),


            ],
          ),
          SizedBox(height: 2.0.h,),
          Container(
            color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 0.7.h, horizontal: 0.0.h),
            child: Center(child:
            Text("عروض مزهلة لدي كوشا استور",style: TextStyle(color: Colors.white,fontFamily: "Cairo",fontSize: 14.0.sp),)),
          ),
          SizedBox(height: 3.0.h,),
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  PageTransition(
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 400),
                      type: PageTransitionType.bottomToTop,
                      child: Home(0)));

            },
            child: Center(
              child: Container(
                width: 50.0.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color:Colors.grey),


                ),
                padding: EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 0.0.h),
                child: Center(child:
                Text("تخطي",style: TextStyle(color: Colors.white,fontFamily: "Cairo",fontSize: 14.0.sp),)),
              ),
            ),
          ),
          // Slider and Add to Wishlist Code Ends Here





          // Product Size & Color End Here

          // Product Details Start Her
          //product detils  ////////////////////////////////////

          //endproduct detils  ////////////////////////////////////

          // Product Details Ends Here

          // Product Description Start Here




          // Product Description Ends Here
          ////////////////////////////////////////////////////////////////////////////////////

          // Similar Product Starts Here

          // Similar Product Ends Here
        ],
      ),

    );
  }


}
