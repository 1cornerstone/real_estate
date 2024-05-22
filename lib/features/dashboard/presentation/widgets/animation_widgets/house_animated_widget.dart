

import 'package:flutter/cupertino.dart';
import 'package:flutter/materiAL.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../domain/usecase/get_house.usecase.dart';
import '../house_widget.dart';

class HouseAnimatedWidget extends StatefulWidget {

  final AnimationController animationController;
  final VoidCallback? scrollEvent;
  const HouseAnimatedWidget({super.key, required this.animationController, this.scrollEvent});

  @override
  State<HouseAnimatedWidget> createState() => _HouseAnimatedWidgetState();
}

class _HouseAnimatedWidgetState extends State<HouseAnimatedWidget> with TickerProviderStateMixin {

  late AnimationController slideInAnimationController;
  late Animation<double> slideInAnimation;

  late AnimationController buttonAnimationController;
  late Animation<double> buttonAnimation;


  @override
  void initState() {

    buttonAnimationController = AnimationController(duration: const Duration(seconds: 2 ), vsync: this);
    buttonAnimation = Tween<double>(begin: 0, end: 2212).animate(buttonAnimationController);

    slideInAnimationController = widget.animationController;
    slideInAnimation = Tween<double>(begin: 0, end: 7)
        .animate(slideInAnimationController)..addStatusListener((status) {
          if(status == AnimationStatus.completed){
            if(widget.scrollEvent != null){
              widget.scrollEvent!();
            }

            Future.delayed(const Duration(seconds: 2),(){
              buttonAnimationController.forward();
            });

          }

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  slide in
    // animated button

    return AnimatedBuilder(
        animation: slideInAnimation,
        builder: (builder, _){
          return slideInAnimation.value == 0 ? SizedBox.shrink() : Container(
            margin: EdgeInsets.only(top: 25.h),
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r))
            ),
            child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: GetHouseUseCase.houses().map((house) => StaggeredGridTile.count(
                  crossAxisCellCount: house.crossAxis ?? 2,
                  mainAxisCellCount: house.mainAxis ?? 2,
                  child: LayoutBuilder(
                    builder: (ctx,BoxConstraints constraints){
                      return AnimatedBuilder(
                        animation: buttonAnimation,
                        builder: (builder, _){
                          return HouseWidget(house: house, width: constraints.maxWidth, );
                        },
                      );
                    },
                  ),
                )).toList()),
          );
        }
    );
  }
}
