import 'package:flutter/material.dart';
import 'package:flutter_app/src/configs/configs.dart';
import 'package:get/get.dart';

class WidgetDialogConfirm extends StatelessWidget {
  final String title;

  const WidgetDialogConfirm({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width - 56,
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                title,
                style: AppTextStyles.normal,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: ()=>Get.back(result: false),
                      child: Container(
                        height: 40,
                        color: AppColors.primary,
                        child: Center(
                          child: Text(
                            'home_skip'.tr,
                            style: AppTextStyles.normal.copyWith(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 1.2,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: ()=>Get.back(result: true),
                      child: Container(
                        height: 40,
                        color: AppColors.primary,
                        child: Center(
                          child: Text(
                            'home_agree'.tr,
                            style: AppTextStyles.normal.copyWith(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
