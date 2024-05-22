

import 'package:flutter/materiAL.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate/core/constant/strings.dart';
import 'package:real_estate/features/dashboard/domain/entity/house.dart';
import 'package:real_estate/features/dashboard/domain/usecase/get_house.usecase.dart';
import 'package:real_estate/features/dashboard/presentation/widgets/animation_widgets/buy_rent_animated_widget.dart';
import 'package:real_estate/features/dashboard/presentation/widgets/animation_widgets/house_animated_widget.dart';
import 'package:real_estate/features/dashboard/presentation/widgets/animation_widgets/profile_image_widget.dart';

import 'animation_widgets/location_animated_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin{
  
  late List<House> houses;

  late Animation<double> marinaAnimation;
  late AnimationController marinaController;

  late Animation<double> placeAnimation;
  late AnimationController placeAnimationController;

  late AnimationController buyAndRentAnimationController;

  late AnimationController houseAnimationController;

  late ScrollController scrollController;

  @override
  void initState() {

    scrollController = ScrollController();

    buyAndRentAnimationController = AnimationController(duration: const Duration(milliseconds: 500 ), vsync: this);
    houseAnimationController = AnimationController(duration: const Duration(milliseconds: 500 ), vsync: this);

    placeAnimationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    placeAnimation = Tween<double>(begin: 0, end: 80.h).animate(placeAnimationController);

    marinaController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    marinaAnimation = Tween<double>(begin: 0, end: 1).animate(marinaController)..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        // start place animation and buyRentAnimation
        placeAnimationController.forward();
        buyAndRentAnimationController.forward();

      }
    });

    houses = GetHouseUseCase.houses();
    super.initState();
  }

  @override
  void dispose() {
    marinaController.dispose();
    placeAnimationController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (builder, constriant){
          return Container(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.orange.withOpacity(0.04),
                    Colors.orange.withOpacity(0.04),
                    Colors.orange.withOpacity(0.15),
                    Colors.orange.withOpacity(0.15),
                    Colors.orange.withOpacity(0.2)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.centerRight
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            LocationAnimatedWidget(
                              onCompleted: (){
                                marinaController.forward();
                                // fire another animation
                              },
                            ),

                            const ProfileImageWidget()
                          ],
                        ),

                        SizedBox(height: 30.h,),
                        AnimatedBuilder(
                            animation: marinaAnimation,
                            builder: (builder, val,){
                              return AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: marinaAnimation.value,
                                child: Text(
                                  AppStrings.hiMarinaText,
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              );
                            }),
                        SizedBox(height: 5.h,),

                        AnimatedBuilder(
                            animation: placeAnimation,
                            builder: (builder, chl){
                              return AnimatedContainer(
                                duration: const Duration(microseconds: 700),
                                child: SizedBox(
                                  width: 300.w,
                                  height: placeAnimation.value,
                                  child: Text(
                                    AppStrings.yourPlaceText,
                                    style: TextStyle(
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 1.15
                                    ),
                                  ),
                                ),
                              );
                            }),

                        BuyAndRentAnimatedWidget(
                          animationController: buyAndRentAnimationController,
                          onCompleted: (){
                            houseAnimationController.forward();
                          },
                        )

                      ],
                    ),
                  ),
                  HouseAnimatedWidget(
                    animationController: houseAnimationController,
                    scrollEvent: (){
                      scrollController.animateTo(180.0,
                          duration: const Duration(milliseconds: 500), curve: Curves.ease);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


}
