

import 'package:flutter/cupertino.dart';
import 'package:flutter/materiAL.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/strings.dart';

class LocationAnimatedWidget extends StatefulWidget {
   final AnimationController? controller;
   final VoidCallback? onCompleted;
  const LocationAnimatedWidget({super.key, this.controller, this.onCompleted});

  @override
  State<LocationAnimatedWidget> createState() => _LocationAnimatedWidgetState();
}

class _LocationAnimatedWidgetState extends State<LocationAnimatedWidget> with TickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> locationAnimation;

  late AnimationController locationTextAnimationController;
  late Animation<int> locationTextAnimation;


  @override
  void initState() {
    
     controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
     locationTextAnimationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
     
     locationTextAnimation = IntTween(begin: 0, end: AppStrings.locationText.length)
         .animate(locationTextAnimationController)..addStatusListener((status) {
       if(status == AnimationStatus.completed && widget.onCompleted != null){
         widget.onCompleted!();
       }
     });

     locationAnimation = Tween<double>(begin: 0, end: 220.w, ).animate(controller)..addListener(() {
       if(locationAnimation.value > 200 ){
         if(!locationTextAnimationController.isAnimating){
           locationTextAnimationController.forward();
         }
       }
     });

     controller.forward();

    super.initState();
  }

@override
  void dispose() {
    controller.dispose();
    locationTextAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: locationAnimation,
      builder: (ctx, chld){
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            width: locationAnimation.value,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
            ),
            child: AnimatedBuilder(
              animation: locationTextAnimation,
              builder: (_, value){

                return locationTextAnimation.value < 2 ? const SizedBox.shrink() : Row(
                  children: [
                    SvgPicture.asset(
                        AppStrings.locationIcon,
                        height: 20.h,
                        color: Theme.of(context).colorScheme.secondary
                    ),
                    const SizedBox(width: 4,),
                    Text(
                      AppStrings.locationText.substring(0,locationTextAnimation.value),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                );
              },
            )
        );
      },
    );
  }
}
