import 'dart:math';

import 'package:evento/custom_route_transitions/slide_from_right.dart';
import 'package:evento/model/call.dart';
import 'package:evento/resources/call_methods.dart';
import 'package:evento/video_call_screens/call_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallUtils
{
  static final CallMethods callMethods = CallMethods();

  static dial({senderId, senderName, receiverId, receiverName, context}) async
  {
    Call call = Call(
      callerId: senderId,
      callerName: senderName,
      receiverId: receiverId,
      receiverName: receiverName,
      channelId: Random().nextInt(1000).toString(),
      receiverPic: "",
      callerPic: ""
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if(callMade)
    {
      Navigator.push(
        context,
        SlideFromRightPageRoute(
          widget: CallScreen(call: call,)
        )
      );
    }
  }
}