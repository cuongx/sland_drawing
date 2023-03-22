import '../resource.dart';

class LandModel {
  LandModel({
    this.id,
    this.landType,
    this.title,
    this.price,
    this.direction,
    this.address,
    this.area,
    this.href,
    this.floor,
    this.description,
    this.longitude,
    this.latitude,
    this.userName,
    this.userId,
    this.status,
    this.type,
    this.phone,
    this.wardId,
    this.ward,
    this.contactInfo,
    this.createdAt,
    this.updatedAt,
    this.priceUnit,
    this.expriredDay,
    this.isHot,
    this.images,
    this.videos,
    this.slug,
    this.publicUrl,
    this.commission,
    this.commissionUnit,
    this.originalPrice,
    this.commissionPrice,
    this.addCart,
    this.rte,
    this.slandStore,
    this.cart,
    this.code,
    this.indexByCode,
  });

  int? id;
  LandType? landType;
  String? title;
  num? price;
  Direction? direction;
  String? address;
  String? area;
  String? href;
  String? floor;
  String? description;
  double? longitude;
  double? latitude;
  String? userName;
  int? userId;
  int? status;
  int? type;
  String? phone;
  int? wardId;
  Ward? ward;
  dynamic contactInfo;
  String? createdAt;
  String? updatedAt;
  num? priceUnit;
  String? expriredDay;
  int? isHot;
  List<LandImage>? images;
  List<dynamic>? videos;
  String? slug;
  String? publicUrl;
  num? commission;
  String? commissionUnit;
  num? originalPrice;
  num? commissionPrice;
  int? addCart;
  int? rte;
  int? slandStore;
  int? cart;
  String? code;
  var indexByCode;

  factory LandModel.fromJson(Map<String, dynamic> json) => LandModel(
        id: json["id"],
        landType: json["land_type"] != "" ? LandType.fromJson(json["land_type"]) : null,
        title: json["title"],
        price: json["price"],
        direction: json["direction"] != "" ? Direction.fromJson(json["direction"]) : null,
        address: json["address"],
        area: json["area"],
        href: json["href"],
        floor: json["floor"],
        description: json["description"],
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        userName: json["user_name"],
        userId: json["user_id"],
        status: json["status"],
        type: json["type"],
        phone: json["phone"],
        wardId: (json["ward_id"] == "" || json["ward_id"] == null) ? null : json["ward_id"],
        ward: Ward.fromJson((json["ward"] == "" || json["ward"] == null) ? {} : json["ward"]),
        contactInfo: json["contact_info"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        priceUnit: json["price_unit"] != "" ? json["price_unit"] : 0,
        expriredDay: json["exprired_day"],
        isHot: json["is_hot"],
        images: List<LandImage>.from(json["images"].map((x) => LandImage.fromJson(x))),
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
        slug: json["slug"],
        publicUrl: json["public_url"],
        commission: json["commission"],
        commissionUnit: json["commission_unit"],
        originalPrice: json["original_price"],
        commissionPrice: json["commission_price"],
        addCart: json["add_cart"],
        rte: json["rte"],
        slandStore: json["sland_store"],
        cart: json["cart"],
        code: json["code"],
        indexByCode: json["indexByCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "land_type": landType!.toJson(),
        "title": title,
        "price": price,
        "direction": direction!.toJson(),
        "address": address,
        "area": area,
        "href": href,
        "floor": floor,
        "description": description,
        "longitude": longitude,
        "latitude": latitude,
        "user_name": userName,
        "user_id": userId,
        "status": status,
        "type": type,
        "phone": phone,
        "ward_id": wardId,
        "ward": ward!.toJson(),
        "contact_info": contactInfo,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "price_unit": priceUnit,
        "exprired_day": expriredDay,
        "is_hot": isHot,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "videos": List<dynamic>.from(videos!.map((x) => x)),
        "slug": slug,
        "public_url": publicUrl,
        "commission": commission,
        "commission_unit": commissionUnit,
        "original_price": originalPrice,
        "commission_price": commissionPrice,
        "add_cart": addCart,
        "rte": rte,
        "sland_store": slandStore,
        "cart": cart,
        "code": code,
        "indexByCode": indexByCode,
      };

  static List<LandModel> listFromJson(List<dynamic>? listJson) =>
      listJson != null ? List<LandModel>.from(listJson.map((x) => LandModel.fromJson(x))) : [];

  String? getFirstPublicImage() {
    LandImage img = images!.firstWhere((image) => image.isPublic == 1,
        orElse: () => images!.firstWhere((image) => image.isPublic == 0));
    return img.path;
  }

  List<LandImage> getPublicImages() {
    List<LandImage> publicImages = [];
    images!.forEach((image) {
      if (image.isPublic == 1) {
        publicImages.add(image);
      }
    });
    return publicImages;
  }

  List<Map<String, dynamic>> getPublicMedias() {
    List<Map<String, dynamic>> publicMedias = [];
    images!.forEach((image) {
      if (image.isPublic == 1) {
        publicMedias.add({"image": image.path!, "is_public": true});
      }
    });
    videos!.forEach((video) {
      if (video["is_public"] == 1) {
        if (video["path"] != null) {
          publicMedias.add({"video": video["path"], "is_public": true});
        } else if (video["link_youtube"] != null) {
          publicMedias.add({"youtube": video["link_youtube"], "is_public": true});
        }
      }
    });
    return publicMedias;
  }

  List<Map<String, dynamic>> getAllMedias() {
    List<Map<String, dynamic>> medias = [];
    images!.forEach((image) {
      medias.add({"image": image.path!, "is_public": image.isPublic == 1 ? true : false});
    });
    videos!.forEach((video) {
      if (video["path"] != null) {
        medias.add({"video": video["path"], "is_public": video["is_public"] == 1 ? true : false});
      } else if (video["link_youtube"] != null) {
        medias.add({
          "youtube": video["link_youtube"],
          "is_public": video["is_public"] == 1 ? true : false
        });
      }
    });
    return medias;
  }
}

class LandImage {
  LandImage({
    this.id,
    this.path,
    this.isPublic,
  });

  int? id;
  String? path;
  int? isPublic;

  factory LandImage.fromJson(Map<String, dynamic> json) => LandImage(
        id: json["id"],
        path: json["path"],
        isPublic: json["is_public"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
        "is_public": isPublic,
      };
}

class Direction {
  Direction({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.slug,
  });

  int? id;
  dynamic createdAt;
  DateTime? updatedAt;
  String? name;
  String? slug;

  factory Direction.fromJson(Map<String, dynamic> json) => Direction(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        name: json["name"],
        slug: json["slug"] == null ? null : json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "name": name,
        "slug": slug == null ? null : slug,
      };
}
