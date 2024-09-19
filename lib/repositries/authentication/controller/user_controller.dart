
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/loaders/loaders.dart';

import '../../../login/login.dart';
import '../../../login/widgets/login_signup/re_authenticate_user_login_form.dart';
import '../../../utils/contsants/image_strings.dart';
import '../../../utils/contsants/sizes.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../user/user_model.dart';
import '../../user/user_repository.dart';
import '../authentication_repositries.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel
      .empty()
      .obs;
  final userRepository = Get.put(UserRepository());
  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormkey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  ///Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserdetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }


  ///save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      //first update rx user and then check if user data is already stored.if not then store data
     await  fetchUserRecord();

     //if no record already stored
     if(user.value.id.isEmpty) {
       if (userCredentials != null) {
         //convert Name to first and last name
         final nameParts = UserModel.nameParts(
             userCredentials.user!.displayName ?? '');
         final username = UserModel.generateUsername(
             userCredentials.user!.displayName ?? '');

         //map data
         final user = UserModel(
           id: userCredentials.user!.uid,
           firstName: nameParts[0],
           lastName: nameParts.length > 1
               ? nameParts.sublist(1).join(' ')
               : ' ',
           username: username,
           email: userCredentials.user!.email ?? '',
           phoneNumber: userCredentials.user!.phoneNumber ?? '',
           profilePicture: userCredentials.user!.photoURL ?? '',
         );


         // save user Data
         await userRepository.saveUserRecord(user);
       }
     }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Data Not Saved',
          message:
          'Something went wrong while storing your information.You can re-save your data in profile');
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: EdgeInsets.all(TSizes.md),
        title: 'Delete Account',
        middleText: 'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently',
        confirm: ElevatedButton(onPressed: () async => deleteUserAccount(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, side: BorderSide(color: Colors.red),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
              child: Text('Delete'),
            )),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: Text('Cancel'))
    );
  }

  ///Delete user Account
  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      // first reauthenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!
          .providerData
          .map((e) => e.providerId)
          .first;
      if (provider.isNotEmpty) {
        //re verify auth email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => LoginScreen());
        }
        else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.offAll(() => ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'oh snap!', message: e.toString());
    }
  }

///Re Authenticate before deleting
  Future<void> reAuthenticateEmailAndPassword() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Processing...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
// Form Validation
      if (!reAuthFormkey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .reAuthenticationWithEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'oh Snap!', message: e.toString());
    }
  }

  ///Upload profile image
 uploadUserProfilePicture() async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        final imageUrl = await userRepository.uploadImage(
            'Users/Images/Profile/', image);

        //update user Image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        TLoaders.successSnackBar(title: 'Congratulations',message: 'Your Profile has been updated');
      }
    }catch(e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    } finally {
      imageUploading.value = false;
    }


}
}
