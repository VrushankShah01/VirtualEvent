import 'package:evento/model/user.dart';
import 'package:evento/resources/firebase_methods.dart';
import 'package:evento/resources/firebase_repository.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier
{
  User _user;
  FirebaseMethods methods = FirebaseMethods();

  User get getUser => _user;

  void refreshUser(userId) async
  {
    User user = await methods.getUserDetails(userId: userId);

    _user = user;

    notifyListeners();
  }
}