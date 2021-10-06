import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uwokart/screens/HomePage.dart';
import 'package:uwokart/services/appbar_title.dart';
import 'package:uwokart/services/cart_nav.dart';
import 'package:uwokart/services/profile_icon.dart';
import 'package:uwokart/tabs/SearchPage.dart';
import 'package:uwokart/widgets/custom_btn.dart';
import 'package:uwokart/widgets/custom_input.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final databaseReference = FirebaseFirestore.instance;
  late File _image;
  bool _isLoading = false;
  final selected = ImagePicker();

  Future getImage() async {
    final selectedImage = await selected.getImage(source: ImageSource.gallery);

    setState(() {
      if (selectedImage != null) {
        _image = File(selectedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  uploadBlog() async {
    if (_image != null) {
      // Uploading Images to Firestore
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('BlogImages')
          .child("${randomAlphaNumeric(9)}.jpg");

      final firebase_storage.UploadTask uploadTask = ref.putFile(_image);

      final link = await (await uploadTask).ref.getDownloadURL();
      print('This is url: ${link}');

      Map<String, String> blogMap = {
        "image": link,
        "name": _addName,
        "description": _addinfo,
        "rating": _addRating,
        "price": _addPrice,
      };
      databaseReference.collection("Blogs").add(blogMap).then((results) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      });
    } else {}
  }

  // Form Input Field Values
  String _addName = "";
  String _addinfo = "";
  String _addRating = "";
  String _addPrice = "";

  // Focus Node for input fields
  late FocusNode _nextFocusNode;

  @override
  void initState() {
    _nextFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppbarTitle(),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                );
              },
              child: Image(
                image: AssetImage('assets/images/search_icon.png'),
                width: 18.0,
                height: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0, left: 10.0),
            child: CartNav(),
          ),
          ProfileIcon(),
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Container(
                  // height: MediaQuery.of(context).size.height,
                  color: Color(0xffE81667),
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                          child: Text(
                            'Welcome Buddies',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: Text(
                            'book your seat, its your seat "Book Now" ',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Color(0xffffffff),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 30.0,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 26.0,
                          horizontal: 18.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Enter name & Description',
                                  style: TextStyle(
                                      color: Color(0xffE81667), fontSize: 16.0),
                                ),
                              ),
                            ),
                            CustomInput(
                              hintText: "Enter name...",
                              onChanged: (value) {
                                _addName = value;
                              },
                              onSubmitted: (value) {
                                _nextFocusNode.requestFocus();
                              },
                              textInputAction: TextInputAction.next,
                            ),
                            CustomInput(
                              hintText: "Description...",
                              onChanged: (value) {
                                _addinfo = value;
                              },
                            ),
                            CustomInput(
                              hintText: "Rating...",
                              onChanged: (value) {
                                _addRating = value;
                              },
                            ),
                            CustomInput(
                              hintText: "Price...",
                              onChanged: (value) {
                                _addPrice = value;
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: _image != null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200.0,
                                      child: Image.file(_image),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(
                                        vertical: 20.0,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xfff2f2f2),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Icon(
                                        Icons.add_a_photo,
                                      ),
                                    ),
                            ),
                            CustomBtn(
                              text: "Add Data",
                              onPressed: () {
                                // _submitForm();
                                uploadBlog();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
