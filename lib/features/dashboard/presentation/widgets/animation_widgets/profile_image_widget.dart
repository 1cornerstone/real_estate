

import 'package:flutter/cupertino.dart';

import '../../../../../core/constant/strings.dart';

class ProfileImageWidget extends StatelessWidget {

  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 50, ),
      duration: const Duration(milliseconds: 500),
      builder: (ctx, value, __){
        return ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.asset(
            AppStrings.userProfileImage,
            fit: BoxFit.cover,
            height: value,
            width: value,
          ),
        );
      },
    );
  }
}
