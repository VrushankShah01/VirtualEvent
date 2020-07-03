import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:evento/getting_started.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

/*
*   This is the profile page of the user which has options to
*   - Update Profile
*   - Change Password
*   - Update Categories
* */

class ProfileScreen extends StatefulWidget
{

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
{
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState()
  {
    super.initState();

    _pageController = PageController();
  }


  @override
  void dispose()
  {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index)
          {
            setState(()
            {
              _currentIndex = index;
            });
          },
          children: <Widget>
          [
            Container(color: Colors.amber, child: Text(
              "abc",
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 1.0,
                fontSize: 20,
              ),
            ),),
            Container(color: Colors.red,),
            Container(color: Colors.green,),
            Container(color: Colors.blue,),
            Container(color: Colors.deepPurple,)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        items: [
          BottomNavyBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            activeColor: Colors.amber,
            inactiveColor: Colors.grey
          ),

          BottomNavyBarItem(
              icon: Icon(
                Icons.group_add,
                size: 30,
              ),
              title: Text(
                "People",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              activeColor: Colors.redAccent,
              inactiveColor: Colors.grey
          ),

          BottomNavyBarItem(
              icon: Icon(
                Icons.calendar_today,
                size: 30,
              ),
              title: Text(
                "Schedule",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              activeColor: Colors.green,
              inactiveColor: Colors.grey
          ),

          BottomNavyBarItem(
              icon: Icon(
                Icons.live_tv,
                size: 30,
              ),
              title: Text(
                "Live",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              activeColor: Colors.blue,
              inactiveColor: Colors.grey
          ),

          BottomNavyBarItem(
              icon: Icon(
                Icons.more_horiz,
                size: 30,
              ),
              title: Text(
                "More",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              activeColor: Colors.purple,
              inactiveColor: Colors.grey
          )
        ],
        selectedIndex: _currentIndex,
        onItemSelected: (index)
        {
          setState(()
          {
            _currentIndex = index;
            _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease)
;          });
          print("INDEX" + index.toString());
        },
      ),
    );
  }
}
