
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../common/loaders/loaders.dart';
import '../../../../utils/contsants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../authentication_repositries.dart';
import '../user_controller.dart';

class LoginController extends GetxController {

  ///variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());


  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ??'';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ??'';
    super.onInit();
  }

  /// Email and password sigiN
  Future<void> emailAndPasswordSignIn() async {
    try {
      //start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in', TImages.docerAnimation);
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      //Login User using email and password authentication
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch(e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }

  /// ---Google SignIn Authentication
  Future<void> googleSignIn() async{
    try{
      //start Loading
      TFullScreenLoader.openLoadingDialog('Logging You in...', TImages.docerAnimation);

      //Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      //Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      //save user Record
      await userController.saveUserRecord(userCredentials);

      //remove Loader
      TFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();




    }catch(e){
      //remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'oh snap',message: e.toString());
    }
  }

}