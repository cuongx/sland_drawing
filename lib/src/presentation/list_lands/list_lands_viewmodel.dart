import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/src/presentation/list_lands/widgets/widget_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:get/get.dart';
import '../../resource/resource.dart';
import '../presentation.dart';
import 'marker_generator.dart';

class ListLandsViewModel extends BaseViewModel {
  // GlobalKey<MyListViewState> keyListView = GlobalKey();
  int? _type; // để xác định là nhà đất bán hay nhà đất cho thuê
  int currentTab = 0;
  int? _provinceId; // tỉnh/thành phố đã chọn ở Navigation
  final listOptionSubject = BehaviorSubject<List<String>>();
  final currentOrderOptionSubject = BehaviorSubject<int>();
  final searchData = BehaviorSubject<SearchObject>();
  final startFilterButton = BehaviorSubject<bool>(); // kiểm soát việc hiển thị button TIẾN HÀNH LỌC
  final drawButton = BehaviorSubject<
      int>(); // kiểm soát việc hiển thị button VẼ TAY/HỦY, 0: VẼ TAY, 1: ẩn button, 2: HỦY
  bool drawPolygonEnabled = false;
  final Set<Polygon> polygons = Set<Polygon>(); // lưu trữ tập hợp các polygon đã vẽ
  Color strokeColor = Colors.red;
  double strokeWidth = 3.0;
  final drawingPoints =
      BehaviorSubject<List<DrawingPoints>>(); // danh sách tập hợp các điểm của từng polygon
  List<LatLng> listLatLngPolygon = []; // danh sách các điểm LatLng có trong tất cả polygon đã vẽ
  GoogleMapController? mapController;
  List<Marker> originalMarkers = []; // lưu trữ lại các markers trước khi bấm button VẼ TAY
  final markersSubject =
      BehaviorSubject<List<Marker>>.seeded([]); // lắng nghe sự thay đổi của markers data

  bool get disableDraw => !drawPolygonEnabled || listLatLngPolygon.length != 0;

  init(int? type, int? provinceId, bool callFromSlandStore) async {
    // precacheImage(AssetImage(AppImages.icMark), Get.context!);
    _type = type;
    _provinceId = provinceId;
    setLoading(callFromSlandStore ? false : true);
    SearchObject searchObject = SearchObject(
      orderBy: getOrderOption(4),
      provinceId: _provinceId,
      slandStore: callFromSlandStore ? 1 : null,
    );
    drawingPoints.sink.add([]);
    drawButton.sink.add(0);
    startFilterButton.sink.add(false);
    if (callFromSlandStore) currentTab = 1;
    currentOrderOptionSubject.sink.add(4);
    searchData.sink.add(searchObject);
    listOptionSubject.sink.add(List.generate(10, (index) => ""));
  }

  List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps, List<LandModel>? lands) {
    List<Marker> markersList = [];
    bitmaps.asMap().forEach((i, bmp) {
      LandModel? land = lands?[i];
      markersList.add(Marker(
          markerId: MarkerId(land!.id.toString()),
          position: LatLng(land.latitude!, land.longitude!),
          infoWindow: InfoWindow(
              title: land.title,
              onTap: () {
                // openQuickViewBox(land);
              }),
          icon: BitmapDescriptor.fromBytes(bmp)));
    });
    return markersList;
  }
  //
  // openQuickViewBox(LandModel? land) {
  //   AppDialog.showDialog(0, WidgetQuickView(land: land));
  // }

  Future<void> addMarker([bool first = false]) async {
    //preload
    if (first) {
      MarkerGenerator([WidgetMarker(price: 3.4)], (bitmaps) {
        markersSubject.add([
          Marker(
              markerId: const MarkerId('id'),
              position: const LatLng(16.0, 107.0),
              icon: BitmapDescriptor.fromBytes(bitmaps.first))
        ]);
      }).generate(context);
    }

    setLoading(true);
    // List<LandModel>? lands = await getListLands(_type, 1, numItem: 300);
    //
    // List<Widget>? markerWidgets = lands.map((land) => WidgetMarker(price: land.price)).toList();
    // MarkerGenerator(markerWidgets, (bitmaps) {
    //   markersSubject.add(mapBitmapsToMarkers(bitmaps, lands));
    //   setLoading(false);
    // }).generate(context);
  }

  // Future<List<LandModel>> initRequester() async {
  //   return await getListLands(_type, 1);
  // }
  //
  // Future<List<LandModel>> dataRequester(int currentPage) async {
  //   return await getListLands(_type, currentPage);
  // }

  // Future<List<LandModel>> getListLands(int? type, int pageNumber, {int numItem = 20}) async {
  //   NetworkState<ListLandModel> result =
  //       await landRepository.getListLands(_type, numItem, pageNumber, searchData.stream.value);
  //   if (result.isSuccess) {
  //     List<LandModel>? lands = result.data!.lands;
  //     return lands!;
  //   } else {
  //     return [];
  //   }
  // }

  getOrderOption(int option) {
    switch (option) {
      case 1:
        return "asc";
      case 2:
        return "desc";
      case 3:
        return "oldest";
      case 4:
        return "latest";
    }
  }

  getOrderOptionName(int option) {
    switch (option) {
      case 1:
        return "asc".tr;
      case 2:
        return "desc".tr;
      case 3:
        return "oldest".tr;
      case 4:
        return "latest".tr;
    }
  }

  getOrderOptionIndex(String orderBy) {
    switch (orderBy) {
      case "asc":
        return 1;
      case "desc":
        return 2;
      case "oldest":
        return 3;
      case "latest":
        return 4;
    }
  }

  orderAction(int index) {
    currentOrderOptionSubject.sink.add(index);
    SearchObject searchObject = searchData.stream.value;
    searchObject.orderBy = getOrderOption(index);
    searchData.sink.add(searchObject);
    Navigator.of(Get.overlayContext!).pop();
    // keyListView.currentState!.onRefresh();
  }

  onTapBottomItem(int index) async {
    if (index != currentTab) {
      currentTab = index;
      notifyListeners();
      if (index == 1) {
        // Nhấn vào tab Bản đồ
        await addMarker(true);
      } else {
        // Nhấn vào tab Danh sách
        setLoading(false);
        drawButton.sink.add(0);
        startFilterButton.sink.add(false);
        if (drawPolygonEnabled) drawPolygonEnabled = false;
        markersSubject.value = [];
        originalMarkers = [];
        clearPolygons();
      }
    }
  }

  handleDrawOnMap() async {
    if (drawButton.stream.value == 0) {
      drawButton.sink.add(1);
      originalMarkers = List.from(markersSubject.value);
      markersSubject.value = [];
    } else if (drawButton.stream.value == 2) {
      markersSubject.value = originalMarkers;
      drawButton.sink.add(0);
    }
    drawPolygonEnabled = !drawPolygonEnabled;
    clearPolygons();
    startFilterButton.sink.add(false);
  }

  onPanUpdate(DragUpdateDetails details) {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    print("onPanUpdate ${details.localPosition}");
    print("globalToLocal ${renderBox!.globalToLocal(details.localPosition)}");
    List<DrawingPoints> temp = drawingPoints.stream.value;
    temp.add(DrawingPoints(
        points: renderBox.globalToLocal(details.localPosition),
        paint: Paint()
          ..isAntiAlias = true
          ..color = strokeColor
          ..strokeWidth = strokeWidth));
    drawingPoints.sink.add(temp);
  }

  onPanStart(DragStartDetails details) {
    drawButton.sink.add(1);
    startFilterButton.sink.add(false);
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    List<DrawingPoints> temp = drawingPoints.stream.value;
    print("onPanStart ${details.localPosition}");
    print("globalToLocal ${renderBox!.globalToLocal(details.localPosition)}");
    temp.add(DrawingPoints(
      points: renderBox.globalToLocal(details.localPosition),
      paint: Paint()
        ..isAntiAlias = true
        ..color = strokeColor
        ..strokeWidth = strokeWidth,
    ));
    drawingPoints.sink.add(temp);
  }

  onPanEnd(DragEndDetails details) {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    drawButton.sink.add(2);
    startFilterButton.sink.add(true);
    List<DrawingPoints> temp = drawingPoints.stream.value;
    temp.add(DrawingPoints(points: null, paint: null));
    drawingPoints.sink.add(temp);
    List<Offset?> shape = [];
    drawingPoints.stream.value.forEach((point) {
      shape.add(point.points);
    });
    buildPolygon(shape);
  }

  buildPolygon(List<Offset?> shape) async {
    final List<LatLng> points = <LatLng>[];
    // final devicePixelRatio = Get.pixelRatio;
    final devicePixelRatio = Get.pixelRatio;
    await Future.forEach(shape, (Offset? offset) async {
      if (offset == null) {
      } else {
        LatLng? point = await mapController?.getLatLng(
          ScreenCoordinate(
            x: (offset.dx * devicePixelRatio).round(),
            y: (offset.dy * devicePixelRatio).round(),
          ),
        );
        if (point != null) {
          points.add(point);
          listLatLngPolygon.add(point);
        }
      }
    });
    // shape.forEach((Offset? offset) async {
    //   if (offset == null) {
    //   } else {
    //     ScreenCoordinate coordinate;
    //     if (Platform.isIOS) {
    //       coordinate = ScreenCoordinate(x: offset.dx.round(), y: offset.dy.round());
    //     } else {
    //       coordinate = ScreenCoordinate(
    //           x: (offset.dx * devicePixelRatio).round(), y: (offset.dy * devicePixelRatio).round());
    //     }
    //     LatLng? point = await mapController?.getLatLng(coordinate);
    //     print("pointpoint ${point}");
    //     if (point != null) {
    //       points.add(point);
    //       listLatLngPolygon.add(point);
    //     }
    //   }
    // });

    const PolygonId finalPolygonId = PolygonId("1");
    polygons.add(Polygon(
      polygonId: finalPolygonId,
      strokeColor: Colors.red,
      strokeWidth: 3,
      fillColor: Colors.red.withOpacity(0.5),
      points: points,
    ));

    Timer(const Duration(milliseconds: 200), () {
      notifyListeners();
    });
  }

  clearPolygons() {
    drawingPoints.sink.add([]);
    listLatLngPolygon = [];
    polygons.clear();
    notifyListeners();
  }

  filterAction(bool callFromSlandStore) {
    // Get.toNamed(Routers.filter, arguments: {
    //   "type": _type,
    //   "generalProvinceId": _provinceId,
    //   "listOptionSubject": listOptionSubject.stream.value,
    //   "searchObject": searchData.stream.value
    // })!
    //     .then((resultBack) async {
    //   if (resultBack != null) {
    //     if (resultBack["searchObject"].orderBy != null) {
    //       currentOrderOptionSubject.sink
    //           .add(getOrderOptionIndex(resultBack["searchObject"].orderBy));
    //     }
    //     listOptionSubject.sink.add(resultBack["listFilterOptions"]);
    //     SearchObject temp = resultBack["searchObject"];
    //     if (callFromSlandStore) temp.slandStore = 1;
    //     searchData.sink.add(temp);
    //
    //     if (currentTab == 1) {
    //       setLoading(true);
    //       if (listLatLngPolygon.length > 0) {
    //         filterByPolygon();
    //       } else {
    //         await addMarker();
    //       }
    //     } else {
    //       // keyListView.currentState!.onRefresh();
    //     }
    //   }
    // });
  }

  filterByPolygon() async {
    startFilterButton.sink.add(false);
    drawingPoints.sink.add([]);
    String dataPolygon = "";
    List<LandModel>? lands = [];
    // setLoading(true);
    print("listLatLngPolygon ${listLatLngPolygon}");
    for (int i = 0; i < listLatLngPolygon.length; i++) {
      dataPolygon += "${listLatLngPolygon[i].longitude} ${listLatLngPolygon[i].latitude},";
    }

    dataPolygon += "${listLatLngPolygon[0].longitude} ${listLatLngPolygon[0].latitude}";
    MarkerGenerator([
      WidgetMarker(price: 3.4),
      WidgetMarker(price: 5.4),
      WidgetMarker(price: 3.4),
      WidgetMarker(price: 3.4)
    ], (bitmaps) {
      markersSubject.sink.add([
        Marker(
            markerId: const MarkerId('1'),
            position: const LatLng(16.463411577155, 107.61703232831),
            icon: BitmapDescriptor.fromBytes(bitmaps.first)),
        Marker(
            markerId: const MarkerId('2'),
            position: const LatLng(16.463411577155, 107.61703232831),
            icon: BitmapDescriptor.fromBytes(bitmaps.first)),
        Marker(
            markerId: const MarkerId('3'),
            position: const LatLng(16.463411577155, 107.61703232831),
            icon: BitmapDescriptor.fromBytes(bitmaps.first)),
        Marker(
            markerId: const MarkerId('4'),
            position: const LatLng(16.0, 107.0),
            icon: BitmapDescriptor.fromBytes(bitmaps.first))
      ]);
    }).generate(context);
    markersSubject.sink.add([
      Marker(
          markerId: const MarkerId('1'),
          position: const LatLng(16.463411577155, 107.61703232831),
          icon: BitmapDescriptor.fromBytes(Uint8List(137))),
      Marker(
          markerId: const MarkerId('2'),
          position: const LatLng(16.649538743211398, 107.50618133731359),
          icon: BitmapDescriptor.fromBytes(Uint8List(115)))
    ]);

    print("markersSubject ${markersSubject.value.length}");
    // NetworkState<ListLandModel>? result =
    //     await authRepository.getLandsByPolygon(dataPolygon, _type, searchData.stream.value);
    // print("resultresult ${result.data}");
    // if (result.isSuccess) {
    //   if (result.data != null) {
    //     lands = result.data!.lands;
    //   }
    // }
    //
    // if (lands != []) {
    lands = [
      LandModel(title: "1", latitude: 16.483411577155, longitude: 109.61703232831),
      LandModel(title: "2", latitude: 16.649538743211398, longitude: 107.50618133731359),
    ];
    List<Widget> markerWidgets =
        markersSubject.value.map((land) => WidgetMarker(price: 1500)).toList();
    MarkerGenerator(markerWidgets, (bitmaps) {
      // markersSubject.value = mapBitmapsToMarkers(bitmaps, lands);
      setLoading(false);
    }).generate(context);
  }

  @override
  void dispose() {
    super.dispose();
    searchData.close();
    currentOrderOptionSubject.close();
    listOptionSubject.close();
    drawButton.close();
    startFilterButton.close();
    markersSubject.close();
    drawingPoints.close();
    mapController?.dispose();
  }
}
