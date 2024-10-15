import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../resource/list_color/colors.dart';

CarouselSlider carouselSlider(
    CarouselSliderController controller,
    double heightContainer,
    Function(int, CarouselPageChangedReason) pageChaned,
    List<Widget> items) {
  return CarouselSlider(
    carouselController: controller,
    options: CarouselOptions(
      height: heightContainer,
      autoPlay: true,
      enlargeCenterPage: false,
      aspectRatio: 16 / 9,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      pauseAutoPlayOnTouch: true,
      viewportFraction: 1.0,
      initialPage: 0,
      pageSnapping: true,
      enableInfiniteScroll: items.length == 1 ? false : true,
      onPageChanged: pageChaned,
    ),
    items: items.map((item) => item).toList(),
  );
}

Widget indicatorCarousel(
    int current, List<Widget> items, CarouselSliderController controller) {
  return items.isNotEmpty
      ? AnimatedSmoothIndicator(
          activeIndex: current,
          count: items.length,
          effect: JumpingDotEffect(
              verticalOffset: 10,
              dotColor: greySecondary,
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: blueTersier),
          onDotClicked: (index) {
            controller.animateToPage(index);
          },
        )
      : const SizedBox.shrink();
}
