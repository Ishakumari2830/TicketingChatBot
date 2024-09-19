// import 'package:e_comrc/common/styles/spacing_styles.dart';
// import 'package:e_comrc/features/authentication/screens/login/widgets/login_form.dart';
// import 'package:e_comrc/features/authentication/screens/login/widgets/login_header.dart';

// import 'package:e_comrc/utils/contsants/text_strings.dart';
// import 'package:e_comrc/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ticketing/login/widgets/login_form.dart';
import 'package:online_ticketing/login/widgets/login_header.dart';
import 'package:online_ticketing/login/widgets/login_signup/form_divider.dart';
import 'package:online_ticketing/login/widgets/login_signup/social_buttons.dart';



// import '../../../../common/widgets/login_signup/form_divider.dart';
// import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/contsants/sizes.dart';
import '../common/styles/spacing_styles.dart';
import '../utils/contsants/text_strings.dart';
import '../utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///logo,Title & subTitle
              const TLoginHeader(),

              ///form
              const TLoginForm(),

              ///divider
               TFormDivider(dividerText: TTexts.orSiginWith.capitalize!,),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              ///footer
             const  TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}







