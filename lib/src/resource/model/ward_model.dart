
class WardModel {
  WardModel({this.wards});

  List<Ward>? wards;

  factory WardModel.fromJson(List<dynamic> json) => WardModel(wards: json.map((x) => Ward.fromJson(x)).toList());
}

class Ward {
  Ward({this.id, this.name, this.type, this.districtId, this.district});

  int? id;
  String? name;
  String? type;
  int? districtId;
  District? district;

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      districtId: json["district_id"] == null ? null : json["district_id"],
      district: json["district"] != null ? District.fromJson(json["district"]) : null);

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "district_id": districtId == null ? null : districtId,
    "district": district!.toJson()
  };
}

class DistrictModel {
  DistrictModel({this.districts});

  List<District>? districts;

  factory DistrictModel.fromJson(List<dynamic> json) => DistrictModel(
      districts: json.map((x) => District.fromJson(x)).toList()
  );
}

class District {
  District({
    this.id,
    this.name,
    this.type,
    this.provinceId,
    this.province
  });

  int? id;
  String? name;
  String? type;
  int? provinceId;
  ProvinceModel? province;

  factory District.fromJson(Map<String, dynamic> json) => District(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      provinceId: json["province_id"] == null ? null : json["province_id"],
      province: json["province"] != null ? ProvinceModel.fromJson(json["province"]) : null
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "province_id": provinceId == null ? null : provinceId,
    "province": province!.toJson()
  };
}


class ProvinceModel {
  var id;
  String? name;
  String? type;
  var code;
  double? lat;
  double? lng;

  ProvinceModel({this.id, this.name, this.type, this.code});

  ProvinceModel.fromJson(dynamic json) {
    id = json["id"] as int;
    name = json["name"];
    type = json["type"] == null ? "" : json["type"];
    code = json["code"] == null ? "" : json["code"];
    lat = json["lat"] == null ? null : json["lat"];
    lng = json["lng"] == null ? null : json["lng"];
  }

  static List<ProvinceModel> listFromJson(List<dynamic>? listJson) => listJson != null
      ? List<ProvinceModel>.from(listJson.map((x) => ProvinceModel.fromJson(x)))
      : [];

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["type"] = type;
    map["code"] = code;
    map["lat"] = lat == null ? null : lat;
    map["lng"] = lng == null ? null : lng;

    return map;
  }
}


class CurrentPosition {
  double? lat;
  double? lng;

  CurrentPosition({this.lat, this.lng});

  factory CurrentPosition.fromJson(Map<String, dynamic> json) =>
      CurrentPosition(lat: json["lat"], lng: json["lng"]);

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
