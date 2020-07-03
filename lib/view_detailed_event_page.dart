import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:evento/ConstantUrls.dart';
import 'package:evento/custom_icons/shake_hand_icons.dart';
import 'package:evento/home.dart';
import 'package:evento/services/GetPeopleWithSameInterestData.dart';
import 'package:evento/services/GetPeopleWithSameInterestModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ViewDetailedEventPage extends StatefulWidget
{
  final String tag, imagePath, title, date, location, description, time, uid;

  ViewDetailedEventPage({this.tag, this.imagePath, this.title, this.date, this.location, this.description, this.time, this.uid});

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
      )
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
        initialActiveIndex: 0,
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

          Expanded(
            child: ListView(
              children: <Widget>
              [
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
  @override
  Widget build(BuildContext context)
  {
    return Container();
  }
}

// Event Network
class EventNetwork extends StatefulWidget
{
  final String uid;

  EventNetwork({this.uid});

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
                        name: peopleList[index].name,
                        email: peopleList[index].email,
                        phone: peopleList[index].phone.toString(),
                        interest: peopleList[index].interests.toString(),
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
                    size: 65,
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
  final String name, email, interest, phone;

  PeopleWithSameInterestWidget({this.phone, this.name, this.email, this.interest});

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
                  fontSize: 18,
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
                "Common Interests : " + widget.interest,
                style: TextStyle(
                  letterSpacing: 0.7
                ),
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    onPressed: ()
                    {},
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



