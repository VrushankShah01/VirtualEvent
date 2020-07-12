import 'dart:convert';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:evento/ConstantUrls.dart';
import 'package:evento/chat_screen.dart';
import 'package:evento/custom_icons/shake_hand_icons.dart';
import 'package:evento/custom_route_transitions/fade_page_route.dart';
import 'package:evento/custom_route_transitions/slide_from_right.dart';
import 'package:evento/home.dart';
import 'package:evento/profile.dart';
import 'package:evento/services/GetPeopleWithSameInterestData.dart';
import 'package:evento/services/GetPeopleWithSameInterestModel.dart';
import 'package:evento/sponsors_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ViewDetailedEventPage extends StatefulWidget
{
  final String tag, imagePath, title, date, location, description, time, uid, uName;

  ViewDetailedEventPage({this.tag, this.imagePath, this.title, this.date, this.location, this.description, this.time, this.uid, this.uName});

  @override
  _ViewDetailedEventPageState createState() => _ViewDetailedEventPageState();
}

class _ViewDetailedEventPageState extends State<ViewDetailedEventPage>
{
  int selectedPage = 0;

  var pageOptions;

  @override
  void initState()
  {
    super.initState();

    print("MAIN ID : " + widget.uid.toString());

    pageOptions =
    [
      // 0 - Home
      Home(
        imagePath: widget.imagePath,
        tag: widget.tag,
        title: widget.title,
        date: widget.date,
        time: widget.time,
        description: widget.description,
        location: widget.location,
      ),

      // 1 - Schedule
      EventSchedule(),

      // 2 - Network
      EventNetwork(
        uid: widget.uid,
        uName: widget.uName,
      ),

      // 3 - Sponsors
      EventSponsors(),

      // 4 - User Profile
      UserProfile(
        name: widget.uName,
        id: widget.uid,
      ),
    ];
  }

  var iconColor;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
          child: pageOptions[selectedPage]
      ),
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        actions: <Widget>
        [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.chat
            ),
          )
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        items:
        [
          TabItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: "About",
          ),

          TabItem(
              icon: Icon(
                Icons.schedule,
                color: Colors.white,
              ),
              title: "Schedule"
          ),

          TabItem(
              icon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              title: "Network"
          ),

          TabItem(
              icon: Icon(
                ShakeHand.handshake,
                color: Colors.white,
              ),
              title: "Sponsors"
          ),

          TabItem(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: "Profile",
          )
        ],
        backgroundColor: Colors.blue[800],
        activeColor: ConstantUrls.yellowColor,
        top: 0,
        height: 55,
        onTap: (i)
        {
          setState(()
          {
            selectedPage = i;
          });
        },
      ),
    );
  }
}

// Event Home
class Home extends StatelessWidget
{
  final String tag, imagePath, title, date, location, description, time;

  Home({this.imagePath, this.tag, this.title, this.date, this.location, this.description, this.time});

  @override
  Widget build(BuildContext context)
  {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>
        [
          Expanded(
            child: ListView(
              children: <Widget>
              [
                // Cover Image
                Hero(
                  tag: tag,
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          imagePath,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15,),

                // Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 15,),

                // Date
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>
                    [
                      Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: Colors.grey,
                      ),

                      SizedBox(width: 10,),

                      Flexible(
                        child: Text(
                          date,
                          style: TextStyle(
                            color: Colors.grey[850],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15,),

                // Time
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>
                    [
                      Icon(
                        Icons.access_alarm,
                        size: 20,
                        color: Colors.grey,
                      ),

                      SizedBox(width: 10,),

                      Flexible(
                        child: Text(
                          time,
                          style: TextStyle(
                            color: Colors.grey[850],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15,),

                // Location
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>
                    [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.grey,
                      ),

                      SizedBox(width: 10,),

                      Flexible(
                        child: Text(
                          location,
                          style: TextStyle(
                            color: Colors.grey[850],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15,),

                // Line
                Divider(
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),

                SizedBox(height: 15,),

                // About the Event
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    "About the Event",
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 15,),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[850],
                      fontSize: 14,
                    ),
                  ),
                ),

                SizedBox(height: 15,),

                // Line
                Divider(
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),

                SizedBox(height: 15,),

                // Participants
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    "Participants",
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 15,),

                // Number of Participants
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "1000 Delegates\n50 Exhibitors",
                    style: TextStyle(
                      color: Colors.grey[850],
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),

                SizedBox(height: 15,),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Event Schedule
class EventSchedule extends StatefulWidget
{
  @override
  _EventScheduleState createState() => _EventScheduleState();
}

class _EventScheduleState extends State<EventSchedule>
{
  static int scheduleIndex;

  List<String> timing =
  [
    "08:00 AM",
    "08:45 AM",
    "08:50 AM",
    "09:30 AM",
    "09:35 AM",
    "10:00 AM",
    "10:05 AM",
    "10:10 AM",
    "10:40 AM",
    "10:45 AM",
    "11:25 AM",
    "11:30 AM",
    "11:45 AM",
  ];

  List<String> details =
  [
    "Welcome to Virtual Event",
    "Countdown Started",
    "Opening Remarks",
    "Break Time",
    "Fireside Keynote",
    "Break Time",
    "Fireside Chat",
    "Break Time",
    "The Secret Sauce",
    "Break Time",
    "Top Best Practices when Planning Your Virtual Event",
    "Break Time",
    "Informa",
  ];

  List<bool> isBookmarked =
  [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  static bool isAlreadyBookmarked = false, isTapped1 = false, isTapped2 = false;

  List<String> bookmarkedSchedule =
  [];

  @override
  void initState()
  {
    super.initState();

    scheduleIndex = 0;
    getBookMarkedSchedule();
  }

  getBookMarkedSchedule() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> keys = prefs.getKeys().toList();

    var indexSplit;

    for(String k in keys)
    {
      int indexOfDash = k.indexOf("-") + 1;
      int indexOfQuestion = k.indexOf("?");

      indexSplit = k.substring(indexOfDash, indexOfQuestion);

      int indexOfDashKey = k.indexOf("-");

      var keyword = k.substring(0, indexOfDashKey);

      print("INDEX SPLIT : " + indexSplit.toString());

      if(keyword == "details")
      {
        bookmarkedSchedule.add(prefs.get("details-$indexSplit?"));
        print("DETAILS : " + bookmarkedSchedule.toString());
      }
    }

  }

  @override
  Widget build(BuildContext context)
  {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>
        [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
              child: Container(
                color: Colors.blue[800],
                child: TabBar(
                  indicatorPadding: EdgeInsets.all(5),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      letterSpacing: 1.0
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  indicator: BubbleTabIndicator(
                    indicatorColor: ConstantUrls.yellowColor,
                    indicatorRadius: 8,
                    padding: EdgeInsets.all(8),
                    tabBarIndicatorSize: TabBarIndicatorSize.label,
                  ),
                  tabs: <Widget>
                  [
                    Tab(
                      child: Text(
                        "My Schedule",
                      ),
                    ),

                    Tab(
                      child: Text(
                          "Event"
                      ),
                    ),

                    Tab(
                      child: Text(
                          "Availability"
                      ),
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      scheduleIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),

          // Days
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>
                [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: FlatButton(
                      child: Text(
                        "Thu 9",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8)
                        ),
                        side: BorderSide(
                          color: Colors.white
                        )
                      ),
                      onPressed: ()
                      {
                        setState(()
                        {
                          if(isTapped1 == true && isTapped2 == false)
                          {
                            isTapped1 = false;
                          }
                          else if(isTapped1 == false && isTapped2 == true)
                          {
                            isTapped1 = true;
                            isTapped2 = false;
                          }
                          else if(isTapped1 == true && isTapped2 == false)
                          {
                            isTapped1 = false;
                            isTapped2 = true;
                          }
                          else if(isTapped1 == false && isTapped2 == false)
                          {
                            isTapped1 = true;
                            isTapped2 = false;
                          }
                        });
                      },
                      color: isTapped1 ? ConstantUrls.yellowColor : Colors.transparent,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FlatButton(
                      child: Text(
                        "Fri 10",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8)
                          ),
                          side: BorderSide(
                              color: Colors.white
                          )
                      ),
                      onPressed: ()
                      {
                        setState(()
                        {
                          if(isTapped2 == true && isTapped1 == false)
                          {
                            isTapped2 = false;
                          }
                          else if(isTapped2 == false && isTapped1 == true)
                          {
                            isTapped2 = true;
                            isTapped1 = false;
                          }
                          else if(isTapped2 == true && isTapped1 == false)
                          {
                            isTapped2 = false;
                            isTapped1 = true;
                          }
                          else if(isTapped2 == false && isTapped1 == false)
                          {
                            isTapped2 = true;
                            isTapped1 = false;
                          }
                        });
                      },
                      color: isTapped2 ? ConstantUrls.yellowColor : Colors.transparent,
                    ),
                  )
                ],
              ),
            ),
          ),

          (scheduleIndex == 0)
              ?
          Expanded(child: myScheduleWidget())
              :
          (scheduleIndex == 1)
              ?
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  itemCount: 12,
                  itemBuilder: (context, index)
                  {
                    isAlreadyBookmarked = bookmarkedSchedule.contains(details[index]);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>
                      [
                        // Time
                        Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "- " + timing[index].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          padding: EdgeInsets.all(0),
                        ),

                        // Details
                        Container(
                          height: 160,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>
                                [
                                  // Text
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        details[index].toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),

                                  // Bookmark
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        onPressed: ()
                                        {
                                          print("IS ALREADY : " + isAlreadyBookmarked.toString());

                                          isAlreadyBookmarked = bookmarkedSchedule.contains(details[index]);

                                          if(isAlreadyBookmarked == true)
                                          {
                                            setState(()
                                            {
                                              bookmarkedSchedule.remove(details[index]);
                                              print(bookmarkedSchedule.toString());

                                              removeEvent(
                                                  index: index.toString(),
                                                  time: timing[index],
                                                  details: details[index]
                                              );
                                            });
                                          }
                                          else
                                          {
                                            setState(()
                                            {
                                              bookmarkedSchedule.add(details[index]);
                                              print(bookmarkedSchedule.toString());

                                              bookMarkEvent(
                                                  index: index.toString(),
                                                  time: timing[index],
                                                  details: details[index]);
                                            });
                                          }
                                        },
                                        icon: isAlreadyBookmarked
                                            ? Icon(
                                            Icons.bookmark
                                        )
                                            : Icon(
                                          Icons.bookmark_border,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
              ),
            ),
          )
              :
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  "Availablity",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bookMarkEvent({index, time, details}) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("index-$index?", index);
    await prefs.setString("time-$index?", time);
    await prefs.setString("details-$index?", details);

    print("KEYS : " + prefs.getKeys().toString());
    print("INDEX : " + prefs.getString("index-$index?") + "\nTIME : " + prefs.getString("time-$index?") + "\nDETAILS : " + prefs.get("details-$index?"));
  }

  removeEvent({index, time, details}) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("index-$index?");
    prefs.remove("time-$index?");
    prefs.remove("details-$index?");

//    prefs.clear();
  }

}

// My Schedule
class myScheduleWidget extends StatefulWidget
{
  @override
  _myScheduleWidgetState createState() => _myScheduleWidgetState();
}

class _myScheduleWidgetState extends State<myScheduleWidget>
{
  List<String> timing = List<String>();
  List<String> details = List<String>();
//  Map<String, String> map = Map<String, String>();

  @override
  void initState()
  {
    super.initState();

    getBookMarkedSchedule();
  }

  getBookMarkedSchedule() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(()
    {
      List<String> keys = prefs.getKeys().toList();

      var indexSplit;

      for(String k in keys)
      {
        int indexOfDash = k.indexOf("-") + 1;
        int indexOfQuestion = k.indexOf("?");

        indexSplit = k.substring(indexOfDash, indexOfQuestion);

        int indexOfDashKey = k.indexOf("-");

        var keyword = k.substring(0, indexOfDashKey);

        print("INDEX SPLIT : " + indexSplit.toString());

//        String timeVal = prefs.get("time-$indexSplit?");
//        String detailsVal = prefs.get("details-$indexSplit?");

//        map = {
//          timeVal : detailsVal
//        };

        if(keyword == "time")
        {
          timing.add(prefs.get("time-$indexSplit?"));
//          timing.sort();
        }

        if(keyword == "details")
        {
          details.add(prefs.get("details-$indexSplit?"));
        }
      }

      print("TIMING LIST : " + timing.toString());
      print("DETAILS LIST : " + details.toString());

//      print("MAP : " + map.toString());
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return (timing.length) > 0
        ?
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: ListView.builder(
              padding: EdgeInsets.only(left: 8, right: 8),
              itemCount: timing.length,
              itemBuilder: (context, index)
              {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>
                  [
                    // Time
                    Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "- " + timing[index].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      padding: EdgeInsets.all(0),
                    ),

                    // Details
                    Container(
                      height: 160,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>
                            [
                              // Text
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    details[index].toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
          ),
    )
        : Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Personalize the event schedule to make the most of it.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}


// Event Network
class EventNetwork extends StatefulWidget
{
  final String uid; // Senders Id
  final String uName;

  EventNetwork({this.uid, this.uName});

  @override
  _EventNetworkState createState() => _EventNetworkState();
}

class _EventNetworkState extends State<EventNetwork>
{
  List<GetPeopleWithSameInterestModel> peopleList = List();

  @override
  void initState()
  {
    super.initState();

    GetPeopleWithSameInterestData.getPeopleWithSameInterestData(id: widget.uid).then((people)
    {
      if(mounted)
      {
        setState(()
        {
          peopleList = people;
        });
      }
    });

  }


  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>
      [
        Expanded(
          child: FutureBuilder<List>(
            future: GetPeopleWithSameInterestData.getPeopleWithSameInterestData(id: widget.uid),
            builder: (context, ss)
            {
              if(ss.hasError)
              {
                print("ERROR :  " + ss.error.toString());
              }
              if(ss.hasData)
              {
                return ListView.builder(
                  itemCount: peopleList.length,
                  itemBuilder: (BuildContext context, int index)
                  {
                    return Padding(
                      padding: EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
                      child: PeopleWithSameInterestWidget(
                        name: peopleList[index].name.toString(),
                        email: peopleList[index].email,
                        phone: peopleList[index].phone.toString(),
                        interest: peopleList[index].interests.toString(),
                        receiversId: peopleList[index].userid.toString(),
                        sendersId: widget.uid.toString(),// Receiver's Id
                        sendersName: widget.uName.toString(),
                      ),
                    );
                  },
                );
              }
              else
              {
                return Center(
                  child: SpinKitWanderingCubes(
                    color: Colors.white,
                    size: 45,
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }
}

class PeopleWithSameInterestWidget extends StatefulWidget
{
  final String name, email, interest, phone, sendersId, receiversId, sendersName;

  PeopleWithSameInterestWidget({this.phone, this.name, this.email, this.interest, this.sendersId, this.receiversId, this.sendersName});

  @override
  _PeopleWithSameInterestWidgetState createState() => _PeopleWithSameInterestWidgetState();
}

class _PeopleWithSameInterestWidgetState extends State<PeopleWithSameInterestWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>
            [
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.7,
                ),
              ),

              Text(
                widget.email,
                style: TextStyle(
                    color: Colors.lightBlue,
                    letterSpacing: 0.7
                ),
              ),

              Text(
                widget.phone,
                style: TextStyle(
                    letterSpacing: 0.7
                ),
              ),

              Text(
                "Mutual Interests : " + widget.interest,
                style: TextStyle(
                    letterSpacing: 0.7
                ),
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    onPressed: ()
                    {
                      Navigator.push(
                          context,
                          new SlideFromRightPageRoute(
                            widget: ChatScreen(
                              receiverName: widget.name,
                              receiverId: widget.receiversId.toString(),
                              senderId: widget.sendersId.toString(),
                              senderName: widget.sendersName.toString(),
                            ),
                          )
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(
                          color: Colors.green,
                        )
                    ),
                    child: Text(
                      "Connect",
                      style: TextStyle(
                          letterSpacing: 0.7,
                          color: Colors.white
                      ),
                    ),
                    padding: EdgeInsets.all(6),
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Event Sponsors
class EventSponsors extends StatefulWidget
{
  @override
  _EventSponsorsState createState() => _EventSponsorsState();
}

class _EventSponsorsState extends State<EventSponsors>
{
  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>
        [
          InkWell(
            onTap: ()
            {
              Navigator.push(context, FadePageRoute(
                  widget: SponsorsDetails(
                    tag: "companyimage",
                    name: "TheCandido",
                  ))
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>
                [
                  Hero(
                    tag: "companyimage",
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/actual.png",
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Divider(
                    color: Colors.grey[400],
                    indent: 8,
                    endIndent: 8,
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                        "TheCandido",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Playfair",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        )
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 3, top: 3),
                    child: Text(
                        "Create your virtual event with us!",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: "Gotham",
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),

                  SizedBox(height: 5,),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>
                      [
                        Expanded(
                          child: Row(
                            children: <Widget>
                            [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 3, bottom: 3),
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.person,
                                    size: 20,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 3, bottom: 3),
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.person,
                                    size: 20,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 3, bottom: 3),
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.person,
                                    size: 20,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, top: 3, bottom: 3),
                                child: Text(
                                  "+ 5 more",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              )
                            ],
                          ),
                        ),


                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.navigate_next,
                                size: 30,
                                color: Colors.black,
                              ),
                              onPressed: ()
                              {
                                Navigator.push(context, FadePageRoute(
                                  widget: SponsorsDetails(
                                    tag: "companyimage",
                                    name: "TheCandido",
                                  ),
                                ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// User Profile
class UserProfile extends StatefulWidget
{
  final String name, id;

  UserProfile({this.name, this.id});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
{

  @override
  void initState()
  {
    super.initState();

    getUserDetails();
    print("ID : " + widget.id.toString());
  }

  var email, phone;
  static bool isLoading = false;

  List<String> its = List();

  getUserDetails() async
  {

    if(mounted)
      setState(()
      {
        isLoading = true;
      });

    var response = await http.post(ConstantUrls.GetUserDetailsUrl, body:
    {
      "verify" : "TheCandidoVirtualEvent2020",
      "id" : widget.id.toString()
    });

    print(response.body);
    var message = jsonDecode(response.body);

    if(mounted)
      setState(()
      {
        email = message["email"].toString();
        phone = message["phone"].toString();

        for(var i in message["interest"].toString().split(','))
          its.add(i.toString());

        print("ITS : " + its.toString());

        isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context)
  {
    return isLoading ? Center(
      child: SpinKitWanderingCubes(
        color: Colors.white,
        size: 45,
      ),
    ) : Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>
        [
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: (){},
              radius: 60,
              borderRadius: BorderRadius.circular(60),
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person_outline,
                  size: 75,
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),

          Expanded(
            child: Theme(
              data: ThemeData(
                highlightColor: Colors.white,
              ),
              child: Scrollbar(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>
                  [
                    // Name, Email & Phone
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>
                          [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 1.0,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                            Divider(
                              color: ConstantUrls.yellowColor,
                            ),

                            // Email & Phone
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>
                              [
                                // Email & Phone
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>
                                  [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        email,
                                        style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: 1.0,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        (phone != null) ? phone : " ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: 1.0,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                IconButton(
                                  onPressed: (){},
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue[800],
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),

                    SizedBox(height: 20,),

                    // About
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>
                          [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>
                              [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "About",
                                    style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 1.0,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue[800],
                                        ),
                                        onPressed: ()
                                        {},
                                      )
                                  ),
                                )
                              ],
                            ),

                            Divider(
                              color: ConstantUrls.yellowColor,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                enabled: false,
                                keyboardType: TextInputType.multiline,
                                maxLines: 6,
                                minLines: 1,
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  focusColor: Colors.grey,
                                  labelStyle: TextStyle(
                                    fontSize: 15.5,
                                  ),
                                  border: InputBorder.none,
                                  hintText: "About Me",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),

                    // Categories
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>
                          [
                            // Category
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>
                              [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      "Categories",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0
                                      ),
                                    ),
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue[800],
                                        ),
                                        onPressed: ()
                                        {},
                                      )
                                  ),
                                )
                              ],
                            ),

                            Divider(
                              color: ConstantUrls.yellowColor,
                            ),

                            createFilterChips(interests: its),

                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),

                    // Change Password, Account Settings
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>
                          [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Account Settings",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0
                                ),
                              ),
                            ),

                            Divider(
                              color: ConstantUrls.yellowColor,
                            ),

                            // Change Password
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                onPressed: (){},
                                splashColor: Colors.white38,
                                highlightColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                child: Text(
                                  "Change Password",
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                  ),
                                ),
                                color: Colors.green,
                              ),
                            ),

                            // Delete Account
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                              child: RaisedButton(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                onPressed: (){},
                                splashColor: Colors.white38,
                                highlightColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                child: Text(
                                  "Delete Account",
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                  ),
                                ),
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createFilterChips({List<String> interests})
  {
    List<Widget> categoryList = List<Widget>();
    List<Color> colors = List<Color>();

    colors.add(Colors.amberAccent);
    colors.add(Colors.redAccent);
    colors.add(Colors.deepOrangeAccent);
    colors.add(Colors.greenAccent[700]);
    colors.add(Colors.pinkAccent);
    colors.add(Colors.indigo);
    colors.add(Colors.purple);
    colors.add(Colors.deepPurple);
    colors.add(Colors.orange);
    colors.add(Colors.red);
    colors.add(Colors.pink);
    colors.add(Colors.pinkAccent);
    colors.add(Colors.indigo);
    colors.add(Colors.purple);

    for(int i = 0; i < interests.length; i++)
    {
//      print("LENGTH : " + interests.length.toString());
//      print("FOR LOOP : " + interests[i].toString());

      categoryList.add(
          FilterChipWidget(
            chipName: interests[i].toString(),
            selectedColor: colors[i],
            bgColor: Colors.transparent,
            textColor: Colors.blue,
            selectedTextColor: Colors.white,
          )
      );
    }

    return Wrap(
      spacing: 4,
      children: categoryList,
    );
  }
}

class FilterChipWidget extends StatefulWidget
{
  final String chipName;
  final Color bgColor;
  final Color selectedColor;
  final Color textColor;
  final Color selectedTextColor;

  FilterChipWidget({this.chipName, this.bgColor, this.selectedColor, this.textColor, this.selectedTextColor});

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget>
{
  var _isSelected = true;

  @override
  Widget build(BuildContext context)
  {
    return FilterChip(
      label: Text(
        widget.chipName,
        style: TextStyle(
            letterSpacing: 0.5,
            color: _isSelected ? widget.selectedTextColor : widget.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 15
        ),
      ),
      selected: _isSelected,
      backgroundColor: widget.bgColor,
      onSelected: (isSelected)
      {

      },
      selectedColor: widget.selectedColor,
      padding: EdgeInsets.all(6),
      elevation: 1,
      showCheckmark: false,
    );
  }
}

