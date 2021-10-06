import 'package:flutter/material.dart';

class ScrollProd extends StatefulWidget {
  @override
  _ScrollProdState createState() => _ScrollProdState();
}

class _ScrollProdState extends State<ScrollProd> {
  int _selectedPage = 0;

  var images = [
    {
      'name': 'New Stylish Shoes Running Shoes For Men  (Red)',
      'image':
          'https://rukminim1.flixcart.com/image/800/960/k5y7tzk0/shoe/9/b/f/2cm-777-109-10-aultrus-multicolor-original-imafz7reyyvj3rm5.jpeg?q=50',
    },
    {
      'name': 'Hiking & Trekking Shoes For Men  (Multicolor)',
      'image':
          'https://rukminim1.flixcart.com/image/800/960/jw0zr0w0/shoe/m/v/x/combo-2-1214-606-6-axter-multicolor-original-imaey4zgqeek9syc.jpeg?q=50',
    },
    {
      'name': 'Kosko Running Shoes For Men  (Navy)',
      'image':
          'https://rukminim1.flixcart.com/image/800/960/kbpeoi80/shoe/y/m/z/kko-beerock-navy-original-imafszqgyynmpgzg.jpeg?q=50',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.0,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              Column(
                children: [
                  for (var i = 0; i < images.length; i++)
                    Image.network(
                      "${images[i]}",
                      // fit: BoxFit.cover,
                      height: 320.0,
                    ),
                  Container(
                    child: Text(''),
                  )
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < images.length; i++)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: _selectedPage == i ? 35.0 : 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.0)),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
