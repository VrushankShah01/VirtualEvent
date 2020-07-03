import 'package:evento/ConstantUrls.dart';
import 'package:evento/custom_route_transitions/fade_page_route.dart';
import 'package:evento/view_detailed_event_page.dart';
import 'package:flutter/material.dart';

class ViewEventDetails extends StatefulWidget
{
  final String tag, imagePath, title, date, location, description, time, uid;

  ViewEventDetails({this.tag, this.imagePath, this.title, this.date, this.location, this.description, this.time, this.uid});

  @override
  _ViewEventDetailsState createState() => _ViewEventDetailsState();
}

class _ViewEventDetailsState extends State<ViewEventDetails>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>
            [
              // Cover Image
              Hero(
                tag: widget.tag,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        widget.imagePath,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15,),

              Flexible(
                flex: 15,
                child: ListView(
                  children: <Widget>
                  [
                    // Title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        widget.title,
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
                              widget.date,
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
                              widget.time,
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
                              widget.location,
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
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          color: Colors.grey[850],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Rs. 700",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: RaisedButton(
                        onPressed: ()
                        {
                          Navigator.of(context).push(FadePageRoute
                            (widget: ViewDetailedEventPage(
                            tag: widget.tag,
                            imagePath: widget.imagePath,
                            title: widget.title,
                            date: widget.date,
                            location: widget.location,
                            description: widget.description,
                            time: widget.time,
                            uid: widget.uid,
                          )));
                        },
                        padding: EdgeInsets.all(9),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            letterSpacing: 1.0,
                          ),
                        ),
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
