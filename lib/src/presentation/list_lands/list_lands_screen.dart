import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../configs/configs.dart';
import '../../utils/utils.dart';
import '../presentation.dart';
import 'list_lands.dart';

class ListLandsScreen extends StatefulWidget {
  ListLandsScreen({this.initInfo});

  Map<String, dynamic>? initInfo;

  @override
  _ListLandsScreenState createState() => _ListLandsScreenState();
}

class _ListLandsScreenState extends State<ListLandsScreen> with ResponsiveWidget {
  late ListLandsViewModel listLandsViewModel;

  @override
  Widget build(BuildContext context) {
    print("initttt ${widget.initInfo}");
    return BaseWidget<ListLandsViewModel>(
        viewModel: ListLandsViewModel(),
        onViewModelReady: (viewModel) => listLandsViewModel = viewModel
          ..init(widget.initInfo?["type"], widget.initInfo?["provinceId"],
              widget.initInfo?["callFromSlandStore"]),
        builder: (context, viewModel, child) {
          return Scaffold(body: buildUi(context: context));
        });
  }

  Widget buildScreen() {
    int tab = listLandsViewModel.currentTab;
    return Column(children: [
      buildHeader(),
      if (tab == 0) Container(height: 15, color: Colors.white),
      ListFilterOptions(listFilterOptionsStream: listLandsViewModel.listOptionSubject.stream),
      Expanded(child: buildMap()),
      buildBottomBar()
    ]);
  }

  Widget buildHeader() {
    bool callFromSlandStore = widget.initInfo?["callFromSlandStore"];
    return AppHeader(
        headerColor: Colors.red,
        headerHeight: callFromSlandStore ? 50 : 80,
        headerImage: '',
        isApplyLeading: true,
        title: callFromSlandStore
            ? "map".tr
            : widget.initInfo?["type"] == 0
                ? "lands_for_sell".tr
                : "lands_for_rent".tr,
        titleColor: Colors.white);
  }

  // Widget buildAction() {
  //   return Container(
  //     height: 40,
  //     child: Row(
  //       children: [
  //         StreamBuilder(
  //           stream: listLandsViewModel.currentOrderOptionSubject.stream,
  //           builder: (context, AsyncSnapshot snapshot) {
  //             if (snapshot.hasData) {
  //               return buildOneAction(listLandsViewModel.getOrderOptionName(snapshot.data),
  //                   AppImages.icOrderBy, () => buildOrderByAction());
  //             } else {
  //               return Container();
  //             }
  //           },
  //         ),
  //         const Spacer(),
  //         buildOneAction(
  //             "filter".tr, AppImages.icFilter, () => listLandsViewModel.filterAction(false)),
  //       ],
  //     ),
  //   );
  // }

  // Widget buildOneAction(String contentOption, String iconOption, Function()? action) {
  //   return InkWell(
  //     child: Stack(
  //       children: [
  //         Container(
  //             height: 40,
  //             width: Get.width * 0.5 - 2,
  //             child: Image.asset(AppImages.headerModal, fit: BoxFit.cover)),
  //         Container(
  //           height: 40,
  //           width: Get.width * 0.5 - 2,
  //           alignment: Alignment.center,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Text(contentOption,
  //                   style: AppStyles.DEFAULT_MEDIUM_2.copyWith(color: Colors.white)),
  //               const SizedBox(width: 10),
  //               Image.asset(iconOption, height: 18, width: 18)
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //     onTap: action,
  //   );
  // }

  // buildOrderByAction() {
  //   AppDialog.showDialog(
  //       20,
  //       Container(
  //         height: 202.1,
  //         child: ListView.builder(
  //           itemCount: 5,
  //           itemBuilder: (context, index) {
  //             return Column(
  //               children: [
  //                 GestureDetector(
  //                   child: StreamBuilder(
  //                     stream: listLandsViewModel.currentOrderOptionSubject.stream,
  //                     builder: (context, AsyncSnapshot snapshot) => Container(
  //                       height: 40,
  //                       alignment: Alignment.center,
  //                       color: index == 0
  //                           ? AppColors.primary
  //                           : (index == snapshot.data ? Colors.grey.shade300 : Colors.white),
  //                       child: Text(
  //                           index == 0 ? "sort".tr : listLandsViewModel.getOrderOptionName(index),
  //                           style: AppStyles.DEFAULT_SMALL.copyWith(
  //                               color: index == 0 ? Colors.white : Colors.black,
  //                               fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
  //                               fontSize: index == 0 ? 15 : 14)),
  //                     ),
  //                   ),
  //                   onTap: index != 0
  //                       ? () {
  //                           listLandsViewModel.orderAction(index);
  //                         }
  //                       : null,
  //                 ),
  //                 index == 0 || index == 4
  //                     ? Container()
  //                     : Container(
  //                         height: 0.7,
  //                         color: Colors.grey.shade600,
  //                       )
  //               ],
  //             );
  //           },
  //         ),
  //       ));
  // }

  // Widget oneLandBuilder(List<dynamic> listLands, BuildContext context, int index) {
  //   return Column(
  //     children: [
  //       InkWell(
  //         child: Stack(
  //           children: [
  //             Container(
  //               height: 123,
  //               width: Get.width,
  //               child: Row(
  //                 children: [
  //                   listLands[index].images.length > 0
  //                       ? MyNetworkImage(
  //                           url: "${listLands[index].getFirstPublicImage()}",
  //                           height: 123,
  //                           width: 150)
  //                       : Image.asset(AppImages.noImage,
  //                           height: 123, width: 150, fit: BoxFit.cover),
  //                   Container(width: 5, color: Colors.white),
  //                   Expanded(
  //                     child: Container(
  //                       height: 123,
  //                       padding: const EdgeInsets.symmetric(horizontal: 5),
  //                       color: Colors.white,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Expanded(
  //                               child: Container(
  //                                   alignment: Alignment.topLeft,
  //                                   padding: const EdgeInsets.symmetric(vertical: 5),
  //                                   child: Column(
  //                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                                       crossAxisAlignment: CrossAxisAlignment.start,
  //                                       children: [
  //                                         Text(listLands[index].title,
  //                                             style: AppStyles.DEFAULT_SAN_BOLD
  //                                                 .copyWith(fontSize: 13.sp),
  //                                             maxLines: 1,
  //                                             overflow: TextOverflow.ellipsis,
  //                                             softWrap: false),
  //                                         Text(listLands[index].description,
  //                                             style:
  //                                                 AppStyles.DEFAULT_SMALL.copyWith(fontSize: 12.sp),
  //                                             maxLines: 3,
  //                                             overflow: TextOverflow.ellipsis,
  //                                             softWrap: false)
  //                                       ]))),
  //                           Container(
  //                             height: 30,
  //                             decoration: BoxDecoration(
  //                                 border: Border(
  //                                     top: BorderSide(width: 0.5, color: Colors.grey.shade400))),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               children: [
  //                                 Text(AppUtils.showMoney(listLands[index].price, true),
  //                                     style: defaultStyle()),
  //                                 const SizedBox(width: 8),
  //                                 Text("${listLands[index].area}m2", style: defaultStyle()),
  //                                 // Spacer(),
  //                                 Expanded(
  //                                   child: Container(
  //                                     alignment: Alignment.centerRight,
  //                                     child: Text(
  //                                         listLands[index].status == 0
  //                                             ? "Chưa duyệt"
  //                                             : "${listLands[index].updatedAt}",
  //                                         style: listLands[index].status == 0
  //                                             ? AppStyles.DEFAULT_UTM_HELEVE
  //                                                 .copyWith(color: AppColors.red, fontSize: 11.sp)
  //                                             : AppStyles.DEFAULT_SAN.copyWith(fontSize: 11.sp),
  //                                         maxLines: 1,
  //                                         overflow: TextOverflow.ellipsis,
  //                                         softWrap: false),
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             listLands[index].isHot == 1
  //                 ? Align(
  //                     alignment: Alignment.topRight,
  //                     child: Image.asset(
  //                       AppImages.icHot,
  //                       height: Get.height * 0.06,
  //                     ))
  //                 : const SizedBox()
  //           ],
  //         ),
  //         onTap: () async {
  //           await Navigator.pushNamed(context, Routers.landDetail,
  //               arguments: {"landId": listLands[index].id, "userSpecial": null}).then((value) {
  //             if (value != null) {
  //               listLandsViewModel.keyListView.currentState!.onRefresh();
  //             }
  //           });
  //         },
  //       ),
  //       Container(
  //         height: 10,
  //         color: Colors.grey.shade300,
  //       )
  //     ],
  //   );
  // }
  //
  // TextStyle defaultStyle() => AppStyles.DEFAULT_SAN_BOLD.copyWith(fontSize: 11.sp);

  // Widget buildListLands() {
  //   return Expanded(
  //       child: Container(
  //           alignment: Alignment.topCenter,
  //           color: Colors.white,
  //           child: StreamBuilder(
  //               stream: listLandsViewModel.searchData.stream,
  //               builder: (context, AsyncSnapshot snapshot) {
  //                 if (snapshot.hasData) {
  //                   return MyListView.build(
  //                       key: listLandsViewModel.keyListView,
  //                       itemBuilder: oneLandBuilder,
  //                       dataRequester: listLandsViewModel.dataRequester,
  //                       initRequester: listLandsViewModel.initRequester);
  //                 } else {
  //                   return MyLoading();
  //                 }
  //               })));
  // }

  Widget buildMap() {
    return Stack(children: [
      GestureDetector(
        onPanStart: listLandsViewModel.disableDraw ? null : listLandsViewModel.onPanStart,
        onPanUpdate: listLandsViewModel.disableDraw ? null : listLandsViewModel.onPanUpdate,
        onPanEnd: listLandsViewModel.disableDraw ? null : listLandsViewModel.onPanEnd,
        child: StreamBuilder(
            stream: listLandsViewModel.markersSubject,
            builder: (context, AsyncSnapshot markers) {
              return GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  print("onMapCreated  ${controller}");
                  listLandsViewModel.mapController?.dispose();
                  listLandsViewModel.mapController = controller;
                },
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(AppPrefs.provinceGeo.lat ?? AppValues.DEFAULT_LATITUDE,
                      AppPrefs.provinceGeo.lng ?? AppValues.DEFAULT_LONGITUDE),
                  zoom: 13,
                ),
                polygons: listLandsViewModel.polygons,
                markers: (markers.data ?? <Marker>[]).toSet(),
              );
            }),
      ),
      StreamBuilder(
        stream: listLandsViewModel.drawingPoints,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return CustomPaint(size: Size.zero, painter: DrawingPainter(pointsList: snapshot.data));
          } else {
            return Container();
          }
        },
      ),
      Container(
          height: 35,
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            StreamBuilder(
                stream: listLandsViewModel.drawButton.stream,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data == 1
                        ? Container()
                        : InkWell(
                            child: Container(
                              height: 30,
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: const BorderRadius.all(Radius.circular(4))),
                              child: Row(
                                children: [
                                  Icon(
                                    snapshot.data == 2 ? Icons.traffic_sharp : Icons.pentagon,
                                    size: 17,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(snapshot.data == 2 ? 'Hủy' : "Vẽ tay",
                                      style:
                                          AppStyles.DEFAULT_MEDIUM_2.copyWith(color: Colors.white))
                                ],
                              ),
                            ),
                            onTap: () {
                              listLandsViewModel.handleDrawOnMap();
                            });
                  } else {
                    return Container();
                  }
                }),
            const SizedBox(width: 10),
            StreamBuilder(
                stream: listLandsViewModel.startFilterButton.stream,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data) {
                      return InkWell(
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: const BorderRadius.all(Radius.circular(4))),
                          child: Text('Tiến hành lọc',
                              style: AppStyles.DEFAULT_MEDIUM_2.copyWith(color: Colors.white)),
                        ),
                        onTap: () async {
                          await listLandsViewModel.filterByPolygon();
                        },
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                }),
            const Spacer(),
            InkWell(
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Text("Lọc tiêu chí",
                      style: AppStyles.DEFAULT_MEDIUM_2.copyWith(color: Colors.white)),
                ),
                onTap: () {
                  listLandsViewModel.filterAction(widget.initInfo?["callFromSlandStore"]);
                })
          ])),
      StreamBuilder(
          stream: listLandsViewModel.loadingSubject,
          builder: (context, AsyncSnapshot snapshot) {
            bool status = snapshot.data ?? true;
            return status
                ? Container(
                    constraints: const BoxConstraints.expand(),
                    color: Colors.black26,
                    child: const CircularProgressIndicator())
                : Container();
          })
    ]);
  }

  Widget buildBottomBar() {
    return widget.initInfo?["callFromSlandStore"]
        ? Container()
        : Container(
            height: 60,
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(width: 0.3, color: Colors.grey))),
            child: Row(
              children: [
                buildBottomBarItem('', "list".tr, 0),
                buildBottomBarItem('', "map".tr, 1),
              ],
            ),
          );
  }

  // Tab Danh sách: selectedTab = true, Tab Bản đồ: selectedTab = false
  Widget buildBottomBarItem(String iconItem, String contentItem, int index) {
    return InkWell(
      child: Container(
        width: Get.width / 2,
        alignment: Alignment.center,
        color: listLandsViewModel.currentTab == index
            ? Colors.grey.withOpacity(0.2)
            : Colors.grey.withOpacity(0.45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            Text(contentItem, style: AppStyles.DEFAULT_MEDIUM_2.copyWith(color: AppColors.primary))
          ],
        ),
      ),
      onTap: () => listLandsViewModel.onTapBottomItem(index),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    return buildScreen();
  }

  @override
  Widget buildTablet(BuildContext context) {
    return buildScreen();
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return const SizedBox();
  }
}
