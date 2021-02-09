import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/product_list_view/product_list_view.dart';

class DealOfTheDay extends StatefulWidget {
var brands ;
DealOfTheDay(this.brands);
  @override
  _DealOfTheDayState createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      color: Theme.of(context).appBarTheme.color,
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("افضل الماركات ",
            style: TextStyle(
              fontFamily: 'Jost',
              fontWeight: FontWeight.bold,
              fontSize: width/25,
              letterSpacing: 1.5,
              color: Theme.of(context).textTheme.headline6.color,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: height/9,
            child:
           widget.brands.length ==0?ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                InkWell(
                  onTap: () {
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListView()));
                  },
                  child:Container(color: Colors.grey,width: width/2.6,height: height/8,),
                ),
                SizedBox(width: 10.0),
                InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListView()));
                  },
                  child:Container(color: Colors.grey,width: width/2.6,height: height/8,),
                ),
                SizedBox(width: 10.0),
                InkWell(
                  onTap: () {
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListView()));
                  },
                  child:Container(color: Colors.grey,width: width/2.6,height: height/8,),
                ),
              ],
            ): ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: widget.brands.length,
              itemBuilder: (context, index) {
                final item = widget.brands[index];
                return
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListView(item["id"],"brands",)));
                        },
                        child: Container(
                          child: Image.network(item["img_full_path"],width: width/2.8,height:height/2,fit: BoxFit.fill,
                             ),
                        ),
                      ),
                      Container(width: width/22,)
                    ],
                  )


                ;
              },
            ),

          ),
          SizedBox(height: 5.0),
        ],
      ),
    );
  }
}
