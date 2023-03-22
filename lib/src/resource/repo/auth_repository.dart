import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/src/configs/configs.dart';
import 'package:flutter_app/src/utils/utils.dart';

import '../resource.dart';

class AuthRepository {
  AuthRepository._();

  static AuthRepository? _instance;

  factory AuthRepository() {
    _instance ??= AuthRepository._();
    return _instance!;
  }

  Future<NetworkState<ListLandModel>> getLandsByPolygon(
      String dataPolygon, int? type, SearchObject searchObject) async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();

    try {
      Response response = await AppClients().post(AppEndpoint.POLYGON,
          data: FormData.fromMap({
            "isAdmin": 0,
            "arrLocation": dataPolygon,
            "province_id": searchObject.provinceId ?? "",
            "type": type,
            "district_id": searchObject.districtId ?? "",
            "ward_id": searchObject.wardId ?? "",
            "land_type_id": searchObject.landTypeId ?? 1,
            "area_min": searchObject.areaMin ?? "",
            "area_max": searchObject.areaMax ?? "",
            "filter_min": searchObject.filterMin ?? 0,
            "filter_max": searchObject.filterMax ?? "",
            "direction_id": searchObject.directionId ?? "",
            "from_date": searchObject.fromDate ?? "",
            "to_date": searchObject.toDate ?? "",
            "order_by": searchObject.orderBy,
            "sland_store": searchObject.slandStore ?? null,
            "status": searchObject.status,
          }),
          options: Options(headers: {"Accept": "application/json"}));
      return NetworkState(
        status: AppEndpoint.SUCCESS,
        data: ListLandModel.fromJson(response.data),
      );
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }

  ///Example
  ///http://relax365.net/hsmoreapp?os=
  // Future<NetworkState<OtherApplication>> getMoreApps() async {
  //   bool isDisconnect = await WifiService.isDisconnect();
  //   if (isDisconnect) return NetworkState.withDisconnect();
  //   try {
  //     String api = AppEndpoint.MORE_APPS;
  //     Map<String, dynamic> params = {
  //       "os" : Platform.isAndroid ? "android" : "ios"
  //     };
  //     Response response = await AppClients().get(api, queryParameters: params);
  //     return NetworkState(
  //       status: AppEndpoint.SUCCESS,
  //       data: OtherApplication.fromJson(jsonDecode(response.data)),
  //     );
  //   } on DioError catch (e) {
  //     return NetworkState.withError(e);
  //   }
  // }
}
