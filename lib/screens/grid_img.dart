import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridImg extends StatelessWidget {
  List<String> images = [
    "https://images.unsplash.com/photo-1551470092-a406fe92392e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mzg4fHxzaG9lc3xlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1493770348161-369560ae357d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8OHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://hips.hearstapps.com/amv-prod-cad-assets.s3.amazonaws.com/images/16q1/665019/2016-chevrolet-silverado-2500hd-high-country-diesel-test-review-car-and-driver-photo-665520-s-original.jpg",
    "https://www.galeanasvandykedodge.net/assets/stock/ColorMatched_01/White/640/cc_2018DOV170002_01_640/cc_2018DOV170002_01_640_PSC.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;

    return GridView.count(
      controller: new ScrollController(keepScrollOffset: false),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / 230),
      physics: BouncingScrollPhysics(),
      children: images.map((url) {
        return Container(
          child: Card(
            child: Column(
              children: [
                // Image show
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 16.0,
                  ),
                  child: Image.network(
                    url,
                    height: 120.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Lzard Regular Men Blue Jeans',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w800,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(left: 12.0),
                  child: Text(
                    '\$14.99',
                    style: TextStyle(fontSize: 16, fontFamily: 'avenir'),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
