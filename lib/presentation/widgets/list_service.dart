import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket_widget/ticket_widget.dart';

import 'information.dart';
import 'list_text.dart';
import 'loading_data.dart';

String hari(String tanggal) {
  DateTime parsedDate = DateTime.parse(tanggal);
  String convHari = DateFormat('EEEE').format(parsedDate);
  return convHari;
}

String tanggal(String tanggal) {
  DateTime parsedDate = DateTime.parse(tanggal);
  String convTanggal = DateFormat('dd MMMM yyyy').format(parsedDate);
  return convTanggal;
}

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
                placeholder: (context, url) => Center(
                    child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: bluePrimary,
                    strokeWidth: 2.0,
                  ),
                )),
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

Widget historyServiceCard(
    BuildContext context,
    String serviceName,
    String description,
    String urlImage,
    String tanggal,
    String noLoket,
    String jam) {
  double sidePadding = 40;
  double spaceService = 12;
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
          spaceWidthMedium,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: widthScreen,
                child: Text(
                  '$serviceName | $noLoket',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: semiBoldStyle.copyWith(
                      color: Colors.black, fontSize: fonth6),
                ),
              ),
              SizedBox(
                width: widthScreen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceHeightSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tanggal : $tanggal",
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: regularStyle.copyWith(
                              color: greyPrimary,
                              fontSize: regularFont,
                              height: 1.5),
                        ),
                        // Text(
                        //   "No : $noLoket",
                        //   textAlign: TextAlign.justify,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: regularStyle.copyWith(
                        //       color: greyPrimary,
                        //       fontSize: regularFont,
                        //       height: 1.5),
                        // ),
                      ],
                    ),
                    spaceHeightSmall,
                    Text(
                      "Waktu : $jam",
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: regularStyle.copyWith(
                          color: greyPrimary,
                          fontSize: regularFont,
                          height: 1.5),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget detailService(BuildContext context, String serviceName,
    String description, String imageUrl, String tag) {
  double heightAppBar = MediaQuery.of(context).viewPadding.top;
  double heightScreen = MediaQuery.sizeOf(context).height;
  double heightContainer =
      (heightScreen - kToolbarHeight - heightAppBar) * 0.25;
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: heightContainer,
          decoration: BoxDecoration(
              borderRadius: roundedMediumGeo,
              color: greyTersier,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: ClipRRect(
            borderRadius: roundedMediumGeo,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
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
      ),
      spaceHeightBig,
      Text(
        "Deskripsi",
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

Widget emptyListService() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Expanded(child: Container()),
      informationTextAsset(
          "assets/image/splash_screen/empty1.png",
          "Booking Kosong!",
          "Belum ada layanan yang anda pesan. Pesan sekarang dan nikmati layanan terbaik kami sekarang juga!"),
      Expanded(child: Container()),
    ],
  );
}

Widget detailHistoryStatus(
    BuildContext context,
    String name,
    String serviceName,
    String status,
    String codeBooking,
    String day,
    String date,
    String time,
    String loket,
    String idBooking,
    String note) {
  List<Color> colours = [];
  if (status == 'dipesan') {
    colours = [bluePrimary, blueSecondary];
  } else if (status == 'diproses') {
    colours = [greenActive, Colors.green.shade600];
  } else if (status == 'selesai') {
    colours = [orangeActive, Colors.orange.shade400];
  } else {
    colours = [Colors.red, Colors.redAccent.shade400];
  }
  return TicketWidget(
      width: double.infinity,
      height: note != 'null'
          ? MediaQuery.of(context).size.height * 0.8
          : MediaQuery.of(context).size.height * 0.53,
      margin: sidePaddingSmall,
      color: Colors.white,
      isCornerRounded: true,
      child: Padding(
        padding: sideVerticalPaddingBig,
        child: Column(
          children: [
            spaceHeightMedium,
            Text(
              name,
              style: boldStyle.copyWith(color: Colors.black),
            ),
            spaceHeightSmall,
            Text(
              serviceName,
              style: regularStyle.copyWith(color: Colors.black),
            ),
            spaceHeightMedium,
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colours,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: roundedMediumGeo),
              child: Padding(
                padding: sideVerticalPaddingMedium,
                child: Text(
                  status.toUpperCase(),
                  style: mediumStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
            spaceHeightSmall,
            const Divider(),
            spaceHeightMedium,
            Text(
              "Nomor Antrian Anda",
              style: semiBoldStyle.copyWith(
                  color: Colors.black, fontSize: regularFont),
            ),
            Text(
              codeBooking,
              style: boldStyle.copyWith(fontSize: 40, color: bluePrimary),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hari",
                  style: regularStyle.copyWith(color: Colors.black),
                ),
                Text(
                  hari(day),
                  style: semiBoldStyle.copyWith(color: Colors.black),
                )
              ],
            ),
            spaceHeightMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tanggal",
                  style: regularStyle.copyWith(color: Colors.black),
                ),
                Text(
                  tanggal(date),
                  style: semiBoldStyle.copyWith(color: Colors.black),
                )
              ],
            ),
            spaceHeightMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jam Booking",
                  style: regularStyle.copyWith(color: Colors.black),
                ),
                Text(
                  time,
                  style: semiBoldStyle.copyWith(color: Colors.black),
                )
              ],
            ),
            spaceHeightMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nomer Loket",
                  style: regularStyle.copyWith(color: Colors.black),
                ),
                Text(
                  loket,
                  style: semiBoldStyle.copyWith(color: Colors.black),
                )
              ],
            ),
            spaceHeightMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kode Booking",
                  style: regularStyle.copyWith(color: Colors.black),
                ),
                Text(
                  idBooking,
                  style: semiBoldStyle.copyWith(color: Colors.black),
                )
              ],
            ),
            spaceHeightMedium,
            const Divider(),
            note == '' || note == 'null'
                ? Container()
                : Text(
                    "Catatan",
                    style: regularStyle.copyWith(color: Colors.black),
                  ),
            spaceHeightMedium,
            note == '' || note == 'null'
                ? Container()
                : Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: bluePrimary.withOpacity(0.5),
                        border: Border.all(color: bluePrimary),
                        borderRadius: roundedMediumGeo),
                    child: Padding(
                      padding: valuePaddingMedium,
                      child: Text(
                        note,
                        softWrap: true,
                        style: regularStyle.copyWith(fontSize: regularFont),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  )
          ],
        ),
      ));
}

Widget detailStatusService(
    BuildContext context,
    String serviceName,
    String status,
    String jam,
    String hari,
    String tanggalLengkap,
    String loket,
    String reason,
    String urlImage,
    {VoidCallback? function}) {
  double heightAppBar = MediaQuery.of(context).viewPadding.top;
  double heightScreen = MediaQuery.sizeOf(context).height;
  double heightContainer =
      (heightScreen - kToolbarHeight - heightAppBar) * 0.25;
  List<Color> colours = [];
  if (status == 'dipesan') {
    colours = [bluePrimary, blueSecondary];
  } else if (status == 'diproses') {
    colours = [greenActive, Colors.green.shade600];
  } else if (status == 'selesai') {
    colours = [orangeActive, Colors.orange.shade400];
  } else {
    colours = [Colors.red, Colors.redAccent.shade400];
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(
        width: double.infinity,
        height: heightContainer,
        decoration: BoxDecoration(
            borderRadius: roundedMediumGeo,
            color: greyTersier,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ]),
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
      spaceHeightBig,
      spaceHeightMedium,
      componentTextDetailStatusBooking(
        hari,
        tanggalLengkap,
        jam,
        serviceName,
        status,
        loket,
        colours,
        reasonStatus: reason,
        function: function,
      ),
      // Expanded(child: Container()),
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
