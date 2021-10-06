
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/screens/LoginPage.dart';
import 'package:uwokart/widgets/custom_btn.dart';
import 'package:uwokart/widgets/custom_input.dart';
import 'package:uwokart/widgets/google_btn.dart';
import 'package:uwokart/widgets/login_text.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Build an alert to show some errors
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close Dialog'))
            ],
          );
        });
  }

  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      return e.message;
    } catch (e) {
      return (e.toString());
    }
  }

  void _submitForm() async {
    setState(() {
      _registerFormLoading = true;
    });

    String? _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  bool _registerFormLoading = false;

  // Register email & password
  String _registerEmail = "";
  String _registerPassword = "";

  // Focus Node for input fields
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Container(
          color: Color(0xffE81667),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50.0),
                child: Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0),
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
                    'Register to book your seat, I said its your seat',
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
                margin: EdgeInsets.symmetric(vertical: 30.0),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Register to your account',
                          style: TextStyle(
                              color: Color(0xffE81667), fontSize: 16.0),
                        ),
                      ),
                    ),
                    CustomInput(
                      hintText: 'Email...',
                      onChanged: (value) {
                        _registerEmail = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: 'Password...',
                      onChanged: (value) {
                        _registerPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value) {
                        _submitForm();
                      }, textInputAction: ,
                    ),
                    CustomBtn(
                      text: 'Create new Account',
                      onPressed: () {
                        _submitForm();
                      },
                      isLoading: _registerFormLoading, outlineBtn: false,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 0),
                                child: Text(
                                  'Or',
                                  // style: FONT_CONST.REGULAR_GRAY5_10,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GoogleBtn(
                            imageUrl: "assets/images/google.png",
                            text: "Google",
                          ),
                          GoogleBtn(
                            imageUrl: "assets/images/facebook.png",
                            text: "Facebook",
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: LoginText(
                        text: 'Already have an account ?',
                        subtext: 'Login here',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
