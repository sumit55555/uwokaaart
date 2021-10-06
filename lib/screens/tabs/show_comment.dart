
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/services/firebase_services.dart';

class ShowComment extends StatefulWidget {
  final String productId;
  ShowComment({required this.productId});
  @override
  _ShowCommentState createState() => _ShowCommentState();
}

class _ShowCommentState extends State<ShowComment> {
  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("users");

  final User _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.blogsRef
                  .doc(widget.productId)
                  .collection("Comments")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  // display data in listvie
                  return ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 30.0),
                    children: snapshot.data!.docs.map((document) {
                      return FutureBuilder(
                          future:
                              _firebaseServices.blogsRef.doc(document.id).get(),
                          builder: (context, blogsRef) {
                            if (blogsRef.hasError) {
                              return Container(
                                child: Center(
                                  child: Text('${blogsRef.error}'),
                                ),
                              );
                            }

                            if (blogsRef.connectionState ==
                                ConnectionState.done) {
                              Map _blogMap = blogsRef.data.data();

                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Color(0xfff2f2f2),
                                  border: Border(
                                    top: BorderSide(
                                      color: Color(0xffffffff),
                                      width: 2.5,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 16.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 16.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${document.data()['commentUserId']}',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            SizedBox(height: 4.0),
                                            Text(
                                              '${document.data()['commentBody']}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                              ),
                                            ),

                                            // Text(
                                            //   "${_blogMap['images']}",
                                            //   style: TextStyle(
                                            //     fontSize: 3.0,
                                            //     color: Colors.black,
                                            //     fontWeight: FontWeight.w600,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          });
                    }).toList(),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ));
  }
}
