import 'dart:convert';
import 'package:evento/ConstantUrls.dart';
import 'package:evento/resources/firebase_methods.dart';
import 'package:evento/select_interests.dart';
import 'package:evento/sign_in.dart';
import 'package:evento/widgets/loaders/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;

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
                    onPressed: ()
                    {
                      if (_firstNameController.text.isEmpty)
                      {
                        setState(()
                        {
                          isFirstNameInvalid = true;
                          _firstNameError = "*Cannot be empty";
                          _firstNameFocus.requestFocus();
                        });
                      }
                      else if (!isAlpha(_firstNameController.text.trim()))
                      {
                        setState(()
                        {
                          isFirstNameInvalid = true;
                          _firstNameError = "*Only letters allowed";
                          _firstNameFocus.requestFocus();
                        });
                      }

                      else if (_lastNameController.text.isEmpty)
                      {
                        setState(()
                        {
                          isLastNameInvalid = true;
                          _lastNameError = "*Cannot be empty";
                          _lastNameFocus.requestFocus();
                        });
                      }
                      else if (!isAlpha(_lastNameController.text.trim()))
                      {
                        setState(()
                        {
                          isLastNameInvalid = true;
                          _lastNameError = "*Only letters allowed";
                          _lastNameFocus.requestFocus();
                        });
                      }

                      else if (_emailController.text.isEmpty)
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
                          _emailError = "*Only letters allowed";
                          _emailFocus.requestFocus();
                        });
                      }

                      else if (_phoneController.text.isEmpty)
                      {
                        setState(()
                        {
                          isPhoneInvalid = true;
                          _phoneError = "*Cannot be empty";
                          _phoneFocus.requestFocus();
                        });
                      }
                      else if (!isNumeric(_phoneController.text.trim()))
                      {
                        setState(()
                        {
                          isPhoneInvalid = true;
                          _phoneError = "*Only numbers allowed";
                          _phoneFocus.requestFocus();
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
                        registerUser();

//                        UserDetails user = new UserDetails(
//                          userName: _firstNameController.text.trim() +
//                              " " +
//                              _lastNameController.text.trim(),
//                          photoUrl: " ",
//                          userEmail: _emailController.text.trim(),
//                        );
//
//                        Navigator.of(context).pop();
//
//                        Navigator.pushReplacement(
//                            context,
//                            new MaterialPageRoute(
//                                builder: (context) => SelectInterests(
//                                  name: _firstNameController.text.trim() + " " + _lastNameController.text.trim(),
//                                email: _emailController.text.trim()),
//                                ));
                      }
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
                    onPressed: ()
                    {
                      Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => SignIn()));
                    },
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

  // Store the User details in Db
  registerUser() async
  {
    setState(()
    {
      // Show Loader
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_)
          {
            return Loader();
          }
      );
    });

    
    var response = await http.post(ConstantUrls.JoinNowUrl, body:
                   {
                      "verify" : "TheCandidoVirtualEvent2020",
                      "txtEmail" : _emailController.text.trim(),
                      "txtFirstName" : _firstNameController.text.trim(),
                      "txtLastName" : _lastNameController.text.trim(),
                      "txtPhone" : _phoneController.text.trim(),
                      "txtPassword" : _passwordController.text,
                   });

    var message = jsonDecode(response.body);

    if(message["msg"].toString() == "yes")
    {
      Navigator.of(context).pop(Loader);

      FirebaseMethods methods = FirebaseMethods();

      methods.addDataToDb(_firstNameController.text.trim() + " " + _lastNameController.text.trim(), _emailController.text.trim(), message["id"].toString(), " ", " ").then((value) => print("Success FIrebase"));

      print("ID : " + message["id"].toString());

      setState(() {
        showDialog(
            context: context,
            builder: (_)
            {
              return RegisteredUser();
            }
        );
      });

//      setState(()
//      {
//        _firstNameController.text = "";
//        _lastNameController.text = "";
//        _emailController.text = "";
//        _phoneController.text = "";
//        _passwordController.text = "";
//      });
    }

    else if(message["msg"].toString() == "fail")
    {
      setState(() {
        // Show Failure Popup
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_)
            {
              return SuccessPopup(isSuccessfull: false, message: "Something went wrong while registering. Please try again !", title: "Error !");
            }
        );
      });

    }

    else if(message["msg"].toString() == "success")
    {
      Navigator.of(context).pop();

      FirebaseMethods methods = FirebaseMethods();

      methods.addDataToDb(_firstNameController.text.trim() + " " + _lastNameController.text.trim(), _emailController.text.trim(), message["id"].toString(), " ", " ").then((value) => print("Success FIrebase"));

      print("ID : " + message["id"].toString());

      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  SelectInterests(name: _firstNameController.text.trim() + " " + _lastNameController.text.trim(),
                    email: _emailController.text.trim(), id: message["id"].toString(),)));
    }
  }
}

class RegisteredUser extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "This email already exists. Please sign in or use a different email id",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),

                SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    onPressed: ()
                    {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Close",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1.0,
                        color: Colors.white
                      ),
                    ),
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    splashColor: Colors.white70,
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

// Success Popup
class SuccessPopup extends StatefulWidget
{
  final bool isSuccessfull;
  final String message;
  final String title;

  SuccessPopup({this.isSuccessfull, this.message, this.title});

  @override
  _SuccessPopupState createState() => _SuccessPopupState();
}

class _SuccessPopupState extends State<SuccessPopup>
{
  bool _isSuccessfull;
  String _message = " ";
  String _title = " ";

  @override
  void initState()
  {
    _isSuccessfull = widget.isSuccessfull;
    _message = widget.message;
    _title = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: () {},
      child: AlertDialog(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Text(
              _title,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Merriweather-Regular",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                fontSize: 17,
              ),
            ),
          ),
          elevation: 15,
          content: _isSuccessfull ?
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                  Flexible(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Icon(
                        Icons.done,
                        size: 28,
                        color: Colors.greenAccent[400],
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Text(
                      _message,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.9,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather-Regular",
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              RaisedButton(
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Merriweather-Regular",
                    fontSize: 15,
                    letterSpacing: 0.9,
                  ),
                ),
                color: Colors.blueAccent[400],
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          ) :
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                  Flexible(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Icon(
                        Icons.clear,
                        size: 28,
                        color: Colors.redAccent[400],
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Text(
                      _message,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.9,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather-Regular",
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              RaisedButton(
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Merriweather-Regular",
                    fontSize: 15,
                    letterSpacing: 0.9,
                  ),
                ),
                color: Colors.blueAccent[400],
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          )
      ),
    );
  }
}

//class Loader extends StatelessWidget
//{
//  @override
//  Widget build(BuildContext context)
//  {
//    return Center(
//      child: AlertDialog(
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(5),
//        ),
//        elevation: 0,
//        backgroundColor: Colors.transparent,
//        content: Center(
//          child: Container(
//            height: 250,
//            width: 250,
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>
//              [
//                SpinKitWanderingCubes(
//                  color: Colors.blue,
//                  size: 65,
//                ),
//
//                SizedBox(height: 10,),
//
//                Text(
//                  "Loading...",
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 16,
//                    fontWeight: FontWeight.bold,
//                    letterSpacing: 1,
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}

