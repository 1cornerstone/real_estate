import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/materiAL.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate/core/constant/strings.dart';

import '../../domain/entity/house.dart';

class HouseWidget extends StatefulWidget {
  final House house;
  final double width;

  const HouseWidget({
    super.key,
    required this.house,
    required this.width,
  });

  @override
  State<HouseWidget> createState() => _HouseState();
}

class _HouseState extends State<HouseWidget> with TickerProviderStateMixin {
  late AnimationController textAnimationController;
  late Animation<int> textAnimation;

  late AnimationController btnSlideController;
  late Animation<double> btnSlideAnimation;

  @override
  void initState() {
    textAnimationController = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);
    textAnimation = IntTween(begin: 0, end: (widget.house.address ?? '').length)
        .animate(textAnimationController);

    btnSlideController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    btnSlideAnimation =
        Tween<double>(begin: 50.w, end: widget.width).animate(CurvedAnimation(
      parent: btnSlideController,
      curve: Curves.easeIn,
    ))
          ..addListener(() {
            final percent = widget.width * 0.95; // check if it is upto 80 %
            if (!textAnimationController.isAnimating &&
                btnSlideAnimation.value > percent) {
              textAnimationController.forward();
            }
          });

    btnSlideController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.asset(
            widget.house.imagePath ?? '',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: AnimatedBuilder(
            animation: btnSlideAnimation,
            builder: (_, __) {
              return Container(
                width: btnSlideAnimation.value,
                height: 50,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                                child: AnimatedBuilder(
                              animation: textAnimation,
                              builder: (_, value) {
                                return textAnimation.value < 2
                                    ? const SizedBox.shrink()
                                    : Text(
                                        widget.house.address ??
                                            ''.substring(
                                                0, textAnimation.value),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 17.sp),
                                      );
                              },
                            )),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 13,
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            },
          ),
        ),
      ],
    );
  }
}
