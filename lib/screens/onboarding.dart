import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/routes.dart';
import 'package:flora/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> items = DB.onBoarding
      .map(
        (h) => OnBoardingModel(
          icon: h['icon'],
          title: h['title'],
          desc: h['desc'],
        ),
      )
      .toList();

  PageController _pageImageController = PageController();
  PageController _pageTextController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageImageController = PageController(initialPage: _currentPage);
    _pageTextController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageImageController.dispose();
    _pageTextController.dispose();
    super.dispose();
  }

  void onNext([int? page]) {
    // ignore: no_leading_underscores_for_local_identifiers
    int _page = page ?? _currentPage + 1;

    setState(() {
      _currentPage = _page;
    });

    if (_currentPage < items.length) {
      _pageImageController.animateToPage(
        _page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // _pageTextController.animateToPage(
      //   _page,
      //   duration: const Duration(milliseconds: 300),
      //   curve: Curves.easeInOut,
      // );
    } else {
      onDone();
    }
  }

  void onDone() {
    Navigator.pushNamed(context, AppRoute.registerPhone);
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: screen.height,
        child: Stack(
          children: [
            SizedBox(
              height: screen.height * 2 / 3 + 30,
              width: double.infinity,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageImageController,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    items[index].icon,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              right: AppSpace.xl,
              child: TextButton(
                onPressed: onDone,
                child: const Text(
                  'Bỏ qua',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: SafeArea(
                child: Container(
                  height: screen.height * 1 / 3 + 20,
                  width: screen.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(-2, -2),
                        blurRadius: 2,
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppSpace.xxl),
                      topRight: Radius.circular(AppSpace.xxl),
                    ),
                  ),
                  child: Padding(
                    // padding: const EdgeInsets.all(AppSpace.xl),
                    padding: const EdgeInsets.only(
                      top: 28,
                      left: AppSpace.xl,
                      right: AppSpace.xl,
                      bottom: AppSpace.xl,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSmoothIndicator(
                          activeIndex: _currentPage,
                          count: items.length,
                          effect: const ExpandingDotsEffect(
                            dotWidth: 9,
                            dotHeight: 9,
                            spacing: 6,
                            expansionFactor: 4.2,
                            activeDotColor: AppColor.primary,
                            dotColor: AppColor.neutral40,
                          ),
                          onDotClicked: (index) => onNext(index),
                        ),
                        Expanded(
                          child: PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _pageTextController,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final OnBoardingModel data = items[index];
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data.title,
                                    style: AppStyle.title,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: AppSpace.xxl,
                                  ),
                                  Text(
                                    data.desc,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: AppColor.neutral40,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        AppButton(label: 'Tiếp tục', onTab: () => onNext())
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OnBoardingModel {
  String icon;
  String title;
  String desc;

  OnBoardingModel({
    required this.icon,
    required this.title,
    required this.desc,
  });
}
