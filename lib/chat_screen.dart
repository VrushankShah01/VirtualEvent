import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:evento/ConstantUrls.dart';
import 'package:evento/model/message.dart';
import 'package:evento/resources/firebase_methods.dart';
import 'package:evento/video_call_screens/call_utilities.dart';
import 'package:evento/video_call_screens/permissions.dart';
import 'package:evento/video_call_screens/pickup/pickup_layout.dart';
import 'package:evento/video_call_screens/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget
{
  final String receiverName, receiverId, senderId, senderName;

  ChatScreen({this.receiverName, this.receiverId, this.senderId, this.senderName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
{
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _listScrollController = ScrollController();
  FocusNode textFieldFocus = FocusNode();

  bool isWriting = false;
  bool showEmojiPicker = false;

  @override
  void initState()
  {
    super.initState();

    _textEditingController = TextEditingController();
    _listScrollController = ScrollController();
    textFieldFocus = FocusNode();

    print("SENDER NAME " + widget.senderName);
  }

  @override
  void dispose()
  {
    _textEditingController.dispose();
    _listScrollController.dispose();
    textFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: ConstantUrls.blueColor,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            centerTitle: false,
            title: Text(
              widget.receiverName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.7
              ),
            ),
            actions: <Widget>
            [
              IconButton(
                icon: Icon(
                  Icons.videocam,
                  size: 25,
                ),
                onPressed: () async
                {
                  await Permissions.cameraAndMicrophonePermissionsGranted() ?
                  CallUtils.dial(
                    senderId: widget.senderId,
                    senderName: widget.senderName,
                    receiverId: widget.receiverId,
                    receiverName: widget.receiverName,
                    context: context
                  ) :
                  {};
                },
              ),

              IconButton(
                icon: Icon(
                  Icons.phone,
                  size: 25,
                ),
                onPressed: () {

                },
              ),


            ],
          ),
          body: Column(
            children: <Widget>
            [
              Flexible(
                child: messageList(),
              ),

              chatControls(),

              showEmojiPicker
                  ? Container(
                      child: emojiContainer(),
                    )
                  : Container()
            ],
          ),
      ),
    );
  }

  showKeyboard() => textFieldFocus.requestFocus();

  hideKeyboard() => textFieldFocus.unfocus();

  hideEmojiContainer()
  {
    setState(()
    {
      showEmojiPicker = false;
    });
  }

  showEmojiContainer()
  {
    setState(()
    {
      showEmojiPicker = true;
    });
  }

  // Emoji
  emojiContainer()
  {
    return EmojiPicker(
      bgColor: Colors.white,
      indicatorColor: ConstantUrls.blueColor,
      rows: 4,
      columns: 7,
      onEmojiSelected: (emoji, category)
      {
        setState(()
        {
          isWriting = true;
        });

        _textEditingController.text = _textEditingController.text + emoji.emoji;
      },
    );
  }

  // View Messages
  Widget messageList() {
    return StreamBuilder(
      stream: Firestore
          .instance
          .collection("messages")
          .document(widget.senderId)
          .collection(widget.receiverId)
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: SpinKitWanderingCubes(
              color: Colors.white,
              size: 20,
            ),
          );
        }

//        SchedulerBinding.instance.addPostFrameCallback((_)
//        {
//          _listScrollController.animateTo(
//              _listScrollController.position.minScrollExtent,
//              duration: Duration(milliseconds: 250),
//              curve: Curves.easeInOut,
//          );
//        });

        return ListView.builder(
          reverse: true,
          padding: EdgeInsets.all(10),
          controller: _listScrollController,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            return chatMessageItem(snapshot.data.documents[index]);
          },
        );
      },
    );
  }

  // Messages
  Widget chatMessageItem(DocumentSnapshot snapshot)
  {
    Message message = Message.fromMap(snapshot.data);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: message.senderId == widget.senderId
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: message.senderId == widget.senderId
            ? senderLayout(message)
            : receiverLayout(message),
      ),
    );
  }

  // Sender Messages
  Widget senderLayout(Message message) {
    Radius messageRadius = Radius.circular(10);

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(top: 12),
        constraints: BoxConstraints(
            maxWidth: MediaQuery
                .of(context)
                .size
                .width * 0.65
        ),
        decoration: BoxDecoration(
            color: ConstantUrls.blueColor,
            borderRadius: BorderRadius.only(
              topLeft: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            )
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: getMessage(message),
        ),
      ),
    );
  }

  // Retrieve Messages in Text Widget
  getMessage(Message message)
  {
    return Text(
      message.message,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }

  Widget receiverLayout(Message message)
  {
    Radius messageRadius = Radius.circular(10);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 12),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65
        ),
        decoration: BoxDecoration(
            color: ConstantUrls.yellowColor,
            borderRadius: BorderRadius.only(
              bottomRight: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            )
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: getMessage(message)
        ),
      ),
    );
  }

  Widget chatControls()
  {
    setWritingTo(bool val)
    {
      setState(()
      {
          isWriting = val;
      });
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>
        [
//          Container(
//            padding: EdgeInsets.all(5),
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color: Colors.blue,
//            ),
//            child: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//          ),

//          SizedBox(width: 5,),

          Expanded(
            child: Stack(
              children:
              [
                TextField(
                controller: _textEditingController,
                focusNode: textFieldFocus,
                onTap: () => hideEmojiContainer(),
                style: TextStyle(
                  color: Colors.black,

                ),
                onChanged: (val)
                {
                  (val.length > 0 && val.trim() != "")
                      ? setWritingTo(true)
                      : setWritingTo(false);
                },
                decoration: InputDecoration(
                  hintText: "Type a message",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    borderSide: BorderSide.none
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),

                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      Icons.tag_faces
                    ),
                    onPressed: ()
                    {
                      if(!showEmojiPicker)
                      {
                        // Keyboard is Visible
                        hideKeyboard();
                        showEmojiContainer();
                      }
                      else
                      {
                        // Keyboard is hidden
                        showKeyboard();
                        hideEmojiContainer();
                      }
                    },
                  ),
                )
            ],
            ),
          ),

          isWriting ? Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: ConstantUrls.blueColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.send,
                size: 15,
                color: Colors.white,
              ),
              onPressed: ()
              {
                sendMessage();
              },
            ),
          ):
              Container()
        ],
      ),
    );
  }

  sendMessage()
  {
    var text = _textEditingController.text;

    Message message = Message(
      senderId: widget.senderId,
      receiverId: widget.receiverId,
      message: text,
      timestamp: Timestamp.now(),
      type: "text",
    );

    setState(()
    {
      isWriting = false;
    });

    _textEditingController.text = "";

    FirebaseMethods methods = FirebaseMethods();

    methods.addMessageToDb(
        message: message,
        sender: widget.senderId.toString(),
        receiver: widget.receiverId.toString()
    );
  }
}
