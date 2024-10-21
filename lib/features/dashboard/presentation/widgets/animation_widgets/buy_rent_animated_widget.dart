

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate/core/extension/string_ext.dart';

import '../../../../../core/constant/strings.dart';

class BuyAndRentAnimatedWidget extends StatefulWidget {
  final AnimationController animationController;
  final VoidCallback? onCompleted;
  const BuyAndRentAnimatedWidget({super.key, required this.animationController, this.onCompleted});

  @override
  State<BuyAndRentAnimatedWidget> createState() => _BuyAndRentAnimatedWidgetState();
}

class _BuyAndRentAnimatedWidgetState extends State<BuyAndRentAnimatedWidget> with TickerProviderStateMixin {

  late AnimationController sizeAnimationController;
  late Animation<double> sizeAnimation;
  
  late AnimationController buyCountTextAnimationController;
  late Animation<int> buyCountTextAnimation;

  late AnimationController rentCountTextAnimationController;
  late Animation<int> rentCountTextAnimation;
  bool isOnCompletedCalled = false;
  
  @override
  void initState() {
    
     buyCountTextAnimationController = AnimationController(duration: const Duration(seconds: 2 ), vsync: this);
     buyCountTextAnimation = IntTween(begin: 0, end: 1034)
         .animate(buyCountTextAnimationController)..addListener(() {

       if(!isOnCompletedCalled && buyCountTextAnimation.value > 800 && widget.onCompleted != null){
         isOnCompletedCalled = true;
          widget.onCompleted!();
       }
     });
     
     rentCountTextAnimationController = AnimationController(duration: const Duration(seconds: 2 ), vsync: this);
     rentCountTextAnimation = IntTween(begin: 0, end: 2212).animate(rentCountTextAnimationController);
     
     sizeAnimationController = widget.animationController;
     sizeAnimation = Tween<double>(begin: 0, end: 185.h)
         .animate(sizeAnimationController)..addListener(() {
        if(sizeAnimation.value > 150 && !buyCountTextAnimationController.isAnimating){
          buyCountTextAnimationController.forward();
          rentCountTextAnimationController.forward();
        }
     });
     
     
    super.initState();
  }
  
  @override
  void dispose() {

    sizeAnimationController.dispose();
    buyCountTextAnimationController.dispose();
    rentCountTextAnimationController.dispose();
    super.dispose();
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: sizeAnimation, builder: (builder, _){
      return Padding(
        padding:  EdgeInsets.only(top: 30.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Container(
              height: sizeAnimation.value,
              width: 160.w,
              padding: EdgeInsets.only(top: 25.h),
              decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle
              ),
              child: sizeAnimation.value < 150 ? Container() : Column(
                children: [
                  Text(
                    AppStrings.buyText,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  Column(
                    children: [
                      AnimatedBuilder(
                          animation: buyCountTextAnimation,
                          builder: (ctx, _){
                         return Text(
                            buyCountTextAnimation.value.toString().toDecimal(),
                           style: TextStyle(
                               fontFamily: 'DoHyeon',
                               color: Colors.white,
                               fontSize: 35.sp,
                               fontWeight: FontWeight.w700
                           ),
                         );
                      }),
                      Text(
                        AppStrings.offerText,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            Container(
              height: sizeAnimation.value,
              width: 175.w,
              padding:  EdgeInsets.only(top: 25.h),
              decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r)
              ),
              child: sizeAnimation.value < 150 ? Container() : Column(
                children: [
                  Text(
                    AppStrings.rentText,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16.sp
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Column(
                    children: [
                      AnimatedBuilder(
                          animation: rentCountTextAnimation,
                          builder: (ctx, _){
                            return Text(
                              rentCountTextAnimation.value.toString().toDecimal(),
                              style: TextStyle(
                                  fontFamily: 'DoHyeon',
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontSize: 34.sp,
                                  fontWeight: FontWeight.w700
                              ),
                            );
                          }),
                      Text(
                        AppStrings.offerText,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 17.sp
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),


          ],
        ),
      );
    }) ;
  }
}
