import 'package:evento/resources/firebase_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository
{
  FirebaseMethods firebaseMethods = FirebaseMethods();


  Future<FirebaseUser> getCurrentUser() => firebaseMethods.getCurrentUser();
}