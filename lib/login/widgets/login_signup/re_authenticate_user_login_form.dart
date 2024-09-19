
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../repositries/authentication/controller/user_controller.dart';
import '../../../utils/contsants/sizes.dart';
import '../../../utils/contsants/text_strings.dart';
import '../../../utils/validators/validation.dart';
class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return  Scaffold(
      appBar: AppBar(title: Text('ReAuthenticate User'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: TValidator.validateEmail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TTexts.email
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwInputFields,),
                ///Password
                ///password
                Obx(
                      () => TextFormField(
                      controller: controller.verifyPassword ,
                      validator: (value) => TValidator.ValidateEmptyText('Password',value),
                      obscureText: controller.hidePassword.value,
                      decoration: InputDecoration(
                          labelText: TTexts.password,
                          prefixIcon: Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                              icon: Icon(
                                controller.hidePassword.value
                                    ? Iconsax.eye_slash
                                    : Iconsax.eye,
                              )))),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields ),

                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.reAuthenticateEmailAndPassword(),
                        child: const Text('Verify'))),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
