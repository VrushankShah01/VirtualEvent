import 'package:evento/getting_started.dart';
import 'package:evento/profile.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class JoinNow extends StatefulWidget {
  @override
  _JoinNowState createState() => _JoinNowState();
}

class _JoinNowState extends State<JoinNow> {
  var blueColor = Color.fromRGBO(58, 88, 146, 1);

  TextEditingController _firstNameController,
      _lastNameController,
      _emailController,
      _phoneController,
      _passwordController;

  ///////////////////////

  FocusNode _firstNameFocus,
      _lastNameFocus,
      _emailFocus,
      _phoneFocus,
      _passwordFocus;

  //////////////////////

  static String _firstNameError,
      _lastNameError,
      _emailError,
      _phoneError,
      _passwordError;

  /////////////////////

  static bool isFirstNameInvalid,
      isLastNameInvalid,
      isEmailInvalid,
      isPhoneInvalid,
      isPasswordInvalid;

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();

    _firstNameFocus = FocusNode();
    _lastNameFocus = FocusNode();
    _emailFocus = FocusNode();
    _phoneFocus = FocusNode();
    _passwordFocus = FocusNode();

    _firstNameError = "";
    _lastNameError = "";
    _emailError = "";
    _phoneError = "";
    _passwordError = "";

    isFirstNameInvalid = false;
    isLastNameInvalid = false;
    isEmailInvalid = false;
    isPhoneInvalid = false;
    isPasswordInvalid = false;
  }

  @override
  void dispose() {
    super.dispose();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();

    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();

    _firstNameError = "";
    _lastNameError = "";
    _emailError = "";
    _phoneError = "";
    _passwordError = "";
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
              children: <Widget>[
                // Form
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // First Name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: _firstNameController,
                            focusNode: _firstNameFocus,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              focusColor: Colors.grey,
                              labelStyle: TextStyle(
                                fontSize: 15.5,
                                fontFamily: "Helv",
                              ),
                              border: InputBorder.none,
                              hintText: "First Name",
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: isFirstNameInvalid
                                      ? Colors.redAccent
                                      : Colors.transparent,
                                ),
                              ),
                              errorText:
                                  isFirstNameInvalid ? _firstNameError : null,
                              errorStyle: TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 15.5,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 15.5,
                            ),
                            textCapitalization: TextCapitalization.words,
                            maxLines: 1,
                            onChanged: (String text) {
                              if (text.trim().isEmpty) {
                                setState(() {
                                  isFirstNameInvalid = true;
                                  _firstNameError = "*Cannot be empty";
                                  _firstNameFocus.requestFocus();
                                });
                              } else if (!isAlpha(text.trim())) {
                                setState(() {
                                  isFirstNameInvalid = true;
                                  _firstNameError = "*Only letters allowed";
                                  _firstNameFocus.requestFocus();
                                });
                              } else {
                                setState(() {
                                  isFirstNameInvalid = false;
                                  _firstNameError = "";
                                });
                              }
                            },
                          ),
                        ),

                        Divider(
                          color: Colors.grey[400],
                          height: 1,
                        ),

                        // Last Name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: _lastNameController,
                            focusNode: _lastNameFocus,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              focusColor: Colors.grey,
                              labelStyle: TextStyle(
                                fontSize: 15.5,
                                fontFamily: "Helv",
                              ),
                              border: InputBorder.none,
                              hintText: "Last Name",
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: isLastNameInvalid
                                      ? Colors.redAccent
                                      : Colors.transparent,
                                ),
                              ),
                              errorText:
                                  isLastNameInvalid ? _lastNameError : null,
                              errorStyle: TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 15.5,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 15.5,
                            ),
                            textCapitalization: TextCapitalization.words,
                            maxLines: 1,
                            onChanged: (String text) {
                              if (text.isEmpty) {
                                setState(() {
                                  isLastNameInvalid = true;
                                  _lastNameError = "*Cannot be empty";
                                  _lastNameFocus.requestFocus();
                                });
                              } else if (!isAlpha(text.trim())) {
                                setState(() {
                                  isLastNameInvalid = true;
                                  _lastNameError = "*Only letters allowed";
                                  _lastNameFocus.requestFocus();
                                });
                              } else {
                                setState(() {
                                  isLastNameInvalid = false;
                                  _lastNameError = "";
                                });
                              }
                            },
                          ),
                        ),

                        Divider(
                          color: Colors.grey[400],
                          height: 1,
                        ),

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

                        // Phone
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: _phoneController,
                            focusNode: _phoneFocus,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              focusColor: Colors.grey,
                              labelStyle: TextStyle(
                                fontSize: 15.5,
                                fontFamily: "Helv",
                              ),
                              border: InputBorder.none,
                              hintText: "Phone Number",
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: isPhoneInvalid
                                      ? Colors.redAccent
                                      : Colors.transparent,
                                ),
                              ),
                              errorText: isPhoneInvalid ? _phoneError : null,
                              errorStyle: TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 15.5,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 15.5,
                            ),
                            textCapitalization: TextCapitalization.words,
                            maxLines: 1,
                            onChanged: (String text) {
                              if (text.isEmpty) {
                                setState(() {
                                  isPhoneInvalid = true;
                                  _phoneError = "*Cannot be empty";
                                  _phoneFocus.requestFocus();
                                });
                              } else if (!isNumeric(text.trim())) {
                                setState(() {
                                  isPhoneInvalid = true;
                                  _phoneError = "*Invalid phone number";
                                  _phoneFocus.requestFocus();
                                });
                              } else {
                                setState(() {
                                  isPhoneInvalid = false;
                                  _phoneError = "";
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

                // Agree & Join Button
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: OutlineButton(
                    onPressed: () {
                      UserDetails user = new UserDetails(
                          userName: "Join Now Name",
                          photoUrl: " ",
                          userEmail: "Join Now Email");

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ProfileScreen(user)));
                    },
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    splashColor: Colors.white70,
                    highlightedBorderColor: Colors.white,
                    child: Text(
                      "Agree & Join",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 1.0,
                      ),
                    ),
                    padding: EdgeInsets.all(12.0),
                  ),
                ),

                // Sign In
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: FlatButton(
                    onPressed: () {},
                    splashColor: Colors.transparent,
                    child: Text(
                      "Already have an account? Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
