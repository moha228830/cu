import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future, Timer;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_store/pages/product/product.dart';
import 'package:my_store/pages/product/product2.dart';

import 'package:my_store/pages/product_list_view/filter_row.dart';
import 'package:my_store/functions/passDataToProducts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:my_store/pages/product_list_view/get_function.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ProductsGridView extends StatefulWidget {
  final List<Product> products;

  ProductsGridView({Key key, this.products}) : super(key: key);

  @override
  _ProductsGridViewState createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  InkWell getStructuredGridCell(Product products) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
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
                tag: Text("${products.id}"),
                child: Container(
                  height: ((height - 160) / 2.95),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(products.imgFullPath),
                      fit: BoxFit.fill,
                    ),
                  ),
                  margin: EdgeInsets.all(6.0),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 6.0, left: 6.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        products.name,
                        style: TextStyle(
                          fontSize: width / 25,
                          fontFamily: 'Jost',
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${products.overPrice} KW ",
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontSize: width / 25,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            "${products.price.toString()} KW ",
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: width / 25,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if(products.type==1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(
                data: Product(
                  id: products.id,
                  name: products.name,
                  description: products.description,
                  price: products.price,
                  overPrice: products.overPrice,
                  brandId: products.brandId,
                  made: products.made,
                  subCategoryId: products.subCategoryId,
                  categoryId: products.categoryId,
                  qut: products.qut,
                  pay: products.pay,
                  view: products.view,
                  newItem: products.newItem,
                  popular: products.popular,
                  over: products.over,
                  subSubCategoryId: products.subSubCategoryId,
                  img: products.img,
                  activity: products.activity,
                  numItem: products.numItem,
                  imgFullPath: products.imgFullPath,
                  precentage: products.precentage,
                  images: products.images,
                  sizes: products.sizes,
                  type: products.type,
                ),
              ),
            ),
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage2(
                data: Product(
                  id: products.id,
                  name: products.name,
                  description: products.description,
                  price: products.price,
                  overPrice: products.overPrice,
                  brandId: products.brandId,
                  made: products.made,
                  subCategoryId: products.subCategoryId,
                  categoryId: products.categoryId,
                  qut: products.qut,
                  pay: products.pay,
                  view: products.view,
                  newItem: products.newItem,
                  popular: products.popular,
                  over: products.over,
                  subSubCategoryId: products.subSubCategoryId,
                  img: products.img,
                  activity: products.activity,
                  numItem: products.numItem,
                  imgFullPath: products.imgFullPath,
                  precentage: products.precentage,
                  images: products.images,
                  sizes: products.sizes,
                  type: products.type,
                ),
              ),
            ),
          );
        }

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GridView.count(
      shrinkWrap: true,
      primary: false,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      crossAxisCount: 2,
      childAspectRatio: ((width) / (height - 150.0)),
      children: List.generate(widget.products.length, (index) {
        return getStructuredGridCell(widget.products[index]);
      }),
    );
  }
}
