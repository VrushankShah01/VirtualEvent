import 'dart:convert';
import 'package:evento/ConstantUrls.dart';
import 'package:evento/custom_route_transitions/fade_page_route.dart';
import 'package:evento/services/GetInterests.dart';
import 'package:evento/view_event_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget
{
  final String id;

  Home({this.id});

  @override
  _HomeState createState() => _HomeState();
}

/*
*  This is the home page after signing in.
*  - It shows the lists of events based on the user's selection of interests.
*  - Has the option to search for an event.
*  - Has an option to visit the profile of the user.
*  - On selecting an event the user is redirected to [view_event_details.dart].
* */
class _HomeState extends State<Home> with SingleTickerProviderStateMixin
{
  List<String> imagePaths = [
    "assets/internet.jpg",
  ];

  List<String> eventName = [
    "India Internet Day",
  ];

  List<String> date = [
    "7th August, 2020",
  ];

  List<String> location = [
    "The Leela Ambience Gurugram Hotel & Residences, Gurgaon"
  ];

  List<String> description = [
    "The India Internet Day is a place to meet the co-creators of strategic intent and stakeholder value, a place to horizon gaze the next paradigm, the spot to find the finest in business aligning objectives for broader gain and seek conversations that last beyond the short-term. India is a country of many countries and requires product managers and designers to forego standard best practices and develop new principles for a people that are coming online en masse for the first time. Participants will work on specific problem statements using the new principles they develop during the workshop and then try and apply them to the products they are working on."
  ];

  List<String> time = [
    "8:00 AM - 6:00 PM"
  ];

  List<GetInterest> list;
  List<Widget> interestChips;

  AnimationController _controller;
  Animation<Color> animationOne;
  Animation<Color> animationTwo;

  static bool loading;

  @override
  void initState()
  {
    super.initState();

    loading = true;

//    _controller = AnimationController(
//      vsync: this,
//      duration: Duration(milliseconds: 800)
//    );
//
//    animationTwo = ColorTween(
//        begin: Colors.grey[300],
//        end: Colors.white60
//    ).animate(_controller);
//
//    animationOne = ColorTween(
//        begin: Colors.white60,
//        end: Colors.grey[300]
//    ).animate(_controller);

//    _controller.forward();
//
//    _controller.addListener(()
//    {
//      if(_controller.status == AnimationStatus.completed)
//      {
//        _controller.reverse();
//      }
//      else if(_controller.status == AnimationStatus.dismissed)
//      {
//        _controller.forward();
//      }
//
//      this.setState(() { });
//    });

    interestChips = List<Widget>();

    getInterests();
  }


  @override
  void dispose()
  {
//    _controller.dispose();
    super.dispose();
    list.clear();
    interestChips.clear();
  }

  getInterests() async
  {
    var response = await http.post(ConstantUrls.GetInterestsSelectedUrl, body:
                   {
                     "verify" : "TheCandidoVirtualEvent2020",
                     "txtUserId" : widget.id,
                   });

    print("RESPONSE : " + response.body);

    var rest = json.decode(response.body);
    
    var message = rest as List;

    list = message.map<GetInterest>((json) => GetInterest.fromJson(json)).toList();

    for(int i = 0; i < list.length; i++)
    {
      interestChips.add(
          FilterInterests(interestName: list[i].interest,),
      );

      print("INTEREST : " + list[i].interest);
    }

    setState(()
    {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.location_on,
            color: Colors.white,
            size: 35,
          ),
        ),
        actions: <Widget>
        [
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Icon(
//              Icons.search,
//              color: Colors.lightBlueAccent,
//              size: 40,
//            ),
//          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue[800],
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 35,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>
            [
              // Search Event Textbox
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                     ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    ),

                  // Search Event Textbox
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: "Search for an Event",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (text)
                    {
                      print(text);
                    },
                  ),
                ),
              ),

              SizedBox(height: 10,),

              // Interests Selected
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: loading ?
                      Shimmer.fromColors(
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>
                            [
                              FilterChip(
                                label: Text(
                                  "Industry Engineering",
                                  style: TextStyle(
                                      color: Colors.transparent
                                  ),
                                ),
                              ),

                              SizedBox(width: 10,),

                              FilterChip(
                                label: Text(
                                  "Logistics & Transportation",
                                  style: TextStyle(
                                      color: Colors.transparent
                                  ),
                                ),
                              ),

                              SizedBox(width: 10,),

                              FilterChip(
                                label: Text(
                                  "Telecommunication",
                                  style: TextStyle(
                                      color: Colors.transparent
                                  ),
                                ),
                              ),

                              SizedBox(width: 10,),

                              FilterChip(
                                label: Text(
                                    "Hospitality",
                                  style: TextStyle(
                                    color: Colors.transparent
                                  ),
                                ),
                              ),

                              SizedBox(width: 10,),

                              FilterChip(
                                label: Text(
                                  "Home & Office",
                                  style: TextStyle(
                                      color: Colors.transparent
                                  ),
                                ),
                              ),

                              SizedBox(width: 10,),

                              FilterChip(
                                label: Text(
                                  "IT & Technology",
                                  style: TextStyle(
                                      color: Colors.transparent
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        baseColor: Colors.grey[200],
                        highlightColor: Colors.grey[300],
                        direction: ShimmerDirection.ltr,
                        loop: 4,
                      )
                      :
                  Container(
                    child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: interestChips,
                      ),
                    ),
                  ),
              ),

              SizedBox(height: 10,),

              // Event Card
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index)
                  {
                    return makeCard(
                      imagePath: imagePaths[index],
                      eventName: eventName[index],
                      eventDate: date[index],
                      tag: index.toString(),
                      location: location[index],
                      description: description[index],
                      time: time[index],
                      uid: widget.id,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Events Card
class makeCard extends StatelessWidget
{
  final String imagePath, eventName, eventDate, tag, location, description, time, uid;

  makeCard({this.imagePath, this.eventName, this.eventDate, this.tag, this.location, this.description, this.time, this.uid});

  @override
  Widget build(BuildContext context)
  {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>
            [
              Hero(
                tag: tag,
                child: Material(
                  child: InkWell(
                    onTap: ()
                    {
                      print("CLICKED");

                      Navigator.of(context).push(FadePageRoute
                        (widget: ViewEventDetails(
                                  tag: tag,
                                  imagePath: imagePath,
                                  title: eventName,
                                  date: eventDate,
                                  location: location,
                                  description: description,
                                  time: time,
                                  uid: uid,
                      )));
                    },
                    child: Container(
                      height: 170,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              imagePath,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>
                          [
                            Flexible(
                              child: Text(
                                eventName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),

                            Flexible(
                              child: Text(
                                eventDate,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}


// Interests Chips
class FilterInterests extends StatefulWidget
{
  final String interestName;

  FilterInterests({this.interestName});

  @override
  _FilterInterestsState createState() => _FilterInterestsState();
}

class _FilterInterestsState extends State<FilterInterests>
{
  var _isSelected = false;
  var borderColor;
  var textColor;
  var selectedColor;

  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: FilterChip(
        label: Text(
          widget.interestName,
          style: TextStyle(
            color: textColor,
            letterSpacing: 0.8,
            fontSize: 15,
          ),
        ),
        showCheckmark: false,
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
         side: BorderSide(
           color: Colors.grey[300]
         )
        ),
        padding: EdgeInsets.all(6),
        selected: _isSelected,
        selectedColor: selectedColor,
        onSelected: (isSelected)
        {
          if(isSelected == true)
          {
            setState(()
            {
              _isSelected = isSelected;
              textColor = Colors.white;
              borderColor = Colors.grey[500];
              selectedColor = Colors.grey[700];

              print("SELECTED : " + widget.interestName);
            });
          }
          else
          {
            setState(()
            {
              _isSelected = isSelected;
              textColor = Colors.black;
              borderColor = Colors.grey[300];
              selectedColor = Colors.grey[200];
            });
          }
        }
      ),
    );
  }
}


