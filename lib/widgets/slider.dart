import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class ImageSlider extends StatefulWidget {
  @override
  ImageSliderState createState() => ImageSliderState();
}

class ImageSliderState extends State<ImageSlider> {
  int _current = 0;

  List<String> imgList = [
    "assets/images/banner-4.jpg",
    "assets/images/b3.jpeg",
    "assets/images/banner-5.jpg",
    "assets/images/banner-6.jpg",
    "assets/images/b6.jpg",
    "assets/images/b4.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CarouselSlider(
            autoPlay: true,
            pauseAutoPlayOnTouch: Duration(seconds: 30),
            height: 190.0,
            initialPage: 0,
            // enlargeCenterPage: true,
            viewportFraction: 1.0,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
            items: imgList.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    // margin: EdgeInsets.only(left: 7.0, right: 7.0, top: 16.0),
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      // borderRadius: new BorderRadius.circular(8.0),
                      child: Image(
                        image: AssetImage(imgUrl),
                        height: 160.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
