import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:evento/profile.dart';
import 'package:evento/widgets/slide_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GettingStarted extends StatefulWidget
{
  @override
  _GettingStartedState createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted>
{
  List<String> intro = [
    "Candido",
    "Profile",
    "Connect",
    "Match"
  ];

  var yellowColor = Color.fromRGBO(251, 204, 111, 1);
  var blueColor = Color.fromRGBO(58, 88, 146, 1);
  var whiteColor = Colors.white;

  Timer _timer;

  List<Widget> sliderWidget = [
    Center(
      child: Container(
        color: Colors.transparent,
        child: Center(child: Image.asset("assets/actual.png",)),
      ),
    )  ,

    Container(
    ),

    Container(
    ),

    Container(
    ),

  ];

  var currentPage = 0;

  PageController pageController = PageController(initialPage: 0);

  UserObject user;
  bool logoutUser = false;

  @override
  void initState()
  {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer)
    {
//      print("CURRENT PAGE : " + currentPage.toString());

      if (currentPage < 3) {
        if (mounted)
          setState(() {
            currentPage++;
          });
      }
      else {
        if (mounted)
          setState(() {
            currentPage = 0;
          });
      }

      if (mounted)
        pageController.animateToPage(
            currentPage,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeIn
        );
    });

    super.initState();
  }

  @override
  void dispose()
  {
    _timer.cancel();
    pageController.dispose();
    super.dispose();
  }

  // On Page Changed Event - For the Texts below the Menu Items
  _onPageViewChange(int page)
  {
//    print("View Change" + page.toString());

//    // About Us
//    if(page == 5)
//    {
//      setState(()
//      {
//        pageTitle = "What is RCHR? Tap on the image "
//            "above to know about us.";
//
//        _child = Text(
//          '$pageTitle',
//          style: TextStyle(
//            color: Colors.white,
//            fontWeight: FontWeight.bold,
//            fontFamily: "Gotham",
//            fontSize: 16.0,
//            letterSpacing: 0.8,
//          ),
//          key: UniqueKey(),
//        );
//      });
//    }
//
//    // Social Initiative
//    else if(page == 4)
//    {
//      setState(()
//      {
//        pageTitle = "Aashayein - Adopt a Village.\nAims at holistic "
//            "development of rural villages in Maharashtra. Know more about "
//            "our initiative by tapping on the image above.";
//
//        _child = Text(
//          '$pageTitle',
//          style: TextStyle(
//            color: Colors.white,
//            fontWeight: FontWeight.bold,
//            fontFamily: "Gotham",
//            fontSize: 16.0,
//            letterSpacing: 0.8,
//          ),
//          key: UniqueKey(),
//        );
//      });
//    }
//
//    // Gallery
//    else if(page == 3)
//    {
//      setState(()
//      {
//        pageTitle = "View pictures of our projects, social work, etc. by"
//            " tapping on the image above.";
//
//        _child = Text(
//          '$pageTitle',
//          style: TextStyle(
//            color: Colors.white,
//            fontWeight: FontWeight.bold,
//            fontFamily: "Gotham",
//            fontSize: 16.0,
//            letterSpacing: 0.8,
//          ),
//          key: UniqueKey(),
//        );
//      });
//    }
//
//    // Team
//    else if(page == 2)
//    {
//      setState(()
//      {
//        pageTitle = "Know more about the team behind RCHR by tapping on "
//            "the above image.";
//
//        _child = Text(
//          '$pageTitle',
//          style: TextStyle(
//            color: Colors.white,
//            fontWeight: FontWeight.bold,
//            fontFamily: "Gotham",
//            fontSize: 16.0,
//            letterSpacing: 0.8,
//          ),
//          key: UniqueKey(),
//        );
//      });
//    }
//
//    // Contact Us
//    else if(page == 1)
//    {
//      setState(()
//      {
//        pageTitle = "Get in touch with us by tapping on the above image.";
//
//        _child = Text(
//          '$pageTitle',
//          style: TextStyle(
//            color: Colors.white,
//            fontWeight: FontWeight.bold,
//            fontFamily: "Gotham",
//            fontSize: 16.0,
//            letterSpacing: 0.8,
//          ),
//          key: UniqueKey(),
//        );
//      });
//    }
//
//    // Login
//    else if(page == 0)
//    {
//      if(isLoggedIn == true)
//      {
//        setState(()
//        {
//          pageTitle = "Go to the Dashboard";
//
//          _child = Text(
//            '$pageTitle',
//            style: TextStyle(
//              color: Colors.white,
//              fontWeight: FontWeight.bold,
//              fontFamily: "Gotham",
//              fontSize: 16.0,
//              letterSpacing: 0.8,
//            ),
//            key: UniqueKey(),
//          );
//        });
//      }
//      else
//      {
//        setState(()
//        {
//          pageTitle = "RCHRites login by tapping on the above image.";
//
//          _child = Text(
//            '$pageTitle',
//            style: TextStyle(
//              color: Colors.white,
//              fontWeight: FontWeight.bold,
//              fontFamily: "Gotham",
//              fontSize: 16.0,
//              letterSpacing: 0.8,
//            ),
//            key: UniqueKey(),
//          );
//        });
//      }
//    }
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future _signIn(BuildContext context) async
  {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

//    FirebaseUser userDetails = (await _firebaseAuth.signInWithCredential(credential)).user;
//    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

//    List<ProviderDetails> providerData = new List<ProviderDetails>();
//    providerData.add(providerInfo);

    UserDetails details = new UserDetails(photoUrl: googleUser.photoUrl, userEmail: googleUser.email, userName: googleUser.displayName);

    Navigator.of(context).pop();

    Navigator.push(context, new MaterialPageRoute(builder: (context) => ProfileScreen(details)));

//    return googleUser;
  }

  final String redirectUrl = 'http://www.thecandido.in/virtual_event';
  final String clientId = '864rvsopq5jlvs';
  final String clientSecret = 'vANp2b2xTeY43sVI';

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: currentPage == 0 ? Color.fromRGBO(250, 250, 250, 1) : currentPage == 1 ? yellowColor : currentPage == 2 ? Color.fromRGBO(58, 88, 146, 1) : yellowColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>
            [
              Expanded(
                flex: 2,
                child: PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: intro.length,
                    reverse: false,
                    onPageChanged: _onPageViewChange,
                    itemBuilder: (context, index)
                    {
                      if(index == 0)
                        return sliderWidget[0];
                      else if(index == 1)
                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>
                            [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "Create your professional profile",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Color.fromRGBO(58, 88, 146, 1)
                                  ),
                                ),
                              ),

                              SizedBox(height: 40,),

                              Stack(
                                children: <Widget>
                                [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black
                                          )
                                        ),
                                        height: 220,
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>
                                          [
                                            SizedBox(height: 45,),

                                              Flexible(
                                                flex: 0,
                                                child: Center(
                                                  child: Text(
                                                    "Ram Kapoor",
                                                    style: TextStyle(
                                                      fontSize: 27,
                                                      color: Color.fromRGBO(58, 88, 146, 1)
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            SizedBox(height: 5,),

                                            Flexible(
                                              flex: 0,
                                              child: Center(
                                                child: Text(
                                                  "UI Designer at ABC Company",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color.fromRGBO(58, 88, 146, 1)
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 10,),

                                            Flexible(
                                              flex: 0,
                                              child: Center(
                                                child: Text(
                                                  "Mumbai Maharashtra India",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromRGBO(58, 88, 146, 1)
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 25,),

                                            Expanded(
                                              child: FlatButton(
                                                onPressed: (){},
                                                child: Text(
                                                  "Connect",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromRGBO(251, 204, 111, 1),
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.0
                                                  ),
                                                ),
                                                color: Color.fromRGBO(58, 88, 146, 1),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  FractionalTranslation(
                                    translation: Offset(0.0, -0.4),
                                    child: Align(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 50,
                                        child: Icon(
                                          Icons.person,
                                          size: 70,
                                          color: Colors.white,
                                        ),
                                      ),
                                      alignment: FractionalOffset(0.5, 0.0),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      else if(index == 2)
                        return Container(
                          color: blueColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>
                            [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "Connect and keep in touch with your network",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Color.fromRGBO(251, 204, 111, 1)
                                  ),
                                ),
                              ),

                              SizedBox(height: 10,),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    color: blueColor,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Image.asset("assets/chat.png", fit: BoxFit.cover,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      else if(index == 3)
                        return Container(
                          color: yellowColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>
                            [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "Virtual Matchmaking on your interests",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: blueColor
                                  ),
                                ),
                              ),

                              SizedBox(height: 10,),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Image.asset("assets/match.png", fit: BoxFit.cover,),
                                    color: yellowColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      else
                        return sliderWidget[index];
                    }
                )
              ),

              SizedBox(height: 10,),

              // Scroll Indicator
              SmoothPageIndicator(
                controller: pageController,
                count: intro.length,
                textDirection: TextDirection.ltr,
                effect: ScrollingDotsEffect(
                  activeDotColor: Colors.grey[400],
                  dotColor: Colors.white,
                  radius: 50,
                  dotHeight: 12,
                  dotWidth: 12,
                  spacing: 8,
                  strokeWidth: 1.0,
                  paintStyle: PaintingStyle.fill
                ),
              ),

              SizedBox(height: 10,),

              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>
                      [
                        // Join Now
                        RaisedButton(
                          onPressed: (){},
                          child: Text(
                            "Join Now",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          color: currentPage == 2 ? yellowColor : blueColor,
                          padding: EdgeInsets.all(10),
                          textColor: Colors.white,
                        ),

                        SizedBox(height: 8,),

                        // Sign in with Google
                        Container(
                          child: RaisedButton(
                            onPressed: ()
                            {
                              _signIn(context).catchError((e) => print(e));
                            },
                            padding: EdgeInsets.all(10.0),
                            color: currentPage == 3 ? blueColor : currentPage == 1 ? blueColor : yellowColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>
                              [
                                Container(
                                  padding: EdgeInsets.all(0.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent
                                  ),
                                  child: Image.asset(
                                    "assets/google_logo.png",
                                    height: 22,
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                    "Sign in with Google",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0
                                    )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 8,),

                        // Sign in with LinkedIn
                        Container(
                          child: RaisedButton(
                            onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) => LinkedInUserWidget(
                                  clientId: clientId,
                                  clientSecret: clientSecret,
                                  redirectUrl: redirectUrl,
                                  destroySession: false,
                                  appBar: AppBar(
                                    title: Text(
                                      "LinkedIn Sign in",
                                      style: TextStyle(
                                        letterSpacing: 1.0
                                      ),
                                    ),
                                  ),
                                  onGetUserProfile: (LinkedInUserModel model)
                                  {
                                    print("ACCESS TOKEN : " + model.token.accessToken);

                                    print("Name : " + model.firstName.localized.label);
                                    print("Email : " + model.email.elements[0].handleDeep.emailAddress);

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    UserDetails details = new UserDetails(userName: model.firstName.localized.label + " " + model.lastName.localized.label, userEmail: model.email.elements[0].handleDeep.emailAddress, photoUrl: model.profilePicture.displayImage);
                                    Navigator.push(context, new MaterialPageRoute(builder: (context) => ProfileScreen(details)));
                                  },
                                )
                              ));
                            },
                            padding: EdgeInsets.all(10.0),
                            color: currentPage == 3 ? blueColor : currentPage == 1 ? blueColor : yellowColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>
                              [
                                Container(
                                  padding: EdgeInsets.all(0.0),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent
                                  ),
                                  child: Image.asset(
                                    "assets/linked.png",
                                    height: 26,
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                      "Sign in with LinkedIn",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 8,),

                        // Sign in Button
                        FlatButton(
                          onPressed: (){},
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.all(10),
                          textColor: currentPage == 2 ? yellowColor : blueColor,
                        ),

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserDetails
{
//  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
//  final List<ProviderDetails> providerData;

  UserDetails({ this.userEmail, this.userName, this.photoUrl,});
}

class ProviderDetails
{
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}

class AuthCodeObject {
  String code, state;

  AuthCodeObject({this.code, this.state});
}

class UserObject {
  String firstName, lastName, email;

  UserObject({this.firstName, this.lastName, this.email});
}