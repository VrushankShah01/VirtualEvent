import 'package:flutter/material.dart';

class ConstantUrls
{
  // COLORS USED IN THE APP
  static const Color yellowColor = Color.fromRGBO(251, 204, 111, 1);
  static const Color blueColor = Color.fromRGBO(58, 88, 146, 1);

  static const String ROOT = "http://www.thecandido.in/virtual_event";

  // TEMP IMAGES
     static const String Event1 = "assets/internet.jpg";

  // REGISTRATION URLS

      // JOIN NOW
      static const String JoinNowUrl = ROOT + "/Registration/join_now.php";

      // JOIN NOW WITH LINKEDIN
      static const String LinkedInJoinNowUrl = ROOT + "/Registration/linkedin_join_now.php";

  ////////////////////////////////////////////////////////////////////////////////

  // LOGIN URLS

     // LOGIN
     static const String LoginUrl = ROOT + "/Login/sign_in.php";

  ////////////////////////////////////////////////////////////////////////////////

  // INTERESTS URLS

     // INTEREST SELECTED
     static const String InterestsSelectedUrl = ROOT + "/Interests/interest_selected.php";

     // NO INTEREST SELECTED
     static const String NoInterestsSelectedUrl = ROOT + "/Interests/no_interest_selected.php";

     // GET INTERESTS
     static const String GetInterestsSelectedUrl = ROOT + "/Interests/get_interest_selected.php";

  ////////////////////////////////////////////////////////////////////////////////

  // GET MATCHES

     // GET PEOPLE WITH SAME INTERESTS
    static const String GetPeopleWithSameInterestsUrl = ROOT + "/Matchmaking/get_matches.php";

  ////////////////////////////////////////////////////////////////////////////////

  // GET USER DETAILS

     // GET USER DETAILS FROM DB
     static const String GetUserDetailsUrl = ROOT + "/User/get_user_details.php";
}
