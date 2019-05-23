import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class UserModel extends Model{

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  Map<String,dynamic> userData = Map();

  bool isLoading = false;

  void signUp({@required Map<String,dynamic> userData, @required String pass, @required VoidCallback onSucess, @required VoidCallback onFailed}){
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass).then((user) async{
          firebaseUser = user;
          await _saveUserData(userData);
          onSucess();
          isLoading=false;
          notifyListeners();
    }).catchError((e){
      onFailed();
      isLoading = false;
      notifyListeners();
    });

  }
  void signIn({@required String email, @required String pass, @required VoidCallback onSucess, @required VoidCallback onFailed})async{

    isLoading = true;
    notifyListeners();
    _auth.signInWithEmailAndPassword(email: email, password: pass).then(
            (user){
              firebaseUser = user;
              onSucess();
              isLoading=false;
              notifyListeners();
    }).catchError(
            (e){
          onFailed();
          isLoading=false;
          notifyListeners();
    });


  }

  void signOut() async{
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void recoverPass(){

  }
  bool isLogged(){
    return firebaseUser != null;
  }
  Future<Null> _saveUserData(Map<String,dynamic> userData)async{
      this.userData = userData;
      await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }
}