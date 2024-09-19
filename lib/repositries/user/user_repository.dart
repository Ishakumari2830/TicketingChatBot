import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_ticketing/repositries/user/user_model.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/plaform_exceptions.dart';
import '../authentication/authentication_repositries.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

 ///function to save userdata to firestore
  Future<void> saveUserRecord(UserModel user)async {
    try{
       await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_){
      throw TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went Wrong ,Please try again';
    }

  }



  /// function to fetch user details based on used id
  Future<UserModel> fetchUserdetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went Wrong ,Please try again';
    }
  }

  ///  fuction to update user data in firestore
  Future<void> updateUserDetails(UserModel updatedUser)async {
    try{
      await _db.collection('Users').doc(updatedUser.id).update(updatedUser.toJson());
    } on FirebaseException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_){
      throw TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went Wrong ,Please try again';
    }

  }
  ///  update any field in specific users collection
  Future<void> updateSingleField(Map<String,dynamic> json) async {
    try{
      await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    } on FirebaseException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_){
      throw TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went Wrong ,Please try again';
    }

  }
///  function to remove user data from firestore
  Future<void> removeUserRecord(String userid) async {
    try{
      await _db.collection('Users').doc(userid).delete();
    } on FirebaseException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_){
      throw TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went Wrong ,Please try again';
    }

  }
///  upload any image
Future<String> uploadImage(String path,XFile image) async {
  try {
    final ref =FirebaseStorage.instance.ref(path).child(image.name);
    await ref.putFile(File(image.path));
    final url = await ref.getDownloadURL();
    return url;

  } on FirebaseException catch (e) {
    throw TFirebaseAuthException(e.code).message;
  } on FormatException catch (_) {
    throw TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw ' Something went Wrong ,Please try again';
  }
}

}