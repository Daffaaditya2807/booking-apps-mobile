import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'list_text.dart';
import 'loading_data.dart';

Widget serviceCard(BuildContext context, String serviceName, String description,
    String urlImage) {
  double sidePadding = 40;
  double spaceService = 5;
  double screenWidth = MediaQuery.sizeOf(context).width;
  double containerWidth = (screenWidth - sidePadding - spaceService) * 0.35;
  double widthScreen =
      screenWidth - containerWidth - sidePadding - spaceService;

  return Padding(
    padding: verticalPaddingSmall,
    child: IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: containerWidth,
            height: double.infinity,
            decoration: BoxDecoration(
                color: greyPrimary, borderRadius: roundedMediumGeo),
            child: ClipRRect(
              borderRadius: roundedMediumGeo,
              child: CachedNetworkImage(
                imageUrl: urlImage,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: loadingData("Memuat gambar..")),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          spaceWidthSmall,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: widthScreen,
                child: Text(
                  serviceName,
                  overflow: TextOverflow.ellipsis,
                  style: semiBoldStyle.copyWith(
                      color: Colors.black, fontSize: fonth6),
                ),
              ),
              SizedBox(
                width: widthScreen,
                child: Text(
                  description,
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: regularStyle.copyWith(
                      color: greyPrimary, fontSize: regularFont, height: 1.5),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget detailService(
    BuildContext context, String serviceName, String description) {
  double heightAppBar = MediaQuery.of(context).viewPadding.top;
  double heightScreen = MediaQuery.sizeOf(context).height;
  double heightContainer =
      (heightScreen - kToolbarHeight - heightAppBar) * 0.25;
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: double.infinity,
        height: heightContainer,
        decoration: BoxDecoration(
            borderRadius: roundedMediumGeo,
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
      ),
      spaceHeightBig,
      Text(
        serviceName,
        overflow: TextOverflow.ellipsis,
        style: semiBoldStyle.copyWith(color: Colors.black, fontSize: fonth6),
      ),
      spaceHeightSmall,
      Text(
        description,
        textAlign: TextAlign.justify,
        style: mediumStyle.copyWith(
            color: greyPrimary, fontSize: regularFont, height: 1.5),
      )
    ],
  );
}

Widget detailStatusService(
    BuildContext context, String serviceName, String description) {
  double heightAppBar = MediaQuery.of(context).viewPadding.top;
  double heightScreen = MediaQuery.sizeOf(context).height;
  double heightContainer =
      (heightScreen - kToolbarHeight - heightAppBar) * 0.25;
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: double.infinity,
        height: heightContainer,
        decoration: BoxDecoration(
            borderRadius: roundedMediumGeo,
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
      ),
      spaceHeightBig,
      spaceHeightMedium,
      componentTextDetailStatusBooking(
          "Senin", "9 September 2024", "13:30", "Layanan 1", "Dipesan")
    ],
  );
}

Widget colourIndicatorService(String service, Color serviceIndicator) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: serviceIndicator),
        ),
        spaceWidthSmall,
        Text(
          service,
          style: regularStyle.copyWith(color: Colors.black),
        )
      ],
    ),
  );
}
