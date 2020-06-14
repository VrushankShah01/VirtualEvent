import 'package:evento/getting_started.dart';
import 'package:evento/profile.dart';
import 'package:flutter/material.dart';

class JoinNow extends StatefulWidget {
  @override
  _JoinNowState createState() => _JoinNowState();
}

class _JoinNowState extends State<JoinNow> {
  var blueColor = Color.fromRGBO(58, 88, 146, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      body: SafeArea(
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
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusColor: Colors.grey,
                          labelStyle: TextStyle(
                            fontSize: 15.5,
                            fontFamily: "Helv",
                          ),
                          border: InputBorder.none,
                          hintText: "First Name",
                          hintStyle: TextStyle(
                            fontSize: 15.5,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 15.5,
                        ),
                        textCapitalization: TextCapitalization.words,
                        maxLines: 1,
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
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusColor: Colors.grey,
                          labelStyle: TextStyle(
                            fontSize: 15.5,
                            fontFamily: "Helv",
                          ),
                          border: InputBorder.none,
                          hintText: "Last Name",
                          hintStyle: TextStyle(
                            fontSize: 15.5,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 15.5,
                        ),
                        textCapitalization: TextCapitalization.words,
                        maxLines: 1,
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
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusColor: Colors.grey,
                          labelStyle: TextStyle(
                            fontSize: 15.5,
                            fontFamily: "Helv",
                          ),
                          border: InputBorder.none,
                          hintText: "Email Id",
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
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusColor: Colors.grey,
                          labelStyle: TextStyle(
                            fontSize: 15.5,
                            fontFamily: "Helv",
                          ),
                          border: InputBorder.none,
                          hintText: "Phone Number",
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
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusColor: Colors.grey,
                          labelStyle: TextStyle(
                            fontSize: 15.5,
                            fontFamily: "Helv",
                          ),
                          border: InputBorder.none,
                          hintText: "Password",
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
    );
  }
}
