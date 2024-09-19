

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ticketing/signup/widgets/signUp_form.dart';


import '../../../../utils/contsants/sizes.dart';
import '../../../../utils/contsants/text_strings.dart';
import '../login/widgets/login_signup/form_divider.dart';
import '../login/widgets/login_signup/social_buttons.dart';
import '../utils/helpers/helper_functions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(

      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///title
              Text(TTexts.signupTitle,style: Theme.of(context).textTheme.headlineMedium,),

              const SizedBox(height: TSizes.spaceBtwSections),

              ///Form
              const TSignUpForm(),
              ///divider
              TFormDivider(dividerText: TTexts.orsignUpWith.capitalize!),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///social buttons
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

