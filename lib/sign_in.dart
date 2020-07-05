import 'dart:convert';

import 'package:evento/ConstantUrls.dart';
import 'package:evento/home.dart';
import 'package:evento/join_now.dart';
import 'package:evento/widgets/loaders/loading.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;

/*
*   This is the sign in page which takes
*   - email of the user
*   - password
*
*   After authentication redirects the user to the [home.dart]
* */

class SignIn extends StatefulWidget
{
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>
{
  var blueColor = Color.fromRGBO(58, 88, 146, 1);

  ///////////////////////

  TextEditingController _emailController, _passwordController;

  ///////////////////////

  FocusNode _emailFocus, _passwordFocus;

  ///////////////////////

  static String _emailError, _passwordError;

  /////////////////////

  static bool isEmailInvalid, isPasswordInvalid;

  @override
  void initState()
  {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();

    _emailError = "";
    _passwordError = "";

    isEmailInvalid = false;
    isPasswordInvalid = false;
  }

  @override
  void dispose()
  {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocus.dispose();
    _passwordFocus.dispose();

    _emailError = "";
    _passwordError = "";

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>
              [
                // Form
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>
                      [
                        // Email
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: _emailController,
                            focusNode: _emailFocus,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              focusColor: Colors.grey,
                              labelStyle: TextStyle(
                                fontSize: 15.5,
                                fontFamily: "Helv",
                              ),
                              border: InputBorder.none,
                              hintText: "Email Id",
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: isEmailInvalid
                                      ? Colors.redAccent
                                      : Colors.transparent,
                                ),
                              ),
                              errorText: isEmailInvalid ? _emailError : null,
                              errorStyle: TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 15.5,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: 15.5,
                            ),
                            textCapitalization: TextCapitalization.words,
                            maxLines: 1,
                            onChanged: (String text) {
                              if (text.isEmpty) {
                                setState(() {
                                  isEmailInvalid = true;
                                  _emailError = "*Cannot be empty";
                                  _emailFocus.requestFocus();
                                });
                              } else if (!isEmail(text.trim())) {
                                setState(() {
                                  isEmailInvalid = true;
                                  _emailError = "*Invalid email address";
                                  _emailFocus.requestFocus();
                                });
                              } else {
                                setState(() {
                                  isEmailInvalid = false;
                                  _emailError = "";
                                });
                              }
                            },
                          ),
                        ),

                        Divider(
                          color: Colors.grey[400],
                          height: 1,
                        ),

                        // Password
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              focusColor: Colors.grey,
                              labelStyle: TextStyle(
                                fontSize: 15.5,
                                fontFamily: "Helv",
                              ),
                              border: InputBorder.none,
                              hintText: "Password",
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: isPasswordInvalid
                                      ? Colors.redAccent
                                      : Colors.transparent,
                                ),
                              ),
                              errorText:
                              isPasswordInvalid ? _passwordError : null,
                              errorStyle: TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 15.5,
                              ),
                            ),
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 15.5,
                            ),
                            textCapitalization: TextCapitalization.words,
                            maxLines: 1,
                            onChanged: (String text) {
                              if (text.isEmpty) {
                                setState(() {
                                  isPasswordInvalid = true;
                                  _passwordError = "*Cannot be empty";
                                  _passwordFocus.requestFocus();
                                });
                              } else {
                                setState(() {
                                  isPasswordInvalid = false;
                                  _passwordError = "";
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Login Button
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: OutlineButton(
                    onPressed: ()
                    {
                      if (_emailController.text.isEmpty)
                      {
                        setState(()
                        {
                          isEmailInvalid = true;
                          _emailError = "*Cannot be empty";
                          _emailFocus.requestFocus();
                        });
                      }
                      else if (!isEmail(_emailController.text.trim()))
                      {
                        setState(()
                        {
                          isEmailInvalid = true;
                          _emailError = "*Please enter a valid email id";
                          _emailFocus.requestFocus();
                        });
                      }

                      else if (_passwordController.text.isEmpty)
                      {
                        setState(()
                        {
                          isPasswordInvalid = true;
                          _passwordError = "*Cannot be empty";
                          _passwordFocus.requestFocus();
                        });
                      }

                      else
                      {
                        checkCredentials();
                      }
                    },
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    splashColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    highlightedBorderColor: Colors.white,
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 1.0,
                      ),
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkCredentials() async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_)
      {
        return Loader();
      }
    );

    var response = await http.post(ConstantUrls.LoginUrl, body:
                   {
                     "verify" : "TheCandidoVirtualEvent2020",
                     "txtEmail" : _emailController.text.trim(),
                     "txtPassword" : _passwordController.text
                   });

    print("RESPONSE : " + response.body);

    var message = jsonDecode(response.body);

    if(message["msg"].toString() == "success")
    {
      Navigator.of(context).pop(Loader);

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => Home(
                id: message["id"].toString(),
                name: message["name"].toString(),
              )));
    }
    else
    {
      Navigator.of(context).pop(Loader);

      showDialog(
        context: context,
        builder: (_)
        {
          return SuccessPopup(isSuccessfull: false, message: "Invalid email or password.", title: "Error!",);
        }
      );
    }
  }
}
