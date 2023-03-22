import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../configs/configs.dart';
import '../../../resource/resource.dart';
import '../../../utils/utils.dart';
import '../../routers.dart';

class WidgetQuickView extends StatefulWidget {
  WidgetQuickView({Key? key, this.land}) : super(key: key);
  LandModel? land;

  @override
  _WidgetQuickViewState createState() => _WidgetQuickViewState();
}

class _WidgetQuickViewState extends State<WidgetQuickView> {
  @override
  Widget build(BuildContext context) {
    LandModel? land = widget.land;
    return Wrap(
      children: [
        Container(
          height: 40,
          color: AppColors.primary,
          alignment: Alignment.center,
          child: Text("quick_view".tr,
              style: AppStyles.DEFAULT_MEDIUM_2.copyWith(color: Colors.white)),
        ),
        Image.network('${land!.getFirstPublicImage()}'),
        // MyNetworkImage(url: "${land!.getFirstPublicImage()}", height: 190, width: Get.width),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(land.title!, style: AppStyles.DEFAULT_MEDIUM_2_BOLD)),
              ),
              showOneInfo("publisher".tr + ":", "${land.userName}"),
              const SizedBox(height: 5),
              Row(
                children: [
                  showOneInfo("short_price".tr + ":", AppUtils.showMoney(land.price!, true)),
                  const Spacer(),
                  showOneInfo("acreage".tr + ":", "${land.area} m2")
                ],
              ),
              const SizedBox(height: 5),
              showOneInfo(
                  "land_type".tr + ":", land.landType != null ? "${land.landType!.name}" : ""),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("address".tr + ":", style: AppStyles.DEFAULT_MEDIUM_1_BOLD),
                  const SizedBox(width: 5),
                  Expanded(
                      child: Text(
                          "${land.address}, ${land.ward!.name}, ${land.ward!.district!.name}, ${land.ward!.district!.province!.name}",
                          style: AppStyles.DEFAULT_MEDIUM_1_BOLD.copyWith(color: Colors.red)))
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text("publish_day".tr + ":",
                      style: AppStyles.DEFAULT_MEDIUM_1.copyWith(color: Colors.blue)),
                  const SizedBox(width: 5),
                  Text("${AppUtils.convertString2String(land.createdAt!)}",
                      style: AppStyles.DEFAULT_MEDIUM_1
                          .copyWith(color: Colors.grey, fontStyle: FontStyle.italic))
                ],
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buttonQuickView("close".tr, () {
                      Get.back();
                    }),
                    const SizedBox(width: 5),
                    buttonQuickView("detail".tr, () {
                      // Get.offNamed(Routers.landDetail,
                      //     arguments: {"landId": land.id, "userSpecial": null},
                      //     preventDuplicates: false);
                    })
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget showOneInfo(String titleInfo, String contentInfo) {
    return Row(
      children: [
        Text(titleInfo, style: AppStyles.DEFAULT_MEDIUM_1_BOLD),
        const SizedBox(width: 5),
        Text(contentInfo, style: AppStyles.DEFAULT_MEDIUM_1_BOLD.copyWith(color: Colors.red))
      ],
    );
  }

  Widget buttonQuickView(String buttonContent, Function()? buttonAction) {
    return InkWell(
      child: Container(
        height: 40,
        width: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.primary, borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Text(buttonContent,
            style: AppStyles.DEFAULT_MEDIUM_2_BOLD.copyWith(color: Colors.white)),
      ),
      onTap: buttonAction,
    );
  }
}
