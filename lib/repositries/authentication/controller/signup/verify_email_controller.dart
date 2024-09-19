import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/loaders/loaders.dart';
import '../../../../common/success_screen/sucess_screen.dart';

import '../../../../utils/contsants/image_strings.dart';
import '../../../../utils/contsants/text_strings.dart';
import '../../authentication_repositries.dart';

class VerifyEmailController extends GetxController{
  static VerifyEmailController get instance => Get.find();

  ///Send email whenever verify screen appears and set timer for auto redirect
  @override
  void onInit(){
    sendEmailVerification();
    setTimerForAutoRedirect();
    checkEmailVerificationStatus();

    super.onInit();
  }

  ///Send Email Verification Link
  sendEmailVerification() async{
    try{
     await AuthenticationRepository.instance.sendEmailVerification();
     TLoaders.successSnackBar(title: 'Email Sent',message: 'Please check your inbox and verify your email');

    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }
    }

///Timer to automatically redirect on email
 setTimerForAutoRedirect(){
    Timer.periodic(const Duration(seconds: 1),(timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user ?.emailVerified ?? false){
        timer.cancel();
        Get.off(()=> SucessScreen(
          image: TImages.successfullyRegisterAnimation,

          title: TTexts.yourAccountCreatedTitle,
          subtitle:TTexts.yourAccountCreatedSubtitle ,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ));
      }
    });
 }
///Manually check if email is verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(()=> SucessScreen(
        image: TImages.successfullyRegisterAnimation,

        title: TTexts.yourAccountCreatedTitle,
        subtitle:TTexts.yourAccountCreatedSubtitle ,
        onPressed: () => AuthenticationRepository.instance.screenRedirect(),
      ));

    }
  }
}