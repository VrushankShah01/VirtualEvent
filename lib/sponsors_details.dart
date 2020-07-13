import 'package:evento/custom_icons/browser_icons.dart';
import 'package:evento/custom_icons/facebook_icons.dart';
import 'package:evento/custom_icons/linked_in_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorsDetails extends StatefulWidget
{
  final String tag, name;

  SponsorsDetails({this.tag, this.name});

  @override
  _SponsorsDetailsState createState() => _SponsorsDetailsState();
}

class _SponsorsDetailsState extends State<SponsorsDetails>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.name,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>
            [
              Expanded(
                child: Theme(
                  data: ThemeData(
                    highlightColor: Colors.blue[800],
                  ),
                  child: Scrollbar(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: <Widget>
                      [
                        Hero(
                          tag: widget.tag,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Image.asset(
                              "assets/actual.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "TheCandido",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                letterSpacing: 1,
                                fontFamily: "Playfair",
                                fontWeight: FontWeight.w600
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

                        SizedBox(height: 10,),

                        Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>
                              [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                                  child: Text(
                                      "Meet the people",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          letterSpacing: 0.5,
                                          fontFamily: "Gotham",
                                      )
                                  ),
                                ),

                                Row(
                                  children: <Widget>
                                  [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 3, bottom: 3),
                                      child: CircleAvatar(
                                        radius: 16,
                                        child: Icon(
                                          Icons.person,
                                          size: 18,
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 3, bottom: 3),
                                      child: CircleAvatar(
                                        radius: 16,
                                        child: Icon(
                                          Icons.person,
                                          size: 18,
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 3, bottom: 3),
                                      child: CircleAvatar(
                                        radius: 16,
                                        child: Icon(
                                          Icons.person,
                                          size: 18,
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
                                    ),

                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.navigate_next,
                                            size: 25,
                                            color: Colors.black,
                                          ),
                                          onPressed: ()
                                          {

                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Everyone loves capturing a moment. Good, bad, spontaneous and fun! In 2017, modern-day photo booths becoming increasingly popular at events and brand activation's, we saw the potential for something beyond just a picture.\n\nTheCandido was born out of the eagerness to create innovative visual marketing solutions that give brands a social and engaging way to interact with consumers. It is tried and tested, people connect more with brands when they form a brand image in their head. Our product does not only help in creating the right first impression but also build loyalty in form of a memory with a forever digital footprint. It gives the brand not just one impression but consumer insight and consistent presence. And that’s why data collection and in-depth analytics are at the heart of everything we do.\n\nOur vision has lead us to create CANDIDO, our showpiece which is going to help you to grab attention.",
                            style: TextStyle(
                              letterSpacing: 0,
                              fontSize: 15,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontFamily: "Gotham",
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>
                            [
                              // Facebook
                              InkWell(
                                child: Icon(
                                    Facebook.facebook_squared,
                                    color: Colors.blue[700],
                                    size: 25,
                                  ),
                                onTap: () async
                                {
                                  String url = "https://www.facebook.com/TheCandidoIndia";

                                  if (await canLaunch(url))
                                  {
                                    await launch(url);
                                  }
                                  else
                                  {
                                    print("Error");
                                  }
                                },
                              ),

                              SizedBox(width: 10,),

                              // LinkedIn
                              InkWell(
                                child: Icon(
                                  LinkedIn.linkedin_squared,
                                  color: Colors.blue,
                                  size: 25,
                                ),
                                onTap: () async
                                {
                                  String url = "https://www.linkedin.com/company/thecandido/";

                                  if (await canLaunch(url))
                                  {
                                    await launch(url);
                                  }
                                  else
                                  {
                                    print("Error");
                                  }
                                },
                              ),

                              // Website
//                              IconButton(
//                                icon: Icon(
//                                  Browser.globe,
//                                  color: Colors.blue,
//                                  size: 24,
//                                ),
//                                onPressed: () async
//                                {
//                                  String url = "https://www.thecandido.com";
//
//                                  if (await canLaunch(url))
//                                  {
//                                    await launch(url);
//                                  }
//                                  else
//                                  {
//                                    print("Error");
//                                  }
//                                },
//                              ),

                              Expanded(
                                child: InkWell(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "https://thecandido.com",
                                      style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 14,
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Gotham"
                                      ),
                                    ),
                                  ),
                                  onTap: () async
                                  {
                                    String url = "https://www.thecandido.com";

                                    if (await canLaunch(url))
                                    {
                                      await launch(url);
                                    }
                                    else
                                    {
                                      print("Error");
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 20,
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
