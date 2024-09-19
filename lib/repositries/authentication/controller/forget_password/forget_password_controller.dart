
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/loaders/loaders.dart';
import '../../../../password_configuration/reset password.dart';
import '../../../../utils/contsants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../authentication_repositries.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  ///variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  ///send reset password email
  sendPasswordResetEmail() async{
    try{
      //start loading
      TFullScreenLoader.openLoadingDialog('Processing your request', TImages.docerAnimation);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if(!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success screen
      TLoaders.successSnackBar(title: 'Email sent',message: 'Email link sent to reset your password'.tr);

      //redirect
      Get.to(() => ResetPassword(email : email.text.trim()));

    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'oh snap',message: e.toString());

    }
  }

  resendPasswordResetEmail(String email) async{
    try{
      //start loading
      TFullScreenLoader.openLoadingDialog('Processing your request', TImages.docerAnimation);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }


      //send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success screen
      TLoaders.successSnackBar(title: 'Email sent',message: 'Email link sent to reset your password'.tr);




    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'oh snap',message: e.toString());

    }
  }
}