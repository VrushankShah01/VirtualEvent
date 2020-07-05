import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evento/model/call.dart';
import 'package:evento/resources/call_methods.dart';
import 'package:evento/video_call_screens/pickup/pickup_screen.dart';
import 'package:evento/video_call_screens/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class PickupLayout extends StatelessWidget
{
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();

  PickupLayout({this.scaffold});

  @override
  Widget build(BuildContext context)
  {

    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return (userProvider != null && userProvider.getUser != null)
            ? StreamBuilder<DocumentSnapshot>(
      stream: callMethods.callStream(
          uid: userProvider.getUser.uid
      ),
      builder: (context, snapshot)
      {
        if(snapshot.hasData && snapshot.data.data != null)
        {
          Call call = Call.fromMap(snapshot.data.data);

          if(!call.hasDialled)
          {
            return PickupScreen(call: call,);
          }

          return scaffold;
        }

        return scaffold;
      },
    )
    : Scaffold(
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.blue,
          size: 30,
        ),
      ),
    );
  }
}
