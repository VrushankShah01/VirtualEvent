import 'package:evento/first_splash.dart';
import 'package:evento/getting_started.dart';
import 'package:evento/video_call_screens/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:provider/provider.dart';
import 'profile.dart';

void main() => runApp(
    MultiProvider(
      providers:[
      ChangeNotifierProvider(create: (_) => UserProvider()),],
      child: MaterialApp(
  debugShowCheckedModeBanner: false,
  home: GettingStarted(),
),
    ));

//class Home extends StatefulWidget
//{
//  @override
//  _HomeState createState() => _HomeState();
//}
//
//class _HomeState extends State<Home>
//{
//
//
//  @override
//  Widget build(BuildContext context)
//  {
//    return Scaffold(
//      body: SafeArea(
//        child: SingleChildScrollView(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            mainAxisAlignment: MainAxisAlignment.center,
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>
//            [
//              Center(
//                child: Text(
//                  "Sign up",
//                  style: TextStyle(
//                    color: Colors.black,
//                    fontSize: 22,
//                    letterSpacing: 1.0,
//                  ),
//                ),
//              ),
//
//              SizedBox(height: 15,),
//
//              Padding(
//                padding: EdgeInsets.all(20.0),
//                child: RaisedButton.icon(
//                  onPressed: ()
//                  {
//                    _signIn(context).catchError((e) => print(e));
//                  },
//                  icon: Icon(
//                    Icons.email,
//                    color: Colors.white,
//                  ),
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(8)
//                  ),
//                  label: Padding(
//                    padding: EdgeInsets.all(10.0),
//                    child:Text(
//                    "Sign up with Email",
//                    style: TextStyle(
//                      color: Colors.white,
//                      letterSpacing: 1.0,
//                      fontSize: 18
//                    ),
//                  ),
//                  ),
//                  color: Colors.redAccent,
//              )
//              ),
//
//              SizedBox(height: 15,),
//
//              Padding(
//                  padding: EdgeInsets.all(20.0),
//                  child: LinkedInButtonStandardWidget(
//                    onTap: ()
//                    {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (BuildContext context) => LinkedInUserWidget(
//                            appBar: AppBar(
//                              title: Text('OAuth User'),
//                            ),
//                            destroySession: logoutUser,
//                            redirectUrl: redirectUrl,
//                            clientId: clientId,
//                            clientSecret: clientSecret,
//                            onGetUserProfile: (LinkedInUserModel linkedInUser) {
//                              print('Access token ${linkedInUser.token.accessToken}');
//
//                              print('User id: ${linkedInUser.userId}');
//
//                              user = UserObject(
//                                firstName: linkedInUser.firstName.localized.label,
//                                lastName: linkedInUser.lastName.localized.label,
//                                email: linkedInUser
//                                    .email.elements[0].handleDeep.emailAddress,
//                              );
//                              setState(() {
//                                logoutUser = false;
//                              });
//
//                              Navigator.pop(context);
//                            },
//                            catchError: (LinkedInErrorObject error) {
//                              print('Error description: ${error.description},'
//                                  ' Error code: ${error.statusCode.toString()}');
//                              Navigator.pop(context);
//                            },
//                          ),
//                          fullscreenDialog: true,
//                        ),
//                      );
//                    },
//                  )
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//  final GoogleSignIn _googleSignIn = new GoogleSignIn();
//
//  Future _signIn(BuildContext context) async
//  {
//    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
//
////    FirebaseUser userDetails = (await _firebaseAuth.signInWithCredential(credential)).user;
////    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
//
////    List<ProviderDetails> providerData = new List<ProviderDetails>();
////    providerData.add(providerInfo);
//
//    UserDetails details = new UserDetails(photoUrl: googleUser.photoUrl, userEmail: googleUser.email, userName: googleUser.displayName);
//
//    Navigator.push(context, new MaterialPageRoute(builder: (context) => new ProfileScreen(details)));
//
////    return googleUser;
//  }
//
//  _signUpEmail() async
//  {
//    try
//    {
//      await _googleSignIn.signIn();
//    }
//    catch(err)
//    {
//      print(err);
//    }
//  }
//
//  final String redirectUrl = 'https://www.linkedin.com/oauth/v2/authorization';
//  final String clientId = '864rvsopq5jlvs';
//  final String clientSecret = 'vANp2b2xTeY43sVI';
//}

