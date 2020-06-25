// Success Popup
import 'package:flutter/material.dart';

class SuccessPopup extends StatefulWidget
{
  final bool isSuccessfull;
  final String message;
  final String title;

  SuccessPopup({this.isSuccessfull, this.message, this.title});

  @override
  _SuccessPopupState createState() => _SuccessPopupState();
}

class _SuccessPopupState extends State<SuccessPopup>
{
  bool _isSuccessfull;
  String _message = " ";
  String _title = " ";

  @override
  void initState()
  {
    _isSuccessfull = widget.isSuccessfull;
    _message = widget.message;
    _title = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: () {},
      child: AlertDialog(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Text(
              _title,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Merriweather-Regular",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                fontSize: 17,
              ),
            ),
          ),
          elevation: 15,
          content: _isSuccessfull ?
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                  Flexible(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Icon(
                        Icons.done,
                        size: 28,
                        color: Colors.greenAccent[400],
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Text(
                      _message,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.9,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather-Regular",
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              RaisedButton(
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Merriweather-Regular",
                    fontSize: 15,
                    letterSpacing: 0.9,
                  ),
                ),
                color: Colors.blueAccent[400],
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          ) :
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                [
                  Flexible(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Icon(
                        Icons.clear,
                        size: 28,
                        color: Colors.redAccent[400],
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Text(
                      _message,
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.9,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather-Regular",
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              RaisedButton(
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Merriweather-Regular",
                    fontSize: 15,
                    letterSpacing: 0.9,
                  ),
                ),
                color: Colors.blueAccent[400],
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          )
      ),
    );
  }
}