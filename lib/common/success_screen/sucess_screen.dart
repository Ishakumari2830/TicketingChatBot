

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/contsants/sizes.dart';
import '../../../utils/contsants/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../styles/spacing_styles.dart';

class SucessScreen extends StatelessWidget {

  const SucessScreen({super.key, required this.image, required this.title, required this.subtitle, required this.onPressed});
  final String image,title,subtitle;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight*2,
          child: Column(
            children: [
              ///image
              Lottie.asset(image,width: THelperFunctions.screenWidth()*0.6,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              ///title and subtitle
              Text(TTexts.yourAccountCreatedTitle,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwItems,),
              // Text('',style: Theme.of(context).textTheme.labelLarge,textAlign: TextAlign.center,),
              // const SizedBox(height: TSizes.spaceBtwItems,),
              Text(TTexts.yourAccountCreatedSubtitle,style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              ///buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(TTexts.tContinue),
                ),
              ),
          ],
        ),
        ),
      ),

    );
  }
}
