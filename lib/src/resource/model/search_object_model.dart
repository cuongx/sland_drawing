class SearchObject {
  String? keyword;
  int? provinceId;
  int? districtId;
  int? wardId;
  int? landTypeId;
  int? areaMin;
  int? areaMax;
  int? filterMin;
  int? filterMax;
  int? directionId;
  String? fromDate;
  String? toDate;
  String? orderBy;
  int? slandStore;
  int? status;

  SearchObject(
      {this.keyword,
        this.provinceId,
        this.districtId,
        this.wardId,
        this.landTypeId,
        this.areaMin,
        this.areaMax,
        this.filterMin,
        this.filterMax,
        this.directionId,
        this.fromDate,
        this.toDate,
        this.orderBy,
        this.slandStore,
        this.status});
}
