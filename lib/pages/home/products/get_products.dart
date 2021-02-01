import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future, Timer;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_store/pages/home/products/get_function.dart';
import 'package:my_store/pages/product/product.dart';
import 'package:my_store/pages/product_list_view/filter_row.dart';
import 'package:my_store/functions/passDataToProducts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:my_store/pages/product_list_view/product_class.dart';
import 'package:my_store/pages/product_list_view/get_function.dart';

import 'package:my_store/pages/product_list_view/one_product.dart';

import 'dart:async';
import 'package:http/http.dart' as http;

class GetProducts extends StatefulWidget {
  int id;
  String type;
  GetProducts(this.id, this.type);
  @override
  _GetProductsState createState() => _GetProductsState();
}

class _GetProductsState extends State<GetProducts> {
  bool loading = true, all = true, men = false, women = false;
  @override
  void initState() {
    final postMdl = Provider.of<PostDataProvider>(context, listen: false);
    Timer(const Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postMdl = Provider.of<PostDataProvider>(context);
    return FutureBuilder<List<Product>>(
      future: postMdl.getPostData(http.Client(), widget.id, widget.type),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? ListView(
                children: <Widget>[
                  //  FilterRow(),
                  //  Divider(
                  //  height: 1.0,
                  //  ),
                  (loading)
                      ? Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.white,
                            child: ProductsGridView(products: snapshot.data),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: ProductsGridView(products: snapshot.data),
                        ),
                ],
              )
            : Center(
                child: SpinKitRipple(color: Colors.red),
              );
      },
    );
  }
}
