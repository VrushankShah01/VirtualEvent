import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evento/model/message.dart';
import 'package:evento/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseMethods
{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore firestore = Firestore.instance;

  static final CollectionReference _userCollection = firestore.collection("users");

  User user = User();

  Future<FirebaseUser> getCurrentUser() async
  {
    FirebaseUser currentUser;

    currentUser = await _auth.currentUser();

    return currentUser;
  }

  Future<void> addDataToDb(name, email, id, photo, username) async
  {
    user = User(
      name: name,
      email: email,
      uid: id.toString(),
      profilePhoto: photo,
      username: username
    );

    firestore.collection("users").document(id).setData(user.toMap(user));
  }

  Future<void> addMessageToDb({Message message, sender, receiver}) async
  {
    var map = message.toMap();

    await firestore
        .collection('messages')
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    return await firestore
        .collection("messages")
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  Future<User> getUserDetails({userId}) async
  {
//    FirebaseUser currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot = await _userCollection.document(userId).get();

    return User.fromMap(documentSnapshot.data);
  }

}