import 'package:evento/model/call.dart';
import 'package:evento/resources/call_methods.dart';
import 'package:evento/video_call_screens/call_screen.dart';
import 'package:evento/video_call_screens/permissions.dart';
import 'package:flutter/material.dart';

class PickupScreen extends StatelessWidget
{
  final Call call;
  final CallMethods callMethods = CallMethods();

  PickupScreen({ @required this.call});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>
          [
            Text(
              "Incoming Call",
              style: TextStyle(
                fontSize: 30
              ),
            ),

            SizedBox(height: 50,),

            Text(
              call.callerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),

            SizedBox(height: 70,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>
              [
                IconButton(
                  icon: Icon(
                    Icons.call_end,
                    size: 35,
                  ),
                  color: Colors.redAccent,
                  onPressed: () async
                  {
                    await callMethods.endCall(call: call);
                  },
                ),

                SizedBox(width: 40,),

                IconButton(
                  icon: Icon(
                    Icons.call,
                    size: 35,
                  ),
                  color: Colors.green,
                  onPressed: () async
                  {
                    await Permissions.cameraAndMicrophonePermissionsGranted() ?
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CallScreen(call:call)
                        )
                    ) : {};
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
