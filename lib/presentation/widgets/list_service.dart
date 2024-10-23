import 'package:apllication_book_now/data/models/service_model.dart';
import 'package:apllication_book_now/resource/fonts_style/fonts_style.dart';
import 'package:apllication_book_now/resource/list_color/colors.dart';
import 'package:apllication_book_now/resource/sizes/list_font_size.dart';
import 'package:apllication_book_now/resource/sizes/list_margin.dart';
import 'package:apllication_book_now/resource/sizes/list_padding.dart';
import 'package:apllication_book_now/resource/sizes/list_rounded.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../../config/routes/routes.dart';
import '../../data/data_sources/api.dart';
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

String tanggalJam(String tanggal) {
  DateTime parsedDate = DateTime.parse(tanggal);
  String convTanggal = DateFormat('dd MMMM yyyy HH:mm').format(parsedDate);
  return convTanggal;
}

Widget serviceCardGridView(BuildContext context, List<ServiceModel> model) {
  return GridView.builder(
    itemCount: model.length,
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 10,
      childAspectRatio: 1.2,
      mainAxisExtent: 200,
    ),
    itemBuilder: (context, index) {
      final services = model[index];
      return LayoutBuilder(
        builder: (context, constraints) {
          return InkWell(
            onTap: () {
              Get.toNamed(Routes.bookingScreen, arguments: services);
            },
            child: Container(
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100.withOpacity(0.5),
                  border: Border.all(color: greyTersier),
                  borderRadius: roundedMediumGeo),
              child: Padding(
                padding: valuePaddingBigSize,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: SizedBox(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: roundedMediumGeo,
                          child: CachedNetworkImage(
                            imageUrl: '$apiImage${services.image}',
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
                    ),
                    spaceHeightSmall,
                    Text(
                      services.name,
                      style: semiBoldStyle.copyWith(
                          color: Colors.black, fontSize: fonth6),
                    ),
                    spaceHeightSmall,
                    Text(
                      services.description,
                      style: regularStyle.copyWith(
                          color: Colors.black, fontSize: regularFont),
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
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

Widget historyServiceCardDashboard(
    BuildContext context,
    String serviceName,
    String description,
    String urlImage,
    String tanggal,
    String noLoket,
    String jam,
    String status) {
  double sidePadding = 40;
  double spaceService = 12;
  double screenWidth = MediaQuery.sizeOf(context).width;
  double containerWidth = (screenWidth - sidePadding - spaceService) * 0.35;
  double widthScreen =
      screenWidth - containerWidth - sidePadding - spaceService;
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
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: greyPrimary,
                              size: 15,
                            ),
                            spaceWidthSmall,
                            Text(
                              tanggal,
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              style: semiBoldStyle.copyWith(
                                  color: greyPrimary,
                                  fontSize: regularFont,
                                  height: 1.5),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: greyPrimary,
                              size: 15,
                            ),
                            spaceWidthSmall,
                            Text(
                              jam.substring(0, 5),
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              style: semiBoldStyle.copyWith(
                                  color: greyPrimary,
                                  fontSize: regularFont,
                                  height: 1.5),
                            ),
                          ],
                        ),
                      ],
                    ),
                    spaceHeightSmall,
                    Row(
                      children: [
                        // Text(
                        //   "Status : ",
                        //   textAlign: TextAlign.justify,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: regularStyle.copyWith(
                        //       color: greyPrimary,
                        //       fontSize: regularFont,
                        //       height: 1.5),
                        // ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: colours),
                              borderRadius: roundedSmallGeo),
                          child: Padding(
                            padding: valuePaddingSmall,
                            child: Text(
                              status.toUpperCase(),
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              style: semiBoldStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: smallFont,
                                  height: 1.5),
                            ),
                          ),
                        ),
                      ],
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
    String note,
    String tanggalBuatBooking) {
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
      height: MediaQuery.of(context).size.height * 0.82,
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
                  style: semiBoldStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
            spaceHeightBig,
            DottedLine(
              dashLength: 5,
              lineThickness: 1.0,
              dashGapLength: 3,
              dashRadius: 3,
              dashColor: greyPrimary,
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dibuat",
                  style: regularStyle.copyWith(color: Colors.black),
                ),
                Text(
                  tanggalJam(tanggalBuatBooking),
                  style: semiBoldStyle.copyWith(color: Colors.black),
                )
              ],
            ),
            spaceHeightBig,
            DottedLine(
              dashLength: 5,
              lineThickness: 1.0,
              dashGapLength: 3,
              dashRadius: 3,
              dashColor: greyPrimary,
            ),
            spaceHeightMedium,
            status == 'dibatalkan' || status == 'selesai'
                ? Container()
                : Text(
                    "Catatan",
                    style: semiBoldStyle.copyWith(color: Colors.black),
                  ),
            spaceHeightMedium,
            status == 'dibatalkan' || status == 'selesai'
                ? Container()
                : Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.5),
                        border: Border.all(color: greyTersier),
                        borderRadius: roundedMediumGeo),
                    child: Padding(
                      padding: valuePaddingMedium,
                      child: Text(
                        "Harap Datang maximal 30 menit sebelum jam booking yang telah ditentukan untuk menghindari anda ditentukan pada jadwal lain! Terima Kasih",
                        softWrap: true,
                        style: regularStyle.copyWith(
                            fontSize: regularFont, color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
            spaceHeightMedium,
            note == '' || note == 'null'
                ? Container()
                : Text(
                    "Alasan Pesanan Ditolak",
                    style: semiBoldStyle.copyWith(color: Colors.black),
                  ),
            spaceHeightMedium,
            note == '' || note == 'null'
                ? Container()
                : Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.redAccent.shade200.withOpacity(0.5),
                        border: Border.all(color: Colors.redAccent.shade200),
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
