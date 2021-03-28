import 'package:flutter/material.dart';
import 'package:my_store/pages/product/product.dart';
import 'package:my_store/pages/product/product2.dart';
import 'package:my_store/pages/product_list_view/get_function.dart';
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:my_store/providers/homeProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../helper.dart';

class New1 extends StatelessWidget {
 List data;
 New1(this.data);
 set_fav(context)async{
   SharedPreferences localStorage =
       await SharedPreferences.getInstance();
   localStorage.setStringList('favorite',Provider.of<HomeProvider>(context, listen: false).favorite);
 }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var new_item = data;
    return  Container(
      height: 45.1.h,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),

      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: new_item.length,
          itemBuilder: (BuildContext ctxt, int index) {
            Map cat =  new_item[index];
            return
              Padding(
                padding: const EdgeInsets.all(0),
                child: InkWell(
                  child:
                  Container(
                    margin:EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 0.5.h),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black,
                      ),


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
                                    height: 26.0.h,
                                    width: 45.0.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft:
                                        Radius.circular(10.0),
                                        topRight:
                                             Radius.circular(
                                          10.0,
                                        ),
                                      ),
                                      image: DecorationImage(

                                        image: NetworkImage(cat["img_full_path"]),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    margin: EdgeInsets.all(0.0),
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              height: 12.0.h,
                              width: 45.0.w,
                              alignment: Alignment.center,

                              child: Column(
                                children: <Widget>[
                                  Text(
                                    get_by_size(cat["name"],20,18,"..") ,
                                    style: TextStyle(
                                      fontSize: 10.0.sp,
                                      fontFamily: 'Cairo',
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
                                  Text(
                                    get_by_size(cat["description"],22,20,"..") ,
                                    style: TextStyle(
                                      fontSize: 9.0.sp,
                                      fontFamily: 'Cairo',
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
                                  SizedBox(height: 1.0.h,),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                      //  width:20.0.w ,
                                        child: Text(
                                          "${cat["price"]} KWD ", textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              fontSize: 10.0.sp,
                                              decoration: TextDecoration
                                                  .lineThrough,
                                              color: Colors.grey),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                      SizedBox(
                                        width: 7.0.w,
                                      ),
                                      Container(
                                        child: Text(
                                          "${cat["over_price"]} KWD ", textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            fontSize: 10.0.sp,
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
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight:
                                  Radius.circular(10.0),
                                 bottomLeft:
                                  Radius.circular(
                                    10.0,
                                  ),
                                ),

                              ),
                            height: 5.7 .h,width: 45.0.w,
                              child: Center(
                                child: Row(
                                  children: [
                                    Expanded(

                                      child: Text(" ",style: TextStyle(
                                          fontSize: 12.0.sp,
                                          fontFamily: "Cairo",

                                          color: Colors.white),),
                                    ),
                                    Expanded(
                                      flex:4 ,
                                      child: Text("إشتري الان",style: TextStyle(
                                          fontSize: 10.0.sp,
                                          fontFamily: "Cairo",

                                          color: Colors.white
                                      ),),
                                    ),
                                    Expanded(
                                      flex:2 ,
                                      child:
                                     Container(  decoration: BoxDecoration(
                                       color: Colors.pinkAccent,
                                       borderRadius: BorderRadius.only(
                                         bottomRight:
                                         Radius.circular(0.0),
                                         bottomLeft:
                                         Radius.circular(
                                           10.0,
                                         ),
                                       ),

                                     ), child: InkWell(
                                       onTap: () {
                                         Provider.of<HomeProvider>(context, listen: false).toggel_faforite(cat["id"]);
                                         set_fav(context);
                                       },
                                       child: Center(
                                         child:

                                         Provider.of<HomeProvider>(context, listen: true).favorite_int.contains(cat["id"])?
                                         Icon(Icons.favorite,color: Colors.white,size: 25.0.sp,):

                                         Icon(Icons.favorite_border_outlined,color: Colors.white,size: 25.0.sp,),

                                       ),
                                     ), ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                  ),
                  onTap: () {
                    if(cat["type"]==1) {
                      Navigator.push(
                          context,
                          PageTransition(
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 700),

                              type: PageTransitionType.rightToLeft,
                              child: ProductPage(
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
                                  type : cat["type"],


                                ),
                          )));

                    }else{
                      Navigator.push(
                          context,
                          PageTransition(
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 700),

                              type: PageTransitionType.rightToLeft,
                              child:ProductPage2(
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
                                  type : cat["type"],


                                ),)));


                    }
                  },
                ),
              );
          }),
    );



  }

}