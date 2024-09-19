
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../../../../common/loaders/loaders.dart';
import '../../../../signup/verify_email.dart';
import '../../../../utils/contsants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../user/user_model.dart';
import '../../../user/user_repository.dart';
import '../../authentication_repositries.dart';

class SignupController extends GetxController{
  static SignupController get instance => Get.find();

  ///Varibales
  final hidePassword = true.obs;//observable for hiding/showing password
  final privacyPolicy = true.obs;

  final email = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstname= TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();//Form key for the validation




  ///Signup
  Future<void> signup() async {
    try{
      // Start Loading
      TFullScreenLoader.openLoadingDialog('We are processing Your Information...', TImages.docerAnimation);
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected)return;

      //Form Validation
      if(!signupFormKey.currentState!.validate()) return;
      //privacy Policy Check
      if(!privacyPolicy.value){
        TLoaders.warningSnackBar(title: 'Accept Privacy Policy',
            message: 'In order to create account ,you must have to read and accept the Privacy Policy & Terms of use.',);
        return;
      }

      // Register user in the Firebase Authentication and save user data in the firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());


      //save authenticated user data in the Firebase firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstname.text.trim(),
        lastName:lastname.text.trim(),
        username:username.text.trim(),
        email:email.text.trim(),
        phoneNumber:phoneNumber.text.trim(),
        profilePicture:'',
      );

      final userRepository = Get.put(UserRepository());
     await userRepository.saveUserRecord(newUser);
     //Remove Loader
      TFullScreenLoader.stopLoading();


      //show success msg
      TLoaders.successSnackBar(title: 'Congratulations',message: 'Your Account has been Created ! Verify email to continue');
      //move to verify email screen
      Get.to(()=> VerifyEmailScreen(email: email.text.trim(),));


    } catch(e){
      // Remove Loader
      TFullScreenLoader.stopLoading();
      //Show some generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());

    }

  }

}