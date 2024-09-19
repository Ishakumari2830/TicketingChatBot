
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


import '../../../../../utils/contsants/colors.dart';
import '../../../../../utils/contsants/sizes.dart';
import '../../../../../utils/contsants/text_strings.dart';
import '../../common/terms_and_conditions/terms_conditions_checkbox.dart';
import '../../repositries/authentication/controller/signup/signup_controller.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/validators/validation.dart';


class TSignUpForm extends StatelessWidget {
  const TSignUpForm({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
   final controller= Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              //note : in general we cant use 2 textformfield in a row, so for that we use expand widget
              Expanded(
                child: TextFormField(
                  controller: controller.firstname,
                   validator: (value) => TValidator.ValidateEmptyText('First name', value),//prperty
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                    controller: controller.lastname,
                    validator: (value) => TValidator.ValidateEmptyText('Last name', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          ///Username
          TextFormField(
              controller: controller.username,
              validator: (value) => TValidator.ValidateEmptyText('Username', value),
              expands: false,
              decoration: const InputDecoration(
                labelText: TTexts.userName,
                prefixIcon: Icon(Iconsax.user_edit),
              )),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          ///email
          TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              expands: false,
              decoration: const InputDecoration(
                labelText: TTexts.email,
                prefixIcon: Icon(Iconsax.direct),
              )),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          ///phone number
          TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => TValidator.validatePhoneNumber( value),
              expands: false,
              decoration: const InputDecoration(
                labelText: TTexts.phoneNumber,
                prefixIcon: Icon(Iconsax.call),
              )),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          ///password
          Obx(
               ()=> TextFormField(
                controller: controller.password,
                validator: (value) => TValidator.validatePassword( value),
                obscureText: controller.hidePassword.value,

                decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: Icon(Iconsax.password_check),
                    suffixIcon: IconButton(onPressed: ()=> controller.hidePassword.value = !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye,)))),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          ///terms and coditions Checkbox
          TTermsAndConditionsCheckBox(),

          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          ///signup button
          SizedBox(
            //for any button making full width
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(TTexts.createAccount),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
        ],
      ),
    );
  }
}

