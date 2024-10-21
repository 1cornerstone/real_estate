import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/materiAL.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate/core/constant/strings.dart';
import 'package:real_estate/core/shared_widget/round_container.dart';
import 'package:real_estate/features/dashboard/presentation/widgets/home_widget.dart';
import 'package:real_estate/features/dashboard/presentation/widgets/search_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {
  int pageIndex = 2;


  late AnimationController controller;
  late Animation<double> animation;
  late PageController pageController;

  @override
  void initState() {

    controller = AnimationController(duration: const Duration(seconds: 1 ), vsync: this);
    animation = Tween<double>(begin: 0, end: 30)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    Future.delayed(const Duration(seconds: 6),(){
      controller.forward();
    });

    pageController = PageController(
        initialPage: pageIndex,
      viewportFraction: 1
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Widget> pages = [
    const SearchWidget(),
    Container(),
    const HomeWidget(),
    Container(),
    Container()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
        bottomNavigationBar: AnimatedBuilder(
          animation: animation,
          builder: (_,__){

            return animation.value == 0 ? const SizedBox.shrink() : Container(
              margin: EdgeInsets.only(
                left: 40.w,
                right: 40.w,
                bottom: animation.value,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.all(Radius.circular(35.r)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  navItem(AppStrings.searchIcon, isSelected: pageIndex == 0,
                      onTap: () {
                        pageIndex = 0;
                    pageController.jumpToPage(pageIndex);
                        setState(() {
                          pageIndex = 0;
                        });
                      }),
                  navItem(AppStrings.messageIcon),
                  navItem(AppStrings.homeIcon, isSelected: pageIndex == 2,
                      onTap: () {
                        pageIndex = 2;
                        pageController.jumpToPage(pageIndex);
                    setState(() {
                          pageIndex = 2;
                        });
                      }),
                  navItem(AppStrings.loveIcon),
                  navItem(AppStrings.userIcon),
                ],
              ),
            );
          },
        )
    );
  }

  Widget navItem(
    String icon, {
    bool isSelected = false,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: RoundContainer(
        padding: isSelected ? 17: 13,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.black.withOpacity(0.4),
        child: SvgPicture.asset(
          icon,
          height: 23,
          color: Colors.white,
        ),
      ),
    );
  }
}

// league spartan
// kosan sen
