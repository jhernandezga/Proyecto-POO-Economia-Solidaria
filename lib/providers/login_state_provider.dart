import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/models/user.dart';
import 'package:proyecto_poo/providers/database_provider.dart';

class LoginState with ChangeNotifier{

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loading = false;

  Stream<User> get user{
    return this._auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future logout() async{

    try {
      /*if(_googleSignIn != null)
      {
        _googleSignIn.signOut();
      }*/
      if(_googleSignIn != null)
      {
        return await _auth.signOut();
      }
      else{
        return null;
      }
      
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future login() async {

    this._loading = true;
    notifyListeners();

    this._loading = false;
    notifyListeners();
    return user;
  }


  bool get isLoading{
    return this._loading;
  }

 


  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user!=null?User(uid: user.uid, name: user.displayName,
                        email: user.email, phoneNumber: user.phoneNumber,
                        photoUrl: user.photoUrl):null;
    
  }





  Future<User> _handleSignIn() async {
      
  try
  {
     final GoogleSignInAccount googleUser       = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential             = GoogleAuthProvider.getCredential(
    accessToken                                 : googleAuth.accessToken,
    idToken                                     : googleAuth.idToken,
  );
    FirebaseUser  user            = (await _auth.signInWithCredential(credential)).user;
    
    print("signed in " + user.displayName);
    return _userFromFirebaseUser(user);

  }
  catch(PlatformException )
  {
    return null;

  }
  catch(e)
  {
    return null;
    
  }  
}

  Future<User> registerWithEmailAndPassword(String email, String password, String userName) async{
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      UserUpdateInfo info = new  UserUpdateInfo();
      info.displayName = userName;
      user.updateProfile(info);
      if(user!=null)
      {
        await DatabaseService(uid: user.uid).createUser(email: email,name: userName );
      }
      
      return _userFromFirebaseUser(user);
      
    } catch (e) {
      print(e.toString());
      return null;
    }
    
  }

  Future<User> singInWithEmailAndPassword(String email, String password) async{
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      print("nameUser "+user.displayName);
      return _userFromFirebaseUser(user);
      
    } catch (e) {
      print(e.toString());
      return null;
    }
    
  }
}