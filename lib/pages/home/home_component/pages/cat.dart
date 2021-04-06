import 'package:flutter/material.dart';
import 'package:my_store/pages/home/home_component/pages/catGridView.dart';

import 'package:my_store/providers/homeProvider.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sizer/sizer.dart';

class Cat extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List cats =Provider.of<HomeProvider>(context, listen: true).sub_cat;

    return SingleChildScrollView(
      child: Column(

        children: <Widget>[
      GridView.builder(
      itemCount: cats.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:(MediaQuery.of(context).size.width / 2) / (MediaQuery.of(context).size.height / 3),


          ),

          itemBuilder: (BuildContext context, int index) {
            return Container(

              child:CatGridView(cats: cats[index]) ,
            );




          })


        ],
      ),
    );
  }
}
