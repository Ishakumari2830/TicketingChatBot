// import 'package:e_comrc/data/repositories/user/user_repository.dart';
// import 'package:e_comrc/features/authentication/screens/login/login.dart';
// import 'package:e_comrc/features/authentication/screens/onboarding/onboarding.dart';
// import 'package:e_comrc/features/authentication/screens/signup/verify_email.dart';
// import 'package:e_comrc/navigationMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_ticketing/home.dart';
import 'package:online_ticketing/signup/signup.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/plaform_exceptions.dart';
import '../../login/login.dart';
import '../../signup/verify_email.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///Varibales
  final deviceStorage = GetStorage(); //getx storage variable
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  ///Called form main.dart on app launch
  @override
  void onReady() { //by clicking ctrl + o and search oninit() and press enter
    FlutterNativeSplash.remove();// if it will not called then splashscreen will be visible only for infinte time
    screenRedirect();
  }

  ///function to show relevant button
  screenRedirect() async{
    final user = _auth.currentUser;
    if(user != null){
      if(user.emailVerified){
        Get.offAll(()=> HomePageScreen());
      } else {
        Get.offAll(()=> VerifyEmailScreen(email: _auth.currentUser?.email,));
      }
    }
    else
      {
        //Local Storage
        deviceStorage.writeIfNull('IsFirstTime', true);
        deviceStorage.read('IsFirstTime') != true
            ? Get.offAll(() => const LoginScreen())
            : Get.offAll(LoginScreen());
      }


  }

  /*---------Email & Password sign-in ---------*/
/// EmailAuthentication -Login
  Future<UserCredential> loginWithEmailAndPassword(String email,String Password) async {
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: Password);
    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went Wrong ,Please try again';
    }


  }

/// EmailAuthentication - Register
  Future<UserCredential> registerWithEmailAndPassword(String email,String Password) async {
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: Password);
    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went Wrong ,Please try again';
    }


  }

/// EmailVerification - Mail Verification
Future<void> sendEmailVerification() async{
  try{
    await _auth.currentUser?.sendEmailVerification();
  } on FirebaseAuthException catch (e){
    throw TFirebaseAuthException(e.code).message;
  } on FirebaseException catch (e){
    throw TFirebaseException(e.code).message;
  } on FormatException catch (_){
    throw TFormatException();
  } on PlatformException catch (e){
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw ' Something went Wrong ,Please try again';
  }

}

/// ReAuthenticate - ReAuthenticate user
/// Email Authentication - Forget Password
  Future<void> sendPasswordResetEmail(String email) async{
    try{
     await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went Wrong ,Please try again';
    }

  }

/// Google Authentication
  Future<UserCredential?> signInWithGoogle() async{
    try{
     //trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      //create a new credentials
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
      );

      //Once Signed iN ,return the user credential
      return await _auth.signInWithCredential(credentials);

    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e) {
      if(kDebugMode)print('Something went wrong: $e');
      return null;
    }
  }

/// facebook Authentication
/// Logout user - Valid for any authentication
  Future<void> logout() async{
    try{
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(()=> LoginScreen());
    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went Wrong ,Please try again';
    }
  }
/// Re Authenticate user
  Future<void> reAuthenticationWithEmailAndPassword(String email,String password) async{
    try{
      //create credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      //Reauthentication
      await _auth.currentUser!.reauthenticateWithCredential(credential);

    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went Wrong ,Please try again';
    }
  }

//
  Future<void> deleteAccount() async{
    try{
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went Wrong ,Please try again';
    }
  }

}