
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uwokart/screens/HomePage.dart';
import 'package:uwokart/screens/RegisterPage.dart';
import 'package:uwokart/widgets/custom_btn.dart';
import 'package:uwokart/widgets/custom_input.dart';
import 'package:uwokart/widgets/google_btn.dart';
import 'package:uwokart/widgets/login_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Container(
            child: Text(error),
          ),
          actions: [
            TextButton(
              child: Text("Close Dialog"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  // Create a new user account
  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    // Set the form to loading state
    setState(() {
      _loginFormLoading = true;
    });

    // Run the create account method
    String? _loginFeedback = await _loginAccount();

    // If the string is not null, we got error while create account.
    if (_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  // Default Form Loading State
  bool _loginFormLoading = false;

  // Form Input Field Values
  String _loginEmail = "";
  String _loginPassword = "";

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
              // Container(
              //   margin: EdgeInsets.only(top: 50.0),
              //   child: Center(
              //     child: Text(
              //       'LOGIN',
              //       style: TextStyle(
              //         fontSize: 45.0,
              //         fontWeight: FontWeight.w400,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
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
                    'Login to book your seat, I said its your seat',
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
                          'Login to your account',
                          style: TextStyle(
                              color: Color(0xffE81667), fontSize: 16.0),
                        ),
                      ),
                    ),
                    CustomInput(
                      hintText: "Email...",
                      onChanged: (value) {
                        _loginEmail = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: "Password...",
                      onChanged: (value) {
                        _loginPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value) {
                        _submitForm();
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6.0),
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: Text('Forgot Password ?')),
                    ),
                    CustomBtn(
                      text: "Login",
                      onPressed: () {
                        _submitForm();
                      },
                      isLoading: _loginFormLoading,
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
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: LoginText(
                        text: 'Don\'t have account ?',
                        subtext: 'Signup here',
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
