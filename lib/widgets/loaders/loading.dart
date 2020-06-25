import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Center(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Center(
          child: Container(
            height: 250,
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>
              [
                SpinKitWanderingCubes(
                  color: Colors.blue,
                  size: 65,
                ),

                SizedBox(height: 10,),

                Text(
                  "Loading...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}